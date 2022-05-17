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
        setTableCollectionView()
    }
    
    private func setTableCollectionView () {
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        registerXib()
    }
    private func registerXib() {
        let foodTableNibName = UINib(nibName: "FoodTableViewCell", bundle: nil)
        tableView.register(foodTableNibName, forCellReuseIdentifier: "FoodTableViewCell")
        
        let foodCollectionNibName = UINib(nibName: "FoodHashTagCollectionViewCell", bundle: nil)
        collectionView.register(foodCollectionNibName, forCellWithReuseIdentifier: "FoodHashTagCollectionViewCell")
    }
}

extension SupplementsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let foodTableCell = tableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell", for: indexPath)
        foodTableCell.selectionStyle = .none
        return foodTableCell
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
        let foodCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodHashTagCollectionViewCell", for: indexPath) as! FoodHashTagCollectionViewCell
        foodCollectionCell.deSelectItem()
        return foodCollectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("## \(indexPath)")
    }
}
