//
//  ProductListViewController.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/16.
//

import UIKit

class AddListViewController: UIViewController {

    @IBOutlet weak var tabBarHeader: UICollectionView!
    @IBOutlet weak var foodView: UIView!
    @IBOutlet weak var supplementsView: UIView!
    
    let tabBarTitle = ["영양제", "식품"]
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setUpView()
        setUpCollectionView()
    }
    
    func setUpView() {
        self.navigationItem.title = "영양제 or 식품"
        tabBarController?.tabBar.isHidden = true
        supplementsView.isHidden = true
    }
    func setUpCollectionView() {
        tabBarHeader.delegate = self
        tabBarHeader.dataSource = self
        
        let tabBarLayout = UICollectionViewFlowLayout()
        tabBarLayout.itemSize = CGSize.init(width: self.view.frame.width / 2, height: 50)
        tabBarLayout.minimumLineSpacing = 0
        tabBarLayout.minimumInteritemSpacing = 0
        tabBarHeader.collectionViewLayout = tabBarLayout
    }
}

extension AddListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabBarTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tabBarCell = collectionView.dequeueReusableCell(withReuseIdentifier: TabBarHeaderCell.identifier, for: indexPath) as! TabBarHeaderCell
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
            return
        }
    }
}
