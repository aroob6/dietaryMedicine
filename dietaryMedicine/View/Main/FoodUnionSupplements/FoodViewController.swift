//
//  FoodViewController.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/17.
//

import UIKit

class FoodViewController: UIViewController {
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
        tableView.register(
            UINib(nibName: PlusTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: PlusTableViewCell.identifier)
        
        collectionView.register(
            UINib(nibName: PlusHashTagCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: PlusHashTagCollectionViewCell.identifier
        )
    }
}

extension FoodViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PlusTableViewCell.identifier,
            for: indexPath
        ) as? PlusTableViewCell else {
                return UITableViewCell()
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ItemDetailViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

extension FoodViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PlusHashTagCollectionViewCell.identifier,
            for: indexPath) as? PlusHashTagCollectionViewCell else {
                return UICollectionViewCell()
            }
        cell.deSelectItem()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("## \(indexPath)")
    }
}
