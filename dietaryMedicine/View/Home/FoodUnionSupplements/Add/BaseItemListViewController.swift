//
//  ItemListViewController.swift
//  dietaryMedicine
//
//  Created by bora on 2022/06/10.
//

import UIKit
import RxSwift
import RxCocoa
import Resolver
import SnapKit
import Then

class BaseItemListViewController: UIViewController {

    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.minimumInteritemSpacing = 0
            $0.minimumLineSpacing = 15
        }
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    var tableView = UITableView()
    var tagList = ["# 비타민", "# 비타민", "# 비타민", "# 비타민", "# 비타민"]
    let collectionViewHeight: CGFloat = 50
    @Injected var disposeBag : DisposeBag
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    private func setUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(collectionView)
        self.view.addSubview(tableView)
        
        collectionView.snp.makeConstraints {
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            $0.top.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(collectionViewHeight)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.bottom.trailing.leading.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

    func navigationTitle(string: String) {
        self.navigationItem.title = string
    }
    
    func registerXib() {
        tableView.register(
            UINib(nibName: AddTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: AddTableViewCell.identifier)
        
        collectionView.register(
            UINib(nibName: HashTagCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: HashTagCollectionViewCell.identifier
        )
    }
}
