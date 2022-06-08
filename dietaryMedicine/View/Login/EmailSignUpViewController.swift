//
//  EmailSignUpViewController.swift
//  dietaryMedicine
//
//  Created by bora on 2022/06/02.
//

import UIKit

class EmailSignUpViewController: BaseEmailSignUpViewController {
    
    
    private var emailLabel = UILabel()
    private var pwLabel = UILabel()
    private var rePwLabel = UILabel()
    private var emailTextField = UITextField()
    private var pwTextField = UITextField()
    private var rePwTextField = UITextField()
    
    private var emailText = ""
    private var pwText = ""
    private var rePwText = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setTextField()
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
        navigationTitle()
        self.view.addSubview(stackView)
        self.view.addSubview(nextButton)
        
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(underLine1)
        stackView.setCustomSpacing(10, after: underLine1)
        stackView.addArrangedSubview(pwLabel)
        stackView.addArrangedSubview(pwTextField)
        stackView.addArrangedSubview(underLine2)
        stackView.setCustomSpacing(10, after: underLine2)
        stackView.addArrangedSubview(rePwLabel)
        stackView.addArrangedSubview(rePwTextField)
        stackView.addArrangedSubview(underLine3)
        
        stackView.snp.makeConstraints {
            $0.height.equalTo(203)
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.setTitle("다음", for: .normal)
        deEnableNextBtn()
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        nextButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        emailLabel.text = "이메일"
        pwLabel.text = "비밀번호"
        rePwLabel.text = "비밀번호 확인"
        
        emailLabel.font = UIFont.systemFont(ofSize: 12)
        pwLabel.font = UIFont.systemFont(ofSize: 12)
        rePwLabel.font = UIFont.systemFont(ofSize: 12)
        
        emailTextField.placeholder = "이메일을 입력하세요"
        pwTextField.placeholder = "소문자, 대문자, 숫자 8자리 이상으로 입력하세요"
        rePwTextField.placeholder = "소문자, 대문자, 숫자 8자리 이상으로 입력하세요"
        
        emailTextField.font = UIFont.systemFont(ofSize: 12)
        pwTextField.font = UIFont.systemFont(ofSize: 12)
        rePwTextField.font = UIFont.systemFont(ofSize: 12)
        
        emailTextField.keyboardType = .emailAddress
        pwTextField.isSecureTextEntry = true
        rePwTextField.isSecureTextEntry = true
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        pwTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        rePwTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        emailLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        pwLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        rePwLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        emailTextField.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        pwTextField.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        rePwTextField.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
    }
    
    private func setTextField() {
        emailTextField.delegate = self
        pwTextField.delegate = self
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func isValidPassword(pwd: String) -> Bool {
        let passwordRegEx = "^[a-zA-Z0-9]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: pwd)
    }
    
    @objc func textFieldDidChange() {
        if emailTextField.text != "" && pwTextField.text != "" && rePwTextField.text != "" {
            enableNextBtn()
        }
        else {
            deEnableNextBtn()
        }
    }
    
    @objc func nextAction() {
        guard let emailText = emailTextField.text, isValidEmail(email: emailText) else {
            emailTextField.shakeTextField()
            let msg = "이메일 형식으로 입력하세요"
            UtilFunction.showMessage(msg: msg, vc: self)
            return
        }
        
        guard let pwText = pwTextField.text, isValidPassword(pwd: pwText) else {
            pwTextField.shakeTextField()
            let msg = "비밀번호 형식을 확인해 주세요"
            UtilFunction.showMessage(msg: msg, vc: self)
            return
        }
        
        guard let rePwText = rePwTextField.text, pwText == rePwText else {
            rePwTextField.shakeTextField()
            let msg = "비밀번호가 같지 않습니다"
            UtilFunction.showMessage(msg: msg, vc: self)
            return
        }
        
        SignParameter.share.email = emailText
        SignParameter.share.pw = pwText
        
        let vc = GenderSignUpViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
