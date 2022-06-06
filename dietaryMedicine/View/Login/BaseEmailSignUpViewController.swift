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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
    }
    
    func setProgressBar(size: Float) {
        progressBar.tintColor = .mainColor
        progressBar.setProgress(size, animated: false)
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
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keybaordRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keybaordRectangle.height
            nextButton.frame.origin.y -= keyboardHeight
//            nextButton.frame.origin.y = 427
            
            nextButton.layoutSubviews()
            print("333", nextButton.frame.origin.y)
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keybaordRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keybaordRectangle.height
            nextButton.frame.origin.y += keyboardHeight
        }
    }
    
}
