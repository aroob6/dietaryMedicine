//
//  ItemInfoTableViewCell.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/31.
//

import UIKit

class ItemInfoTableViewCell: UITableViewCell {
    public static let identifier = "ItemInfoTableViewCell"

    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
}
