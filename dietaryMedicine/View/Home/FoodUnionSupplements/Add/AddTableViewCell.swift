//
//  FoodTableViewCell.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/17.
//

import UIKit
import Kingfisher

class AddTableViewCell: UITableViewCell {
    public static let identifier = "AddTableViewCell"
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var price: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
    }
    
    func configureCell(supplementList: SupplementList, indexPath: IndexPath) {
        let supplementData = supplementList.data[indexPath.row]
        name.text = supplementData.name
        content.text = supplementData.content
        price.text = String(supplementData.price)
        
        if supplementData.image != "" {
            let imgURL = supplementData.image
            let url = URL(string: imgURL)
            
            imageSet(url: url)
        }
        else {
            imageView?.image = nil
        }
    }
    
    func configureCell(foodList: FoodList, indexPath: IndexPath) {
        let foodData = foodList.data[indexPath.row]
        name.text = foodData.name
        content.text = foodData.content
        price.text = String(foodData.price)
        
        if foodData.image != "" {
            let imgURL = foodData.image
            let url = URL(string: imgURL)
            
           imageSet(url: url)
        }
        else {
            imageView?.image = nil
        }
    }
    
    func configureCell(itemList: [Item]?, indexPath: IndexPath) {
        guard let itemData = itemList?[indexPath.row] else {return }
        
        if itemData.image != "" {
            let imgURL = itemData.image
            let url = URL(string: imgURL)
            
           imageSet(url: url)
        }
    }
    
    func imageSet(url: URL?) {
        imgView.kf.setImage(
            with: url,
            options: [
                .transition(ImageTransition.fade(0.3)),
                .keepCurrentImageWhileLoading
            ]
        )
    }
    
}
