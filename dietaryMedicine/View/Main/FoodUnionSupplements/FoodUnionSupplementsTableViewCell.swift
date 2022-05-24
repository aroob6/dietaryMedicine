//
//  FoodUnionSupplementsTableViewCell.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/16.
//

import UIKit
import RxSwift
import RxCocoa
import Resolver
import Alamofire

class FoodUnionSupplementsTableViewCell: UITableViewCell {
    public static let identifier = "FoodUnionSupplementsTableViewCell"

    @IBOutlet weak var addCollectionView: UICollectionView!
    weak var viewController: UIViewController?
    var unionItemList: UnionItemList? {
        didSet {
            addCollectionView.reloadData()
        }
    }
    
    @Injected private var foodUnionSupplementsViewModel: FoodUnionSupplementsViewModel
    
    //RxSwift
    @Injected private var disposeBag : DisposeBag
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setCollectionView () {
        addCollectionView.delegate = self
        addCollectionView.dataSource = self
        registerXib()
    }
    private func registerXib() {
        addCollectionView.register(
            UINib(nibName: AddCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: AddCollectionViewCell.identifier
        )
    }
}

extension FoodUnionSupplementsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let unionItemListCount = unionItemList?.list.count else { return 0 }
        if unionItemListCount == 0 {
            return 0
        }
        else {
            return unionItemListCount + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = addCollectionView.dequeueReusableCell(
            withReuseIdentifier: AddCollectionViewCell.identifier,
            for: indexPath
        ) as? AddCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let unionItemList = unionItemList else { return cell }
        cell.configureCell(unionItemList: unionItemList, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let unionItemListCount = unionItemList?.list.count else { return }
        guard unionItemListCount == indexPath.row else { return }
        
        let storyboard = UIStoryboard.init(name: "FoodUnionSupplements", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddListViewController") as! AddListViewController
        viewController?.navigationController?.pushViewController(vc, animated: false)
    
    }
    
}
