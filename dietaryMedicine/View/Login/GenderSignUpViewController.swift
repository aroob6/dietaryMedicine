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

class GenderSignUpViewController: UIViewController {

    private var stackView: UIStackView = {
        let view = UIStackView().then {
            $0.backgroundColor = .clear
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fillProportionally
        }
        return view
    }()
    
    private var progressBar = UIProgressView()
    private var titleLabel = UILabel()
    private var manButton = UIButton()
    private var femaleButton = UIButton()
    private var nextButton = UIButton()
    
    private var genderText = ""
    
    @Injected private var disposeBag : DisposeBag
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        bindButton()
    }

    private func setUI() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "프로필 설정"
        self.view.addSubview(progressBar)
        self.view.addSubview(stackView)
        self.view.addSubview(nextButton)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.setCustomSpacing(15, after: titleLabel)
        stackView.addArrangedSubview(manButton)
        stackView.setCustomSpacing(15, after: manButton)
        stackView.addArrangedSubview(femaleButton)
        
        progressBar.tintColor = .mainColor
        progressBar.setProgress(0.3, animated: false)
        progressBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
        stackView.snp.makeConstraints {
            $0.height.equalTo(160)
            $0.top.equalTo(progressBar.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.setTitle("다음", for: .normal)
        nextButton.backgroundColor = .textGray
        nextButton.isEnabled = false
        nextButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.bottom.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        titleLabel.text = "성별을 선택해주세요."
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        manButton.setTitle("남성", for: .normal)
        manButton.setTitleColor(.black, for: .normal)
        manButton.backgroundColor = .white
        manButton.layer.borderWidth = 1
        manButton.layer.borderColor = UIColor.lightGray.cgColor
        manButton.layer.cornerRadius = 8
        manButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        femaleButton.setTitle("여성", for: .normal)
        femaleButton.setTitleColor(.black, for: .normal)
        femaleButton.backgroundColor = .white
        femaleButton.layer.borderWidth = 1
        femaleButton.layer.borderColor = UIColor.lightGray.cgColor
        femaleButton.layer.cornerRadius = 8
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
        manButton.backgroundColor = .mainColor
        manButton.setTitleColor(.white, for: .normal)
        
        femaleButton.backgroundColor = .white
        femaleButton.setTitleColor(.black, for: .normal)
        
        nextButton.backgroundColor = .mainColor
        nextButton.isEnabled = true
    }
    
    private func femaleButtonSelect() {
        genderText = "f"
        femaleButton.backgroundColor = .mainColor
        femaleButton.setTitleColor(.white, for: .normal)
        
        manButton.backgroundColor = .white
        manButton.setTitleColor(.black, for: .normal)
        
        nextButton.backgroundColor = .mainColor
        nextButton.isEnabled = true
    }
    
    private func nextAction() {
        SignParameter.share.gender = genderText
        
        let vc = BirthSignUpViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

