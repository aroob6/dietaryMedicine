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
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!

    
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var kakaoButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    @Injected private var loginViewModel: LoginViewModel
    
    // id, pw
    private var idText: String = ""
    private var pwText: String = ""

    //RxSwift
    @Injected private var disposeBag : DisposeBag
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bindButton()
        bindLogin()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setUI() {
        idTextField.text = "test7@naver.com"
        pwTextField.text = "qwerqwer"
        
        idTextField.delegate = self
        pwTextField.delegate = self
    }
    
    private func bindButton() {
        loginButton.rx.tap.bind { [weak self] in
            self?.loginAction()
        }.disposed(by: disposeBag)
        
        emailButton.rx.tap.bind { [weak self] in
            self?.moveSignUp()
        }.disposed(by: disposeBag)
    }
    
    private func requestLogin() {
        let parameters: [String: String] = [
            "email": idText,
            "password": pwText
        ]
        
        loginViewModel.fetch(parameters: parameters)
    }
    
    private func bindLogin() {
        loginViewModel.output.data.asDriver(onErrorDriveWith: Driver.empty())
            .drive { result in
                switch result {
                case .success(let loginData):
                    if !loginData.token.isEmpty {
                        self.requestLoginSuccess(loginData)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func requestLoginSuccess(_ result: Login) {
        print("✅: LOGIN NET SUCCESS")
        
        UserDefaultsManager.token = result.token
        Info.share.name = result.name
        Info.share.email = result.email
        moveMainView()
    }

    func moveMainView() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let main = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        main.modalPresentationStyle = .fullScreen

        self.present(main, animated: false)
    }
    
    func moveSignUp() {
        let vc = EmailSignUpViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func loginAction() {
        guard let idText = idTextField.text, !idText.isEmpty else {
            idTextField.shakeTextField()
            let msg = "아이디를 입력하세요"
            UtilFunction.showMessage(msg: msg, vc: self)
            return
        }
        guard let pwText = pwTextField.text, !pwText.isEmpty else {
            pwTextField.shakeTextField()
            let msg = "비밀번호를 입력하세요"
            UtilFunction.showMessage(msg: msg, vc: self)
            return
        }
        self.idText = idText
        self.pwText = pwText
        
        requestLogin()
    }
    
}

// MARK: - UITextField Delegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextResponder = textField.superview?.viewWithTag(textField.tag + 1) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
