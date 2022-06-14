//
//  HomeViewController.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/15.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Resolver
import Alamofire

class HomeViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var name: UILabel!
    
    private var supplementsList: CombinationItemList?
    private var foodList: CombinationItemList?
    
    @Injected private var combinationSupplementsViewModel: CombinationSupplementsViewModel
    @Injected private var combinationFoodsViewModel: CombinationFoodsViewModel
    
    //RxSwift
    @Injected private var disposeBag : DisposeBag
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        tabBarController?.tabBar.isHidden = false
        requestUnionList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = Info.share.email
        StaticDelegate.mainDelegate = self

        setTableView()
        registerXib()
        
        bindCombinationList()
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
            UINib(nibName: CombinationRecommendTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CombinationRecommendTableViewCell.identifier)
    }
    
    private func requestUnionList() {
        let parameter: [String : String] = [:]
        
        combinationSupplementsViewModel.fetch(parameters: parameter)
        combinationFoodsViewModel.fetch(parameters: parameter)
    }
    
    private func bindCombinationList() {
        combinationSupplementsViewModel.output.data.asDriver(onErrorDriveWith: Driver.empty())
            .drive { result in
            switch result {
            case .success(let list):
                self.requestItemListSuccess(.supplement, list)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }.disposed(by: disposeBag)
        
        combinationFoodsViewModel.output.data.asDriver(onErrorDriveWith: Driver.empty())
            .drive { result in
            switch result {
            case .success(let list):
                self.requestItemListSuccess(.food, list)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }.disposed(by: disposeBag)
    }
    
    private func requestItemListSuccess(_ type: ItemType, _ result: CombinationItemList) {
        switch type {
        case .supplement:
            supplementsList = result
            print("✅: SUPPLEMENTSLIST NET SUCCESS")
        case .food:
            foodList = result
            print("✅: FOODSLIST NET SUCCESS")
        }
        
        mainTableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
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
            
            guard let supplementsList = supplementsList?.list else { return cell }
            guard let foodList = foodList?.list else { return cell }
            
            cell.viewController = self
            cell.supplementsList = supplementsList
            cell.foodsList = foodList
            
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
                withIdentifier: CombinationRecommendTableViewCell.identifier,
                for: indexPath
            ) as? CombinationRecommendTableViewCell else {
                return UITableViewCell()
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension HomeViewController: ViewDelegate {
    func unionItemRefresh() {
        requestUnionList()
    }
}
