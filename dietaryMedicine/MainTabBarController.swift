//
//  MainTabBarController.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/15.
//

import UIKit

class MainTabBarController: UITabBarController {

    let tabBartitle = ["Main", "Article", "Setting"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTabBarItem()
    }
    
    func setTabBarItem() {
//        let tabMainItem = UITabBarItem(
//            title: "Main", image: nil, tag: 0
//        )
//
//        let tabArticleItem = UITabBarItem(
//            title: "Article", image: nil, tag: 1
//        )
//
//        let tabSettingItem = UITabBarItem(
//            title: "Setting", image: nil, tag: 2
//        )
//
//
//
//        self.viewControllers = [
//        ]
        
        guard let items = tabBar.items else { return }
        items[0].title = tabBartitle[0]
        items[1].title = tabBartitle[1]
        items[2].title = tabBartitle[2]
    }
    
}
