//
//  ProductListViewController.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/16.
//

import UIKit

class NutrientDiaryViewController: UIViewController {

    @IBOutlet weak var tabBarHeader: UICollectionView!
    @IBOutlet weak var myCollection: UIView!
    @IBOutlet weak var likeCollection: UIView!
    
    let tabBarTitle = ["내 컬렉션", "좋아요 컬렉션"]
  
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setUpView()
        setUpCollectionView()
        registerXib()
    }
    
    func setUpView() {
        self.navigationItem.title = "컬렉션"
        myCollection.isHidden = true
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
    
    private func registerXib() {
        tabBarHeader.register(UINib(nibName: TabBarHeaderCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TabBarHeaderCollectionViewCell.identifier)
    }
}

extension NutrientDiaryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabBarTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabBarHeaderCollectionViewCell.identifier, for: indexPath) as? TabBarHeaderCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.tabBarTitle.text = tabBarTitle[indexPath.row]
        cell.deselectTabItem()
        if indexPath.row == 0 {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
            cell.isSelected = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            likeCollection.isHidden = false
            myCollection.isHidden = true
        case 1:
            likeCollection.isHidden = true
            myCollection.isHidden = false
        default:
            return
        }
    }
}
