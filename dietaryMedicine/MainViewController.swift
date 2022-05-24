//
//  MainViewController.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/15.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = UserDefaultsManager.email

        setTableView()
        registerXib()
    }
    private func setTableView () {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    private func registerXib() {

        mainTableView.register(
            UINib(nibName: FoodUnionSupplementsTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: FoodUnionSupplementsTableViewCell.identifier)
        mainTableView.register(
            UINib(nibName: UnionAnalysisTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: UnionAnalysisTableViewCell.identifier)
        mainTableView.register(
            UINib(nibName: HotNewsTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: HotNewsTableViewCell.identifier)
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
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: FoodUnionSupplementsTableViewCell.identifier,
                for: indexPath
            ) as? FoodUnionSupplementsTableViewCell else {
                return UITableViewCell()
            }
            cell.viewController = self
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: UnionAnalysisTableViewCell.identifier,
                for: indexPath
            ) as? UnionAnalysisTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: HotNewsTableViewCell.identifier,
                for: indexPath
            ) as? HotNewsTableViewCell else {
                return UITableViewCell()
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}
