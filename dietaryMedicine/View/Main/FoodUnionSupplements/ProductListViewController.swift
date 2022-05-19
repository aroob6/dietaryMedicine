//
//  ProductListViewController.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/16.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak var customTabBar: UICollectionView!
    @IBOutlet weak var foodView: UIView!
    @IBOutlet weak var supplementsView: UIView!
    
    let tabBarTitle = ["식품", "영양제"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpCollectionView()
    }
    
    func setUpView() {
        self.navigationItem.title = "식품 or 영양제"
        supplementsView.isHidden = true
    }
    func setUpCollectionView() {
        customTabBar.delegate = self
        customTabBar.dataSource = self
        
        let tabBarLayout = UICollectionViewFlowLayout()
        tabBarLayout.itemSize = CGSize.init(width: self.view.frame.width / 2, height: 50)
        tabBarLayout.minimumLineSpacing = 0
        tabBarLayout.minimumInteritemSpacing = 0
        customTabBar.collectionViewLayout = tabBarLayout
    }
}

extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabBarTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tabBarCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomTabBarCell", for: indexPath) as! CustomTabBarCell
        tabBarCell.tabBarTitle.text = tabBarTitle[indexPath.row]
        tabBarCell.deselectTabItem()
        if indexPath.row == 0 {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
            tabBarCell.isSelected = true
        }
        return tabBarCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            foodView.isHidden = false
            supplementsView.isHidden = true
        case 1:
            foodView.isHidden = true
            supplementsView.isHidden = false
        default:
            foodView.isHidden = false
            supplementsView.isHidden = true
        }
    }
}
