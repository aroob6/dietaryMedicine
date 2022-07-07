//
//  MyPageViewController.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/27.
//

import UIKit
import SnapKit
import Then
import Resolver
import RxSwift
import RxCocoa
import RxGesture
import AcknowList

class MyPageViewController: UIViewController {

    @IBOutlet var name: UILabel!
    @IBOutlet var versionLabel: UILabel!
    @IBOutlet var logOutView: UIView!
    @IBOutlet var lincenseView: UIView!
    
    @Injected private var disposeBag : DisposeBag
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindButton()
    }
    
    private func setUI() {
        name.text = Info.share.name
        versionLabel.text = UIApplication.appVersion ?? ""
    }
   
    private func bindButton() {
        logOutView.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                self?.logOutAction()
            }.disposed(by: disposeBag)
        
        lincenseView.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                self?.lincenseAction()
            }.disposed(by: disposeBag)
    }
    
    private func logOutAction() {
        UserDefaultsManager.token = ""
        self.dismiss(animated: false)
    }
    
    private func lincenseAction() {
        let acknowList = AcknowListViewController(fileNamed: "Pods-dietaryMedicine-acknowledgements")
        navigationController?.pushViewController(acknowList, animated: true)
    }
}
