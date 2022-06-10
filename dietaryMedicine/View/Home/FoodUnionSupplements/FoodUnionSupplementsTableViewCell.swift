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

    @IBOutlet var title: UILabel!
    @IBOutlet var addButton: UIButton!
    @IBOutlet weak var addSupplementCollectionView: UICollectionView!
    @IBOutlet weak var addFoodCollectionView: UICollectionView!
    weak var viewController: UIViewController?
    var unionItemList: UnionItemList? {
        didSet {
            addSupplementCollectionView.reloadData()
        }
    }
    
    @Injected private var foodUnionSupplementsViewModel: FoodUnionSupplementsViewModel
    
    //RxSwift
    @Injected private var disposeBag : DisposeBag
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setView()
        registerXib()
        setCollectionView()
    }
    
    private func setView() {
        let titleText = "당신의 영양제와 식품의 영양성분을 조합하세요."
        let pointText = "영양제와 식품"
        let pointColor = UIColor.mainColor!.withAlphaComponent(0.3)
        let attributedString = NSMutableAttributedString()
            .normal("당신의 ", fontSize: 20)
            .bold( pointText, fontSize: 20)
            .normal("의 영양성분을 조합하세요.", fontSize: 20)
        attributedString.addAttribute(.backgroundColor, value: pointColor, range: (titleText as NSString).range(of: pointText))
        title.attributedText = attributedString
        
        addButton.layer.cornerRadius = 10
    }
    
    private func registerXib() {
        addSupplementCollectionView.register(
            UINib(nibName: AddCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: AddCollectionViewCell.identifier
        )
        addFoodCollectionView.register(
            UINib(nibName: AddCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: AddCollectionViewCell.identifier
        )
    }
    
    private func setCollectionView () {
        addSupplementCollectionView.delegate = self
        addSupplementCollectionView.dataSource = self
        addFoodCollectionView.delegate = self
        addFoodCollectionView.dataSource = self
    }
}

extension FoodUnionSupplementsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var selcollectionView = collectionView
        switch collectionView {
        case addSupplementCollectionView:
            selcollectionView = addSupplementCollectionView
        case addFoodCollectionView:
            selcollectionView = addFoodCollectionView
        default:
            return UICollectionViewCell()
        }
        
        guard let cell = selcollectionView.dequeueReusableCell(
            withReuseIdentifier: AddCollectionViewCell.identifier,
            for: indexPath
        ) as? AddCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let unionItemList = unionItemList else { return cell }
        cell.configureCell(collectionView: collectionView, unionItemList: unionItemList, indexPathRow: indexPath.row)
        
//        let supplementID = unionItemList.list[indexPath.row].supplementId
//        let foodID = unionItemList.list[indexPath.row].foodId
//        let imgUrl = unionItemList.list[indexPath.row].image
//
//        if supplementID == 0 {
//            // 음식
//            cell.configureCell(unionItemList: unionItemList, indexPathRow: indexPath.row)
//        }
//        else if foodID == 0 {
//            // 영양제
//            cell.configureCell(unionItemList: unionItemList, indexPathRow: indexPath.row)
//        }
//
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let unionItemListCount = unionItemList?.list.count else { return }
//        guard unionItemListCount == indexPath.item else {
//            guard let cell = collectionView.cellForItem(at: indexPath) as? AddCollectionViewCell else { return }
//            if cell.isSelected {
//                guard let vc = viewController else { return }
//                UtilFunction.showDeleteMessage(msg: "삭제 하시겠습니까?", vc: vc) { code in
//                    if code == .Okay {
//                        cell.requestDelete()
//                    }
//                    if code == .Cancel {
//                        cell.hiddenDelete()
//                    }
//                }
//            }
//            return
//
//        }
        
//        let storyboard = UIStoryboard.init(name: "FoodUnionSupplements", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "AddListViewController") as! AddListViewController
//        viewController?.navigationController?.pushViewController(vc, animated: false)
        
        switch collectionView {
        case addSupplementCollectionView:
            let vc = SupplementsViewController()
            viewController?.navigationController?.pushViewController(vc, animated: false)
        case addFoodCollectionView:
            let vc = FoodViewController()
            viewController?.navigationController?.pushViewController(vc, animated: false)
        default:
            return
        }
       
    
    }
}

extension Array {
    subscript (safe index: Int) -> Element? {
        // iOS 9 or later
        return indices ~= index ? self[index] : nil
        // iOS 8 or earlier
        // return startIndex <= index && index < endIndex ? self[index] : nil
        // return 0 <= index && index < self.count ? self[index] : nil
    }
}
