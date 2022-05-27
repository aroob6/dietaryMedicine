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
    @IBOutlet var signUpButton: UIButton!
    
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

        bindButton()
        bindSignUp()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    private func bindButton() {
        signUpButton.rx.tap.bind { [weak self] in
            self?.signUpAction()
        }.disposed(by: disposeBag)
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
    
    @objc func signUpAction() {
        guard let emailText = emailTextField.text, !emailText.isEmpty else {
            let msg = "이메일을 입력하세요"
            UtilFunction.showMessage(msg: msg, vc: self)
            return
        }
        
        guard let pwText = pwTextField.text, !pwText.isEmpty else {
            let msg = "비밀번호를 입력하세요"
            UtilFunction.showMessage(msg: msg, vc: self)
            return
        }
        
        guard let nameText = nameTextField.text, !nameText.isEmpty else {
            let msg = "이름을 입력하세요"
            UtilFunction.showMessage(msg: msg, vc: self)
            return
        }
        
        guard let birthText = birthTextField.text, !birthText.isEmpty else {
            let msg = "생년월일을 입력하세요"
            UtilFunction.showMessage(msg: msg, vc: self)
            return
        }

        switch genderSementedControl.selectedSegmentIndex {
        case 0:
            genderText = "m"
        case 1:
            genderText = "f"
        default :
            return
        }
        
        let year = birthText.substring(from: 0, to: 1)
        let month = birthText.substring(from: 2, to: 3)
        let day = birthText.substring(from: 4, to: 5)
        
        self.emailText = emailText
        self.pwText = pwText
        self.nameText = nameText
        self.birthText = "19" + year + "-" + month + "-" + day
        
        requestSignUp()
    }
}

extension String {
    func substring(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else {
            return ""
        }
        
        // Index 값 획득
        let startIndex = index(self.startIndex, offsetBy: from)
        let endIndex = index(self.startIndex, offsetBy: to + 1) // '+1'이 있는 이유: endIndex는 문자열의 마지막 그 다음을 가리키기 때문
        
        // 파싱
        return String(self[startIndex ..< endIndex])
    }
}
