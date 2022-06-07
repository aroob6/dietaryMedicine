//
//  SignUpViewController.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/27.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Resolver

class EmailLoginViewController: BaseEmailSignUpViewController {

    private var emailLabel = UILabel()
    private var pwlLabel = UILabel()
    
    private var emailTextField = UITextField()
    private var pwTextField = UITextField()
    
    private var signUpButton = UIButton()
    
    private var emailUnderLine = UIView()
    private var pwUnderLine = UIView()
    
    @Injected private var signUpViewModel: SignUpViewModel
    
    //RxSwift
    @Injected private var disposeBag : DisposeBag
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationTitle(string: "로그인")
        
        setUI()
        bindButton()
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(signUpButton)
        
        signUpButton.backgroundColor = .black
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.bottom.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }
        
    }

    private func bindButton() {
        signUpButton.rx.tap.bind { [weak self] in
            self?.signUpAction()
        }.disposed(by: disposeBag)
    }
    
    private func signUpAction() {
        let vc = EmailSignUpViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
}

