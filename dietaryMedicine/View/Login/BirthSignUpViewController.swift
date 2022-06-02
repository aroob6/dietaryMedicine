//
//  BirthSignUpViewController.swift
//  dietaryMedicine
//
//  Created by bora on 2022/06/02.
//

import UIKit
import SnapKit

class BirthSignUpViewController: BaseEmailSignUpViewController {
    
    private var titleLabel = UILabel()
    private var birthTextField = UITextField()
    private var birthUnderLine = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
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
        
        titleLabel.text = "생일을 입력해주세요."
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
    
    @objc func nextAction() {
        SignParameter.share.birth = birthTextField.text ?? ""
        
        let vc = CompleteViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func textFieldDidChange() {
        guard let birthText = birthTextField.text else { return }
        birthText.count == 6  ? enableNextBtn() : deEnableNextBtn()
    }

}
