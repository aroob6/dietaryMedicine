//
//  CutomTabBarCell.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/16.
//

import UIKit

class CustomTabBarCell: UICollectionViewCell {
 
    @IBOutlet weak var tabBarTitle: UILabel!
    @IBOutlet weak var selectLine: UIView!
    
    override var isSelected: Bool {
        willSet {
            if newValue {
                selectTabItem()
            }
            else{
                deselectTabItem()
            }
        }
    }
    
    override func prepareForReuse() {
        isSelected = false
    }
    
    func selectTabItem(){
        tabBarTitle.textColor = .black
        selectLine.isHidden = false
    }
    
    func deselectTabItem(){
        tabBarTitle.textColor = .lightGray
        selectLine.isHidden = true
    }
    
}
