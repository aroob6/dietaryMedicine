//
//  UIWindow.swift
//  dietaryMedicine
//
//  Created by bora on 2022/06/15.
//

import UIKit

extension UIWindow {
    func switchRootViewController(
        _ viewController: UIViewController,
        animated: Bool = true,
        duration: TimeInterval = 0.5,
        options: UIView.AnimationOptions = .transitionCrossDissolve,
        completion: (() -> Void)? = nil
    ) {
        guard animated else {
            rootViewController = viewController
            return
        }
        
        UIView.transition(
            with: self,
            duration: duration,
            options: options, animations: {
                let oldState = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                self.rootViewController = viewController
                UIView.setAnimationsEnabled(oldState)
            }
        ) { _ in
            completion?()
        }
    }
}
