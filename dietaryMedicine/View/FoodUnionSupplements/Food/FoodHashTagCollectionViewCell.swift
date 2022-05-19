//
//  FoodHashTagCollectionViewCell.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/17.
//

import UIKit

class FoodHashTagCollectionViewCell: UICollectionViewCell {
    public static let identifier = "FoodHashTagCollectionViewCell"
    
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
        // Initialization code
        
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
