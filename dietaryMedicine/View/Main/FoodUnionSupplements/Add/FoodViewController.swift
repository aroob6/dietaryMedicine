//
//  FoodViewController.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/17.
//

import UIKit
import RxSwift
import RxCocoa
import Resolver

class FoodViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var foodList = FoodList()
    
    @Injected private var foodsViewModel: FoodsViewModel
    @Injected private var disposeBag : DisposeBag

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setCollectionView()
        registerXib()
        
        requestFoods()
        bindFoods()
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
            UINib(nibName: AddTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: AddTableViewCell.identifier)
        
        collectionView.register(
            UINib(nibName: HashTagCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: HashTagCollectionViewCell.identifier
        )
    }
    
    private func requestFoods() {
        let parameters: [String: String] = [:]
        
        foodsViewModel.fetch(parameters: parameters)
    }
    
    private func bindFoods() {
        foodsViewModel.output.data.asDriver(onErrorDriveWith: Driver.empty()).drive {
            result in
            switch result {
            case .success(let data):
                self.requestFoodsSuccess(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        .disposed(by: disposeBag)
    }
    
    private func requestFoodsSuccess(_ result: FoodList) {
        print("✅: ALL FOODS LIST NET SUCCESS")
        
        foodList = result
        tableView.reloadData()
    }
}

extension FoodViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AddTableViewCell.identifier,
            for: indexPath
        ) as? AddTableViewCell else {
                return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configureCell(foodList: foodList, indexPath: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ItemDetailViewController()
        vc.configureCell(foodList: foodList, indexPath: indexPath)
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

extension FoodViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HashTagCollectionViewCell.identifier,
            for: indexPath) as? HashTagCollectionViewCell else {
                return UICollectionViewCell()
            }
        cell.deSelectItem()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("## \(indexPath)")
    }
}
