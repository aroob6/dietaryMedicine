//
//  ImageCollectionViewCell.swift
//  dietaryMedicine
//
//  Created by bora on 2022/06/09.
//

import UIKit
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {
    public static let identifier = "ImageCollectionViewCell"
    
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(imgUrl: String?) {
        let imgURL = imgUrl ?? ""
        let url = URL(string: imgURL)
        let processor = RoundCornerImageProcessor(cornerRadius: 8)
        
        imgView.kingFisherSetImage(url: url!, processor: processor)
    }
}
