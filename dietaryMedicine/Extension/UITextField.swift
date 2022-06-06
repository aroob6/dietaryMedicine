//
//  UITextField.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/06/04.
//

import UIKit

extension UITextField {
    func shakeTextField() -> Void{
        UIView.animate(withDuration: 0.2, animations: {
            self.frame.origin.x -= 10
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                self.frame.origin.x += 20
             }, completion: { _ in
                 UIView.animate(withDuration: 0.2, animations: {
                    self.frame.origin.x -= 10
                })
            })
        })
    }
}
