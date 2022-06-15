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

class MyPageViewController: UIViewController {

    @IBOutlet var name: UILabel!
    @IBOutlet var versionLabel: UILabel!
    @IBOutlet var logOut: UIView!
    
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
        let tabGesture = UITapGestureRecognizer()
        logOut.addGestureRecognizer(tabGesture)
        
        tabGesture.rx.event.bind { [weak self] _ in
            self?.logOutAction()
        }.disposed(by: disposeBag)
    }
    
    private func logOutAction() {
        UserDefaultsManager.token = ""
        self.dismiss(animated: false)
    }
}
