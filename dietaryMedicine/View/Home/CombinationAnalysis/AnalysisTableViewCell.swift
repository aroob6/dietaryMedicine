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
    
    private func setUpView() {
        self.selectionStyle = .none
        imgView.layer.cornerRadius = imgView.frame.height / 2
    }
}
