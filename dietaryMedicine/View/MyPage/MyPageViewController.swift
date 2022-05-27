//
//  MyPageViewController.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/27.
//

import UIKit
import SnapKit
import Then

class MyPageViewController: UIViewController {

    @IBOutlet var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = Info.share.email

    }
   
}
