//
//  KeyboardManager.swift
//  dietaryMedicine
//
//  Created by bora on 2022/06/16.
//

import UIKit

class KeyboardManager {
    private var btn = UIButton()
    private var set = true //true면 btn, false stackView
    
    init(btn: UIButton, set: Bool) {
        self.btn = btn
        self.set = set
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
            
            if set {
                btn.snp.updateConstraints {
                    $0.height.equalTo(60)
                    $0.leading.trailing.equalToSuperview()
                    $0.bottom.equalToSuperview().offset(-keyboardHeight)
                }
            }
            else {
                //
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) { //키보드 내려갈때
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keybaordRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keybaordRectangle.height
            if set {
                btn.snp.updateConstraints {
                    $0.height.equalTo(60)
                    $0.bottom.leading.trailing.equalToSuperview()
                }
            }
            else {
                //
            }
        }
    }

}
