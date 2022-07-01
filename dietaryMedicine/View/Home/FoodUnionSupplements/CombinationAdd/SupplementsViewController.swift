//
//  SupplementsViewController.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/17.
//

import UIKit
import RxSwift
import RxCocoa
import Resolver
import SnapKit
import Then

class SupplementsViewController: BaseItemListViewController {
    private var supplementList = SupplementList()
    @Injected private var supplementsViewModel: SupplementsViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setTableView()
        setCollectionView()
        registerXib()
        
        requestSupplements()
        bindSupplements()
    }
    
    private func setUI (){
        navigationTitle(string: "영양제")
    }
    
    private func setTableView () {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setCollectionView () {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func requestSupplements() {
        let parameters: [String: String] = [:]
        
        supplementsViewModel.fetch(parameters: parameters)
    }
    
    private func bindSupplements() {
        supplementsViewModel.output.data.asDriver(onErrorDriveWith: Driver.empty()).drive {
            result in
            switch result {
            case .success(let data):
                self.requestSupplementsSuccess(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        .disposed(by: disposeBag)
    }
    
    private func requestSupplementsSuccess(_ result: SupplementList) {
        print("✅: ALL SUPPLEMENT LIST NET SUCCESS")
        
        supplementList = result
        tableView.reloadData()
    }
}

extension SupplementsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supplementList.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AddTableViewCell.identifier,
            for: indexPath
        ) as? AddTableViewCell else {
                return UITableViewCell()
        }
        cell.configureCell(supplementList: supplementList, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ItemDetailViewController()
        vc.configureCell(supplementList: supplementList, indexPath: indexPath)
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

extension SupplementsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HashTagCollectionViewCell.identifier,
            for: indexPath) as? HashTagCollectionViewCell else {
                return UICollectionViewCell()
            }
        cell.title.text = tagList[indexPath.row]
        cell.deSelectItem()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("## \(indexPath)")
    }
}

extension SupplementsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel().then {
                $0.font = .systemFont(ofSize: 14)
                $0.text = tagList[indexPath.item]
                $0.sizeToFit()
            }
            let size = label.frame.size
            
            return CGSize(width: size.width + 40, height: size.height + 20)
    }
}
