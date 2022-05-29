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
    
    private var unionItemList = UnionItemList()
    
    @Injected private var foodUnionSupplementsViewModel: FoodUnionSupplementsViewModel
    
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
        
        bindUnionList()
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
    
    private func requestUnionList() {
        let parameter: [String : String] = [:]
        
        foodUnionSupplementsViewModel.fetch(parameters: parameter)
    }
    
    private func bindUnionList() {
        foodUnionSupplementsViewModel.output.data.asDriver(onErrorDriveWith: Driver.empty())
            .drive { result in
            switch result {
            case .success(let unionListData):
                self.requestUnionListSuccess(unionListData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }.disposed(by: disposeBag)
    }
    
    private func requestUnionListSuccess(_ result: UnionItemList) {
        print("✅: UNIONLIST NET SUCCESS")
        
        unionItemList = result
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
            cell.viewController = self
            cell.unionItemList = unionItemList
            
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

extension HomeViewController: ViewDelegate {
    func unionItemRefresh() {
        requestUnionList()
    }
}