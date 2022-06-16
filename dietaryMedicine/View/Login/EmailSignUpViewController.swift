//
//  EmailSignUpViewController.swift
//  dietaryMedicine
//
//  Created by bora on 2022/06/02.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Resolver

class EmailSignUpViewController: BaseEmailSignUpViewController {
    var emailStackView: UIStackView = {
        let view = UIStackView().then {
            $0.backgroundColor = .clear
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fillProportionally
        }
        return view
    }()
    
    private var emailView = UIView()
    private var emailLabel = UILabel()
    private var pwLabel = UILabel()
    private var rePwLabel = UILabel()
    private var emailTextField = UITextField()
    private var pwTextField = UITextField()
    private var rePwTextField = UITextField()
    private var emailCheckButton = UIButton()
    
    private var emailText = ""
    private var emailCheck = false

    @Injected private var checkViewModel: CheckViewModel
    @Injected private var disposeBag : DisposeBag
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setTextField()
        bindButton()
        bindEmailCheck()
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
        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(underLine1)
        stackView.setCustomSpacing(10, after: underLine1)
        stackView.addArrangedSubview(pwLabel)
        stackView.addArrangedSubview(pwTextField)
        stackView.addArrangedSubview(underLine2)
        stackView.setCustomSpacing(10, after: underLine2)
        stackView.addArrangedSubview(rePwLabel)
        stackView.addArrangedSubview(rePwTextField)
        stackView.addArrangedSubview(underLine3)
        
        emailView.addSubview(emailTextField)
        emailView.addSubview(emailCheckButton)
        
        stackView.snp.makeConstraints {
            $0.height.equalTo(203)
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }
        
        emailView.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        nextButton.setTitle("다음", for: .normal)
        nextButton.deEnableBtn()
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
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        pwTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        rePwTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        
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
            $0.width.equalTo(220)
            $0.height.equalTo(40)
            $0.leading.centerY.equalToSuperview()
        }
        pwTextField.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        rePwTextField.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        emailCheckButton.setTitle("중복확인", for: .normal)
        emailCheckButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        emailCheckButton.backgroundColor = .textGray
        emailCheckButton.layer.cornerRadius = 8
        emailCheckButton.snp.makeConstraints {
            $0.width.equalTo(60)
            $0.height.equalTo(30)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
    }
    
    private func setTextField() {
        emailTextField.delegate = self
        pwTextField.delegate = self
    }
    
    private func bindButton() {
        nextButton.rx.tap.bind { [weak self] in
            self?.nextAction()
        }.disposed(by: disposeBag)
        emailCheckButton.rx.tap.bind { [weak self] in
            self?.emailCheckAction()
        }.disposed(by: disposeBag)
    }
    
    private func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    private func isValidPassword(pwd: String) -> Bool {
        let passwordRegEx = "^[a-zA-Z0-9]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: pwd)
    }
    
    private func nextAction() {
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
    
    private func emailCheckAction() {
        if emailTextField.text == "" {
            let msg = "이메일을 입력해주세요"
            UtilFunction.showMessage(msg: msg, vc: self)
        }
        else {
            guard let emailText = emailTextField.text, isValidEmail(email: emailText) else {
                emailTextField.shakeTextField()
                let msg = "이메일 형식으로 입력하세요"
                UtilFunction.showMessage(msg: msg, vc: self)
                return
            }
            
            self.emailText = emailText
            requestEmailCheck()
        }
    }
    
    private func requestEmailCheck() {
        let parameters: [String: String] = [
            "email": emailText
        ]
        checkViewModel.checkType = .email
        checkViewModel.fetch(parameters: parameters)
    }
    
    private func bindEmailCheck() {
        checkViewModel.output.data.asDriver(onErrorDriveWith: Driver.empty()).drive { result in
            switch result {
            case .success(let data):
                if data == 0 { //중복이 아닌 경우
                    self.emailCheckButton.enableBth()
                    self.emailCheck = true
                    let msg = "이메일 중복이 아닙니다"
                    UtilFunction.showMessage(msg: msg, vc: self)
                    print("✅: EMAILCHECK NOT DUPLICATE")
                }
                else { // 1 중복인 경우
                    let msg = "이메일 중복 입니다"
                    UtilFunction.showMessage(msg: msg, vc: self)
                    print("✅: EMAILCHECK DUPLICATE")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        .disposed(by: disposeBag)
    }
    
    @objc func textFieldDidChange(sender: UITextField) {
        switch sender {
        case emailTextField:
            emailCheckButton.backgroundColor = .textGray
            emailCheckButton.isEnabled = true
            emailCheck = false
        case pwTextField:
            print("pwTextField")
        case rePwTextField:
            print("rePwTextField")
        default:
            return
        }
        if emailCheck && emailTextField.text != "" && pwTextField.text != "" && rePwTextField.text != "" {
            nextButton.enableBth()
        }
        else {
            nextButton.deEnableBtn()
        }
    }
}
