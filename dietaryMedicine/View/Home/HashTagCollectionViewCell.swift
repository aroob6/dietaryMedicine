//
//  FoodHashTagCollectionViewCell.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/17.
//

import UIKit
import SnapKit

class HashTagCollectionViewCell: UICollectionViewCell {
    public static let identifier = "HashTagCollectionViewCell"

    var title: UILabel = {
        let label = UILabel().then {
            $0.font = .systemFont(ofSize: 14)
        }
        return label
    }()
    
    override var isSelected: Bool {
        willSet {
            newValue ? selectItem() : deSelectItem()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
    override func prepareForReuse() {
        isSelected = false
    }
    
    func setUI() {
        contentView.addSubview(title)
    
        title.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        isSelected = false
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = contentView.frame.height / 2
    }
    
    func selectItem(){
        title.textColor = .white
        contentView.backgroundColor = .mainColor
    }
    
    func deSelectItem(){
        title.textColor = .textGray
        contentView.backgroundColor = .mainGray
    }

}
