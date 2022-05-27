//
//  AnalysisTableViewCell.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/20.
//

import UIKit

class AnalysisTableViewCell: UITableViewCell {
    public static let identifier = "AnalysisTableViewCell"

    @IBOutlet var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setUpView() {
        imgView.layer.cornerRadius = imgView.frame.height / 2
    }
}
