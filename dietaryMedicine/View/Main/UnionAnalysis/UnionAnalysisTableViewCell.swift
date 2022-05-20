//
//  UnionAnalysisTableViewCell.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/16.
//

import UIKit

class UnionAnalysisTableViewCell: UITableViewCell {
    public static let identifier = "UnionAnalysisTableViewCell"

    @IBOutlet var outerView: UIView!
    @IBOutlet var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setUpView()
        setTableView()
        registerXib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setUpView() {
        outerView.layer.cornerRadius = 8
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 0.1
        outerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        outerView.layer.masksToBounds = false
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerXib() {
        tableView.register(
            UINib(nibName: AnalysisTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: AnalysisTableViewCell.identifier)
    }
}

extension UnionAnalysisTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension UnionAnalysisTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AnalysisTableViewCell.identifier,
            for: indexPath) as? AnalysisTableViewCell
        else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    
}
