//
//  NewsCollectionViewCell.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/20.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    public static let identifier = "NewsCollectionViewCell"
    
    @IBOutlet var view: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpView()
    }

    private func setUpView() {
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.masksToBounds = false
    }
}
