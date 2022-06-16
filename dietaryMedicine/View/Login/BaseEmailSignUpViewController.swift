//
//  BaseEmailSignUpViewController.swift
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

class BaseEmailSignUpViewController: UIViewController {
    
    var stackView: UIStackView = {
        let view = UIStackView().then {
            $0.backgroundColor = .clear
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fillProportionally
        }
        return view
    }()
    
    var progressBar = UIProgressView()
    var nextButton = UIButton()
    
    var underLine1 = UIView()
    var underLine2 = UIView()
    var underLine3 = UIView()
    
    var keyBoardManager: KeyboardManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
        keyBoardManager = KeyboardManager(btn: nextButton, set: true)
        
        underLine1.backgroundColor = .underLine
        underLine2.backgroundColor = .underLine
        underLine3.backgroundColor = .underLine
        
        underLine1.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        underLine2.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        underLine3.snp.makeConstraints {
            $0.height.equalTo(1)
        }
    }
    
    func setProgressBar(size: Float) {
        progressBar.tintColor = .mainColor
        progressBar.setProgress(size, animated: false)
    }
    
    func navigationTitle() {
        self.navigationItem.title = "회원가입"
    }
    
    func navigationTitle(string: String) {
        self.navigationItem.title = string
    }
    
    func addKeyboardNotification() {
        keyBoardManager?.addKeyboardNotification()
    }
    
    func removeKeyboardNotification(){
        keyBoardManager?.removeKeyboardNotification()
    }
    
}

// MARK: - UITextField Delegate
extension BaseEmailSignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextResponder = textField.superview?.viewWithTag(textField.tag + 1) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
