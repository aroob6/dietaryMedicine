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
    var buttonStackView: UIStackView = {
        let view = UIStackView().then {
            $0.backgroundColor = .clear
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fillProportionally
        }
        return view
    }()

    private var emailLabel = UILabel()
    private var pwLabel = UILabel()
    
    private var emailTextField = UITextField()
    private var pwTextField = UITextField()
    
    private var signUpButton = UIButton()
    private var rePwButton = UIButton()
    
    // email, pw
    private var emailText: String = ""
    private var pwText: String = ""
    
    @Injected private var loginViewModel: LoginViewModel
    
    //RxSwift
    @Injected private var disposeBag : DisposeBag
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.text = "test7@naver.com"
        pwTextField.text = "qwerqwer"
        
        setUI()
        setTextField()
        bindButton()
        bindLogin()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotification()
    }
    
    private func setUI() {
        navigationTitle(string: "로그인")
        self.view.backgroundColor = .white
        self.view.addSubview(stackView)
        self.view.addSubview(buttonStackView)
        self.view.addSubview(nextButton)
        
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(underLine1)
        stackView.setCustomSpacing(10, after: underLine1)
        stackView.addArrangedSubview(pwLabel)
        stackView.addArrangedSubview(pwTextField)
        stackView.addArrangedSubview(underLine2)
        
        buttonStackView.addArrangedSubview(signUpButton)
        buttonStackView.addArrangedSubview(rePwButton)
        
        stackView.snp.makeConstraints {
            $0.height.equalTo(132)
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.equalTo(stackView.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(100)
        }
        
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.setTitleColor(.underLine, for: .normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        signUpButton.snp.makeConstraints {
            $0.height.equalTo(30)
        }

        rePwButton.setTitle("비밀번호 재설정", for: .normal)
        rePwButton.setTitleColor(.underLine, for: .normal)
        rePwButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        rePwButton.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        nextButton.setTitle("다음", for: .normal)
//        deEnableNextBtn()
        enableNextBtn()
        nextButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        emailLabel.text = "이메일"
        pwLabel.text = "비밀번호"
        emailLabel.font = UIFont.systemFont(ofSize: 12)
        pwLabel.font = UIFont.systemFont(ofSize: 12)

        emailTextField.placeholder = "이메일 입력"
        pwTextField.placeholder = "비밀번호 입력"
        emailTextField.font = UIFont.systemFont(ofSize: 16)
        pwTextField.font = UIFont.systemFont(ofSize: 16)
        
        emailTextField.keyboardType = .emailAddress
        pwTextField.isSecureTextEntry = true
        
        emailLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        pwLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        emailTextField.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        pwTextField.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        pwTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

    }
    
    private func setTextField() {
        emailTextField.delegate = self
        pwTextField.delegate = self
    }

    private func bindButton() {
        nextButton.rx.tap.bind { [weak self] in
            self?.nextAction()
        }.disposed(by: disposeBag)
        
        signUpButton.rx.tap.bind { [weak self] in
            self?.signUpAction()
        }.disposed(by: disposeBag)
        
    }
    
    private func signUpAction() {
        let vc = EmailSignUpViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    private func requestLogin() {
        let parameters: [String: String] = [
            "email": emailText,
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

    private func moveMainView() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let main = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        main.modalPresentationStyle = .fullScreen

        self.present(main, animated: false)
    }

    @objc func textFieldDidChange() {
        if emailTextField.text != "" && pwTextField.text != "" {
            enableNextBtn()
        }
        else {
            deEnableNextBtn()
        }
    }
    
    @objc func nextAction() {
        guard let emailText = emailTextField.text, !emailText.isEmpty else {
            emailTextField.shakeTextField()
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
        self.emailText = emailText
        self.pwText = pwText
        
        requestLogin()
    }
    
}
