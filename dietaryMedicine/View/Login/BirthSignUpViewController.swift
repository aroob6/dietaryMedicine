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

class BirthSignUpViewController: BaseEmailSignUpViewController {
    
    private var titleLabel = UILabel()
    private var birthTextField = UITextField()
    private var birthUnderLine = UIView()
    
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
        bindSignUp()
    }
    
    private func setUI() {
        navigationTitle(string: "프로필 설정")
        
        self.view.addSubview(progressBar)
        self.view.addSubview(stackView)
        self.view.addSubview(nextButton)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.setCustomSpacing(15, after: titleLabel)
        stackView.addArrangedSubview(birthTextField)
        stackView.setCustomSpacing(15, after: birthTextField)
        stackView.addArrangedSubview(birthUnderLine)
        
        setProgressBar(size: 0.6)
        progressBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        stackView.snp.makeConstraints {
            $0.height.equalTo(101)
            $0.top.equalTo(progressBar.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.setTitle("다음", for: .normal)
        deEnableNextBtn()
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        nextButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.bottom.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        birthUnderLine.backgroundColor = .mainGray
        birthUnderLine.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
        titleLabel.text = "생년월일을 입력해주세요."
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        birthTextField.placeholder = "생년월일 6자리를 입력해주세요."
        birthTextField.keyboardType = .numberPad
        birthTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        birthTextField.snp.makeConstraints {
            $0.height.equalTo(40)
        }
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
            "email": emailText,
            "password": pwText,
            "name": nameText,
            "birth_date": birthText,
            "gender": genderText
        ]
        
        signUpViewModel.fetch(parameters: parameters)
    }
    
    @objc func nextAction() {
        SignParameter.share.birth = birthTextField.text ?? ""
        
        let year = SignParameter.share.birth.substring(from: 0, to: 1)
        let month = SignParameter.share.birth.substring(from: 2, to: 3)
        let day = SignParameter.share.birth.substring(from: 4, to: 5)
        
        emailText = SignParameter.share.email
        pwText = SignParameter.share.pw
        nameText = SignParameter.share.name
        birthText = "19" + year + "-" + month + "-" + day
        genderText = SignParameter.share.gender
        
        requestSignUp()
    }
    
    @objc func textFieldDidChange() {
        guard let birthText = birthTextField.text else { return }
        birthText.count == 6  ? enableNextBtn() : deEnableNextBtn()
    }

}
