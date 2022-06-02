//
//  CompleteViewController.swift
//  dietaryMedicine
//
//  Created by bora on 2022/06/02.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Resolver

class CompleteViewController: BaseEmailSignUpViewController {

    private var logoImg = UIImageView()
    private var titleLabel = UILabel()
    
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
        self.view.addSubview(logoImg)
        self.view.addSubview(titleLabel)
        self.view.addSubview(nextButton)
        
        progressBar.tintColor = .mainColor
        progressBar.setProgress(1, animated: false)
        progressBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        logoImg.image = UIImage(named: "logo")
        logoImg.snp.makeConstraints {
            $0.height.equalTo(150)
            $0.top.equalTo(progressBar.snp.bottom).offset(100)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(80)
        }
        
        titleLabel.text = "프로필 설정을 완료했습니다."
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.top.equalTo(logoImg.snp.bottom).offset(100)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(80)
        }
        
        nextButton.setTitle("시작하기", for: .normal)
        nextButton.backgroundColor = .mainColor
        nextButton.addTarget(self, action: #selector(completeAction), for: .touchUpInside)
        nextButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.bottom.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func bindSignUp() {
        signUpViewModel.output.data.asDriver(onErrorDriveWith: Driver.empty())
            .drive() { result in
                switch result {
                case .success(let code):
                    if code == 2000 {
                        self.requestSignUpSuccess()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }.disposed(by: disposeBag)
    }
    
    private func requestSignUpSuccess() {
        print("✅: SIGNUP NET SUCCESS")
        
        self.navigationController?.popToRootViewController(animated: false)
//        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//        let main = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
//        main.modalPresentationStyle = .fullScreen
//
//        self.present(main, animated: false)
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
    
    @objc func completeAction() {
        
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

}


extension String {
    func substring(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else {
            return ""
        }
        // Index 값 획득
        let startIndex = index(self.startIndex, offsetBy: from)
        let endIndex = index(self.startIndex, offsetBy: to + 1) // '+1'이 있는 이유: endIndex는 문자열의 마지막 그 다음을 가리키기 때문
    
        // 파싱
        return String(self[startIndex ..< endIndex])
    }
}
