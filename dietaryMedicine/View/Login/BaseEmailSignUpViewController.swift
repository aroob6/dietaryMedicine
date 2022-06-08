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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
        
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
    
    func enableNextBtn() {
        nextButton.isEnabled = true
        nextButton.backgroundColor = .mainColor
        nextButton.setTitleColor(.white, for: .normal)
    }
    
    func deEnableNextBtn() {
        nextButton.isEnabled = false
        nextButton.backgroundColor = .textGray
        nextButton.setTitleColor(.white, for: .normal)
    }
    
    func addKeyboardNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    func removeKeyboardNotification(){
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) { //키보드 올라올떄
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keybaordRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keybaordRectangle.height
            
            nextButton.snp.updateConstraints {
                $0.height.equalTo(60)
                $0.leading.trailing.equalToSuperview()
                $0.bottom.equalToSuperview().offset(-keyboardHeight)
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) { //키보드 내려갈때
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            nextButton.snp.updateConstraints {
                $0.height.equalTo(60)
                $0.bottom.leading.trailing.equalToSuperview()
            }
        }
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
