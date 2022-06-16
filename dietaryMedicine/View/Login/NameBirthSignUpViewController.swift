//
//  BirthSignUpViewController.swift
//  dietaryMedicine
//
//  Created by bora on 2022/06/02.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Resolver

class NameBirthSignUpViewController: BaseEmailSignUpViewController {
    
    private var nameView = UIView()
    private var nameLabel = UILabel()
    private var birthLabel = UILabel()
    
    private var nameTextField = UITextField()
    private var birthTextField = UITextField()
    private var nameCheckButton = UIButton()
    
    private var nameCheck = false
    
    @Injected private var signUpViewModel: SignUpViewModel
    @Injected private var checkViewModel: CheckViewModel
    @Injected private var disposeBag : DisposeBag

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        bindButton()
        bindSignUp()
        bindNameCheck()
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
        
        self.view.addSubview(progressBar)
        self.view.addSubview(stackView)
        self.view.addSubview(nextButton)
        
        stackView.addArrangedSubview(nameLabel)
//        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(nameView)
        stackView.addArrangedSubview(underLine1)
        stackView.setCustomSpacing(20, after: underLine1)
        
        stackView.addArrangedSubview(birthLabel)
        stackView.addArrangedSubview(birthTextField)
        stackView.addArrangedSubview(underLine2)
        
        nameView.addSubview(nameTextField)
        nameView.addSubview(nameCheckButton)
        
        setProgressBar(size: 0.6)
        progressBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        stackView.snp.makeConstraints {
            $0.height.equalTo(162)
            $0.top.equalTo(progressBar.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.setTitle("다음", for: .normal)
        nextButton.deEnableBtn()
        nextButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        nameView.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        nameLabel.text = "닉네임을 입력해주세요."
        birthLabel.text = "생년월일을 입력해주세요."
        
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        birthLabel.font = UIFont.systemFont(ofSize: 12)
        
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        birthLabel.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        nameTextField.placeholder = "닉네임을 입력해주세요."
        birthTextField.placeholder = "생년월일 6자리를 입력해주세요."
        
        nameTextField.font = UIFont.systemFont(ofSize: 12)
        birthTextField.font = UIFont.systemFont(ofSize: 12)
        
        birthTextField.keyboardType = .numberPad
        
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        birthTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        
        nameTextField.snp.makeConstraints {
            $0.width.equalTo(220)
            $0.height.equalTo(40)
            $0.leading.centerY.equalToSuperview()
        }
        birthTextField.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        nameCheckButton.setTitle("중복확인", for: .normal)
        nameCheckButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        nameCheckButton.backgroundColor = .textGray
        nameCheckButton.layer.cornerRadius = 8
        nameCheckButton.snp.makeConstraints {
            $0.width.equalTo(60)
            $0.height.equalTo(30)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    private func bindButton() {
        nextButton.rx.tap.bind { [weak self] in
            self?.nextAction()
        }.disposed(by: disposeBag)
        
        nameCheckButton.rx.tap.bind { [weak self] in
            self?.nameCheckAction()
        }.disposed(by: disposeBag)
    }
    
    private func bindSignUp() {
        signUpViewModel.output.data.asDriver(onErrorDriveWith: Driver.empty())
            .drive() { result in
                switch result {
                case .success(let code):
                    if code == .success {
                        self.requestSignUpSuccess()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }.disposed(by: disposeBag)
    }
    
    private func requestSignUpSuccess() {
        print("✅: SIGNUP NET SUCCESS")
        
        let vc = CompleteViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    private func requestSignUp() {
        let parameters: [String: String] = [
            "email": SignParameter.share.email,
            "password": SignParameter.share.pw,
            "name": SignParameter.share.name,
            "birth_date": SignParameter.share.birth,
            "gender": SignParameter.share.gender
        ]
        
        signUpViewModel.fetch(parameters: parameters)
    }
    
    private func nextAction() {
        guard let birthText = birthTextField.text else {
            return
        }
        
        let year = birthText.substring(from: 0, to: 1)
        let month = birthText.substring(from: 2, to: 3)
        let day = birthText.substring(from: 4, to: 5)
        
        SignParameter.share.birth = "19" + year + "-" + month + "-" + day
        
        requestSignUp()
    }
    
    private func nameCheckAction() {
        guard let nameText = nameTextField.text, nameText != "" else {
            let msg = "닉네임을 입력해주세요"
            UtilFunction.showMessage(msg: msg, vc: self)
            return
        }
        SignParameter.share.name = nameText
        requestNameCheck()
    }
    
    private func requestNameCheck() {
        let parameters: [String: String] = [
            "name": SignParameter.share.name
        ]
        checkViewModel.checkType = .name
        checkViewModel.fetch(parameters: parameters)
    }
    
    private func bindNameCheck() {
        checkViewModel.output.data.asDriver(onErrorDriveWith: Driver.empty()).drive { result in
            switch result {
            case .success(let data):
                if data == 0 { //중복이 아닌 경우
                    self.nameCheckButton.enableBth()
                    self.nameCheck = true
                    let msg = "닉네임 중복이 아닙니다"
                    UtilFunction.showMessage(msg: msg, vc: self)
                    print("✅: NICKNAME NOT DUPLICATE")
                }
                else { // 1 중복인 경우
                    let msg = "닉네임 중복 입니다"
                    UtilFunction.showMessage(msg: msg, vc: self)
                    print("✅: NICKNAME DUPLICATE")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        .disposed(by: disposeBag)
    }
    
    @objc func textFieldDidChange(sender: UITextField) {
        switch sender {
        case nameTextField:
            nameCheckButton.backgroundColor = .textGray
            nameCheckButton.isEnabled = true
            nameCheck = false
        case birthTextField:
            print("birthTextField")
        default:
            return
        }
        
        guard let nameText = nameTextField.text else { return }
        guard let birthText = birthTextField.text else { return }
        nameText.count != 0 && birthText.count == 6  ? nextButton.enableBth() : nextButton.deEnableBtn()
    }

}
