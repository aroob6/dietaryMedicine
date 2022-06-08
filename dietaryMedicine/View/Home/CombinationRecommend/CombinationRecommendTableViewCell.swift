//
//  UnionAnalysisTableViewCell.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/16.
//

import UIKit

class CombinationRecommendTableViewCell: UITableViewCell {
    public static let identifier = "CombinationRecommendTableViewCell"

    @IBOutlet var titleLabel: UILabel!
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
        titleLabel.text = Info.share.name + "님 이 조합은 어때요?"
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerXib() {
        tableView.register(
            UINib(nibName: AnotherCombinationTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: AnotherCombinationTableViewCell.identifier
        )
        tableView.register(
            UINib(nibName: SeeMoreCombinationTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: SeeMoreCombinationTableViewCell.identifier
        )
    }
}

extension CombinationRecommendTableViewCell: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        }
        else {
            return 80
        }
        
    }
}

extension CombinationRecommendTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AnotherCombinationTableViewCell.identifier,
                for: indexPath) as? AnotherCombinationTableViewCell
            else {
                return UITableViewCell()
            }
            
            
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SeeMoreCombinationTableViewCell.identifier,
                for: indexPath) as? SeeMoreCombinationTableViewCell
            else {
                return UITableViewCell()
            }
            return cell
        }
        
    }
    
    
}
