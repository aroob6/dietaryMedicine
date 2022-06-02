//
//  EmailSignUpViewController.swift
//  dietaryMedicine
//
//  Created by bora on 2022/06/02.
//

import UIKit

class SignParameter {
    static let share = SignParameter()
    var email = ""
    var pw = ""
    var name = ""
    var birth = ""
    var gender = ""
}

class EmailSignUpViewController: UIViewController {
    private var stackView: UIStackView = {
        let view = UIStackView().then {
            $0.backgroundColor = .clear
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fillProportionally
        }
        return view
    }()
    
    private var emailLabel = UILabel()
    private var emailTextField = UITextField()
    private var pwLabel = UILabel()
    private var pwTextField = UITextField()
    private var rePwLabel = UILabel()
    private var rePwTextField = UITextField()
    private var nextButton = UIButton()
    
    private var emailUnderLine = UIView()
    private var pwUnderLine = UIView()
    private var rePwUnderLine = UIView()
    
    private var emailText = ""
    private var pwText = ""
    private var rePwText = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setUI() {
        self.navigationItem.title = "회원가입"
        self.view.backgroundColor = .white
        self.view.addSubview(stackView)
        self.view.addSubview(nextButton)
        
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(emailUnderLine)
        stackView.setCustomSpacing(10, after: emailUnderLine)
        stackView.addArrangedSubview(pwLabel)
        stackView.addArrangedSubview(pwTextField)
        stackView.addArrangedSubview(pwUnderLine)
        stackView.setCustomSpacing(10, after: pwUnderLine)
        stackView.addArrangedSubview(rePwLabel)
        stackView.addArrangedSubview(rePwTextField)
        stackView.addArrangedSubview(rePwUnderLine)
        
        stackView.snp.makeConstraints {
            $0.height.equalTo(203)
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.setTitle("다음", for: .normal)
        nextButton.backgroundColor = .textGray
        nextButton.isEnabled = false
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        nextButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.bottom.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        emailUnderLine.backgroundColor = .mainGray
        emailUnderLine.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        pwUnderLine.backgroundColor = .mainGray
        pwUnderLine.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        rePwUnderLine.backgroundColor = .mainGray
        rePwUnderLine.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
        emailLabel.text = "이메일"
        pwLabel.text = "비밀번호"
        rePwLabel.text = "비밀번호 확인"
        
        emailTextField.placeholder = "이메일을 입력하세요"
        pwTextField.placeholder = "비밀번호를 입력하세요"
        rePwTextField.placeholder = "비밀번호를 입력하세요"
        
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
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    @objc func textFieldDidChange() {
        if emailTextField.text != "" && pwTextField.text != "" && rePwTextField.text != "" {
            nextButton.isEnabled = true
            nextButton.backgroundColor = .mainColor
        }
        else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = .textGray
        }
    }
    
    @objc func nextAction() {
        guard let emailText = emailTextField.text, isValidEmail(email: emailText) else {
            let msg = "이메일 형식으로 입력하세요"
            UtilFunction.showMessage(msg: msg, vc: self)
            return
        }
        
        guard let pwText = pwTextField.text, let rePwText = rePwTextField.text, pwText == rePwText else {
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
