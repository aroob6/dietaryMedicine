//
//  ViewController.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/15.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Resolver

class LoginViewController: UIViewController {
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var kakaoButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!

    //RxSwift
    @Injected private var disposeBag : DisposeBag
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindButton()
     
    }
    private func setUI() {
    
        appleButton.layer.cornerRadius = 8
        kakaoButton.layer.cornerRadius = 8
        googleButton.layer.cornerRadius = 8
        emailButton.layer.cornerRadius = 8
    }
    
    private func bindButton() {
        emailButton.rx.tap.bind { [weak self] in
            self?.moveSignUp()
        }.disposed(by: disposeBag)
    }
    
    private func moveSignUp() {
        let vc = EmailLoginViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

