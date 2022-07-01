//
//  NutrientImageCollectionViewCell.swift
//  dietaryMedicine
//
//  Created by bora on 2022/06/15.
//

import UIKit
import Kingfisher

class NutrientImageCollectionViewCell: UICollectionViewCell {
    public static let identifier = "NutrientImageCollectionViewCell"
    
    var imgView = UIImageView()
    var title = UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()        
    }

    private func setUI() {
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(title)
        
        title.font = UIFont.systemFont(ofSize: 10)
        title.textAlignment = .center
        
        imgView.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.leading.trailing.equalToSuperview()
        }
        title.snp.makeConstraints {
            $0.top.equalTo(imgView.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func configureCell(data: [DeficiencyNutrient], indexPath: IndexPath) {
        let data = data[indexPath.row]
        
        let imgURL = URL(string: data.nutrientImg)
        let processor = RoundCornerImageProcessor(cornerRadius: 8)
        
        title.text = data.nutrientName
        imgView.kingFisherSetImage(url: imgURL!, processor: processor)
    }
}
