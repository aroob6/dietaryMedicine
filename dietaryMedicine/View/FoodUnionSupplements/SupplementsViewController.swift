//
//  SupplementsViewController.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/17.
//

import UIKit

class SupplementsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setCollectionView()
        registerXib()
    }
    
    private func setTableView () {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setCollectionView () {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func registerXib() {
        tableView.register(
            UINib(nibName: FoodTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: FoodTableViewCell.identifier)
        
        collectionView.register(
            UINib(nibName: FoodHashTagCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: FoodHashTagCollectionViewCell.identifier)
    }
}

extension SupplementsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FoodTableViewCell.identifier,
            for: indexPath
        ) as? FoodTableViewCell else {
                return UITableViewCell()
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // DetailFoodViewController
        let storyboard = UIStoryboard.init(name: "FoodUnionSupplements", bundle: nil)
        let detailFoodVC = storyboard.instantiateViewController(withIdentifier: "DetailFoodViewController") as! DetailFoodViewController
        
        self.navigationController?.pushViewController(detailFoodVC, animated: false)
    }
}

extension SupplementsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FoodHashTagCollectionViewCell.identifier,
            for: indexPath
        ) as? FoodHashTagCollectionViewCell else {
                return UICollectionViewCell()
        }
        cell.deSelectItem()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("## \(indexPath)")
    }
}
