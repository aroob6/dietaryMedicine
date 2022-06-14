//
//  MyCollectionViewController.swift
//  dietaryMedicine
//
//  Created by bora on 2022/06/14.
//

import UIKit

class MyCollectionViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
        registerXib()
    }
    

    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
    }
    
    private func registerXib() {
        tableView.register(
            UINib(nibName: AnotherCombinationTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: AnotherCombinationTableViewCell.identifier
        )
    }

}

extension MyCollectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 300
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AnotherCombinationTableViewCell.identifier,
            for: indexPath) as? AnotherCombinationTableViewCell
        else {
            return UITableViewCell()
        }
        
        
        return cell
    }
    
    
}
