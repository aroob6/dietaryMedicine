//
//  TabBarHeaderCollectionViewCell.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/31.
//

import UIKit

class TabBarHeaderCollectionViewCell: UICollectionViewCell {
    public static let identifier = "TabBarHeaderCollectionViewCell"
    
    @IBOutlet weak var tabBarTitle: UILabel!
    @IBOutlet weak var selectLine: UIView!

    override var isSelected: Bool {
        willSet {
            newValue ? selectTabItem() : deselectTabItem()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tabBarTitle.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    override func prepareForReuse() {
        isSelected = false
    }
    
    func selectTabItem(){
        tabBarTitle.textColor = .black
        selectLine.backgroundColor = .mainColor
    }
    
    func deselectTabItem(){
        tabBarTitle.textColor = .lightGray
        selectLine.backgroundColor = .mainGray
    }
    
}
