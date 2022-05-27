//
//  CutomTabBarCell.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/16.
//

import UIKit

class TabBarHeaderCell: UICollectionViewCell {
    public static let identifier = "TabBarHeaderCell"
 
    @IBOutlet weak var tabBarTitle: UILabel!
    @IBOutlet weak var selectLine: UIView!
    
    override var isSelected: Bool {
        willSet {
            newValue ? selectTabItem() : deselectTabItem()
        }
    }
    
    override func prepareForReuse() {
        isSelected = false
    }
    
    func selectTabItem(){
        tabBarTitle.textColor = .black
        selectLine.backgroundColor = .black
    }
    
    func deselectTabItem(){
        tabBarTitle.textColor = .lightGray
        selectLine.backgroundColor = .mainGray
    }
    
}
