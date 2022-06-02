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

class SignUpViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var birthTextField: UITextField!
    @IBOutlet var genderSementedControl: UISegmentedControl!
    
    
    private var signUpButton = UIButton()
    
    private var emailText = ""
    private var pwText = ""
    private var nameText = ""
    private var birthText = ""
    private var genderText = ""
    
    @Injected private var signUpViewModel: SignUpViewModel
    
    //RxSwift
    @Injected private var disposeBag : DisposeBag
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindButton()
//        bindSignUp()
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
    
    private func bindSignUp() {
        signUpViewModel.output.data.asDriver(onErrorDriveWith: Driver.empty())
            .drive() { result in
                switch result {
                case .success(let code):
                    if code == 2000 {
                        self.requestSignUpSuccess()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }.disposed(by: disposeBag)
    }
    
    private func requestSignUp() {
        let parameters: [String: String] = [
            "email": emailText,
            "password": pwText,
            "name": nameText,
            "birth_date": birthText,
            "gender": genderText
        ]
        
        signUpViewModel.fetch(parameters: parameters)
    }
    
    private func requestSignUpSuccess() {
        print("✅: SIGNUP NET SUCCESS")
        
        self.dismiss(animated: false, completion: nil)
    }
    
//    @objc func signUpAction() {
//        guard let emailText = emailTextField.text, !emailText.isEmpty else {
//            let msg = "이메일을 입력하세요"
//            UtilFunction.showMessage(msg: msg, vc: self)
//            return
//        }
//
//        guard let pwText = pwTextField.text, !pwText.isEmpty else {
//            let msg = "비밀번호를 입력하세요"
//            UtilFunction.showMessage(msg: msg, vc: self)
//            return
//        }
//
//        guard let nameText = nameTextField.text, !nameText.isEmpty else {
//            let msg = "이름을 입력하세요"
//            UtilFunction.showMessage(msg: msg, vc: self)
//            return
//        }
//
//        guard let birthText = birthTextField.text, !birthText.isEmpty else {
//            let msg = "생년월일을 입력하세요"
//            UtilFunction.showMessage(msg: msg, vc: self)
//            return
//        }
//
//        switch genderSementedControl.selectedSegmentIndex {
//        case 0:
//            genderText = "m"
//        case 1:
//            genderText = "f"
//        default :
//            return
//        }
//
//        let year = birthText.substring(from: 0, to: 1)
//        let month = birthText.substring(from: 2, to: 3)
//        let day = birthText.substring(from: 4, to: 5)
//
//        self.emailText = emailText
//        self.pwText = pwText
//        self.nameText = nameText
//        self.birthText = "19" + year + "-" + month + "-" + day
//
//        requestSignUp()
//    }
}

