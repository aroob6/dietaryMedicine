//
//  GenderSignUpViewController.swift
//  dietaryMedicine
//
//  Created by bora on 2022/06/02.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Resolver

class GenderSignUpViewController: BaseEmailSignUpViewController {
    
    private var titleLabel = UILabel()
    private var manButton = UIButton()
    private var femaleButton = UIButton()
    
    private var genderText = ""
    
    @Injected private var disposeBag : DisposeBag
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        bindButton()
    }
    
    

    private func setUI() {
        navigationTitle()
        self.view.addSubview(progressBar)
        self.view.addSubview(stackView)
        self.view.addSubview(nextButton)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.setCustomSpacing(15, after: titleLabel)
        stackView.addArrangedSubview(manButton)
        stackView.setCustomSpacing(15, after: manButton)
        stackView.addArrangedSubview(femaleButton)
        
        setProgressBar(size: 0.3)
        progressBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        stackView.snp.makeConstraints {
            $0.height.equalTo(160)
            $0.top.equalTo(progressBar.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.setTitle("다음", for: .normal)
        deEnableNextBtn()
        nextButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        titleLabel.text = "성별을 선택해주세요."
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        manButton.setTitle("남성", for: .normal)
        manButton.layer.cornerRadius = 8
        deSelectButton(button: manButton)
        manButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        femaleButton.setTitle("여성", for: .normal)
        femaleButton.layer.cornerRadius = 8
        deSelectButton(button: femaleButton)
        femaleButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
    }

    private func bindButton() {
        manButton.rx.tap.bind { [weak self] in
            self?.manButtonSelect()
        }.disposed(by: disposeBag)
        
        femaleButton.rx.tap.bind { [weak self] in
            self?.femaleButtonSelect()
        }.disposed(by: disposeBag)
        
        nextButton.rx.tap.bind { [weak self] in
            self?.nextAction()
        }.disposed(by: disposeBag)
    }
    
    private func manButtonSelect() {
        genderText = "m"
        selectButton(button: manButton)
        deSelectButton(button: femaleButton)
        
        enableNextBtn()
    }
    
    private func femaleButtonSelect() {
        genderText = "f"
        
        selectButton(button: femaleButton)
        deSelectButton(button: manButton)
        
        enableNextBtn()
    }
    
    private func nextAction() {
        SignParameter.share.gender = genderText
        
        let vc = NameBirthSignUpViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    private func selectButton(button: UIButton){
        button.backgroundColor = .mainColor
        button.layer.borderColor = UIColor.mainColor?.cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(.white, for: .normal)
        
    }
    
    private func deSelectButton(button: UIButton){
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(.black, for: .normal)
    }
}

