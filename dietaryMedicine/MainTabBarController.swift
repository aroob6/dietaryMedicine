//
//  MainTabBarController.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/15.
//

import UIKit

class MainTabBarController: UITabBarController {

    let tabBartitle = ["홈", "검색", "마이페이지"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTabBarItem()
    }
    
    func setTabBarItem() {
        guard let items = tabBar.items else { return }
        items[0].title = tabBartitle[0]
        items[1].title = tabBartitle[1]
        items[2].title = tabBartitle[2]
        
        items[0].image = UIImage(systemName: "house")
        items[1].image = UIImage(systemName: "magnifyingglass")
        items[2].image = UIImage(systemName: "person.fill")
    }
    
}
