//
//  NutrientImageCollectionViewCell.swift
//  dietaryMedicine
//
//  Created by bora on 2022/06/15.
//

import UIKit

class NutrientImageCollectionViewCell: UICollectionViewCell {
    public static let identifier = "NutrientImageCollectionViewCell"
    
    var imgView = UIImageView()
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()        
    }

    private func setUI() {
        self.contentView.addSubview(imgView)
        imgView.backgroundColor = .yellow
        imgView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
