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
    
    @Injected private var loginViewModel: LoginViewModel
    
    //RxSwift
    @Injected private var disposeBag : DisposeBag

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        bindLogin()
    }
    

    private func setUI() {
        navigationTitle()
        
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
        
        titleLabel.text = "회원가입을 완료했습니다."
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
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func requestLogin() {
        let parameters: [String: String] = [
            "email": SignParameter.share.email,
            "password": SignParameter.share.pw
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
    
    @objc func completeAction() {
        requestLogin()
    }
    
    func moveMainView() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let main = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        main.modalPresentationStyle = .fullScreen

        self.present(main, animated: false)
    }

}
