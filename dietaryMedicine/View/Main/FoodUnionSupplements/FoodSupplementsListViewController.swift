//
//  FoodSupplementsListViewController.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/20.
//

import UIKit
import SwiftUI

class FoodSupplementsListViewController: UIViewController {
    
    @IBOutlet var tabBarHeaderCollection: UICollectionView!
    @IBOutlet var tabBarPageCollection: UICollectionView!
    
    // manage viwe
    private let tabBarHeaderIdentifier = "TabBarHeader"
    private let tabBarPageIdentifier = "TabBarPage"
    
    private let tabBatList = ["식품", "영양제"]
    private var viewControllerList = [UIViewController]()
    private var currentPosition = 0
    private var headerHeight = 60

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigation()
        setCollecionView()
        setPagingItem()
    }
    
    private func setNavigation() {
        self.navigationItem.title = "식품 or 영양제"
    }
    
    private func setCollecionView() {
        let flowHeaderLayout = UICollectionViewFlowLayout()
        flowHeaderLayout.minimumInteritemSpacing = 0
        flowHeaderLayout.minimumLineSpacing = 0
        flowHeaderLayout.scrollDirection = .horizontal
        
        let halfWidth = Int(UIScreen.main.bounds.width) / tabBatList.count
        flowHeaderLayout.itemSize = CGSize(width: halfWidth, height: headerHeight)
        
        tabBarHeaderCollection.register(
            TabBarHeaderCell.self,
            forCellWithReuseIdentifier: tabBarHeaderIdentifier
        )
        
        tabBarHeaderCollection.setCollectionViewLayout(flowHeaderLayout, animated: false)
        tabBarHeaderCollection.showsHorizontalScrollIndicator = false
        tabBarHeaderCollection.backgroundColor = .white
        tabBarHeaderCollection.delegate = self
        tabBarHeaderCollection.dataSource = self
        
        guard let flowPageLayout = tabBarPageCollection.collectionViewLayout
                as? UICollectionViewFlowLayout else { return }
        flowPageLayout.scrollDirection = .horizontal
        flowPageLayout.estimatedItemSize = view.frame.size
        
        tabBarPageCollection.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: tabBarPageIdentifier
        )
        
        tabBarPageCollection.isScrollEnabled = false
        tabBarPageCollection.showsHorizontalScrollIndicator = false
        tabBarPageCollection.contentInsetAdjustmentBehavior = .never
        tabBarPageCollection.delegate = self
        tabBarPageCollection.dataSource = self
        
    }
    
    private func setPagingItem() {
        let foodPage = TabBarPageViewController()
        let supplementPage = TabBarPageViewController()
        
        viewControllerList.append(foodPage)
        viewControllerList.append(supplementPage)
    }
}

extension FoodSupplementsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tabBarHeaderCollection {
            print(indexPath)
        }
        else {
            print(indexPath)
        }
    }
}

extension FoodSupplementsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tabBarHeaderCollection {
            return tabBatList.count
        }
        else {
            return viewControllerList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tabBarHeaderCollection {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: tabBarHeaderIdentifier,
                for: indexPath) as? TabBarHeaderCell else {
                    return UICollectionViewCell()
                }
            cell.text = tabBatList[indexPath.row]
            cell.deselectTabItem()
            if indexPath.row == 0 {
                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init())
                cell.isSelected = true
            }
            
            return cell
        }
        else {
            let pageItem = viewControllerList[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tabBarPageIdentifier, for: indexPath)
            
            cell.addSubview(pageItem.view)

            pageItem.view.snp.makeConstraints {
                $0.top.equalTo(cell.snp.top)
                $0.leading.equalTo(cell.snp.leading) //.offset(self.view.safeAreaInsets.left)
                $0.trailing.equalTo(cell.snp.trailing).offset(-self.view.safeAreaInsets.right)
                $0.bottom.equalTo(cell.snp.bottom)
            }
            return cell
        }
    }
}

extension FoodSupplementsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tabBarHeaderCollection {
            let spacer = CGFloat(tabBatList.count)
            let safreAreaMargin =  view.safeAreaInsets.left + view.safeAreaInsets.right
            return CGSize(width: (view.frame.width - safreAreaMargin) / spacer, height: CGFloat(headerHeight))
        }
        else {
            let pageHeight = view.frame.height - view.safeAreaInsets.top - CGFloat(headerHeight)
            return CGSize(width: view.frame.width, height: pageHeight)
        }
    }
    
}
