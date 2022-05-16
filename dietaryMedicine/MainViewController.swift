//
//  MainViewController.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/15.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
    }
    private func setTableView () {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        registerXib()
    }
    private func registerXib() {
        let foodUnionSupplementsNibName = UINib(nibName: "FoodUnionSupplementsTableViewCell", bundle: nil)
        let unionAnalysisNibName = UINib(nibName: "UnionAnalysisTableViewCell", bundle: nil)
        let hotNewsNibName = UINib(nibName: "HotNewsTableViewCell", bundle: nil)
        
        mainTableView.register(foodUnionSupplementsNibName, forCellReuseIdentifier: "FoodUnionSupplementsTableViewCell")
        mainTableView.register(unionAnalysisNibName, forCellReuseIdentifier: "UnionAnalysisTableViewCell")
        mainTableView.register(hotNewsNibName, forCellReuseIdentifier: "HotNewsTableViewCell")
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section

        switch section {
        case 0:
            let foodUnionSupplementsCell = tableView.dequeueReusableCell(withIdentifier: "FoodUnionSupplementsTableViewCell", for: indexPath) as! FoodUnionSupplementsTableViewCell
            foodUnionSupplementsCell.viewController = self
            return foodUnionSupplementsCell
        case 1:
            let unionAnalysisCell = tableView.dequeueReusableCell(withIdentifier: "UnionAnalysisTableViewCell", for: indexPath)
            return unionAnalysisCell
        case 2:
            let hotNewsCell = tableView.dequeueReusableCell(withIdentifier: "HotNewsTableViewCell", for: indexPath)
            return hotNewsCell
        default:
            let foodUnionSupplementsCell = tableView.dequeueReusableCell(withIdentifier: "FoodUnionSupplementsTableViewCell", for: indexPath)
            return foodUnionSupplementsCell
        }
    }
    
    
}
