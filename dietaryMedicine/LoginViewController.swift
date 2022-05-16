//
//  ViewController.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/15.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpButton()
    }
    
    func setUpButton() {
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
    }

    @objc func loginAction() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let main = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        main.modalPresentationStyle = .fullScreen
        self.present(main, animated: false)
    }
}

