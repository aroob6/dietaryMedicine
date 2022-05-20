//
//  FoodHashTagCollectionViewCell.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/17.
//

import UIKit

class HashTagCollectionViewCell: UICollectionViewCell {
    public static let identifier = "HashTagCollectionViewCell"
    
    @IBOutlet var title: UILabel!
    @IBOutlet var view: UIView!
    
    override var isSelected: Bool {
        willSet {
            if newValue {
                selectItem()
            }
            else{
                deSelectItem()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view.layer.cornerRadius = view.frame.height / 2
    }
    
    override func prepareForReuse() {
        isSelected = false
    }
    
    func selectItem(){
        title.textColor = .white
        view.backgroundColor = .mainColor
    }
    
    func deSelectItem(){
        title.textColor = .textGray
        view.backgroundColor = .mainGray
    }

}
