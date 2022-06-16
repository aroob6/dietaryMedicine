//
//  UIButton.swift
//  dietaryMedicine
//
//  Created by bora on 2022/06/16.
//

import UIKit

extension UIButton {
    func enableBth() {
        self.isEnabled = true
        self.backgroundColor = .mainColor
        self.setTitleColor(.white, for: .normal)
    }
    
    func deEnableBtn() {
        self.isEnabled = false
        self.backgroundColor = .textGray
        self.setTitleColor(.white, for: .normal)
    }
}
