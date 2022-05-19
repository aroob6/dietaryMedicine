//
//  FoodTableViewCell.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/17.
//

import UIKit

class PlusTableViewCell: UITableViewCell {
    public static let identifier = "PlusTableViewCell"
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var price: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
