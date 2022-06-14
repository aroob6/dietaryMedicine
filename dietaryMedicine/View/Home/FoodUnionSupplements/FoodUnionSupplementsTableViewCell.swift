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
    @IBOutlet var supplementTitle: UILabel!
    @IBOutlet var foodTitle: UILabel!
    @IBOutlet weak var addSupplementCollectionView: UICollectionView!
    @IBOutlet weak var addFoodCollectionView: UICollectionView!
    weak var viewController: UIViewController?
    var supplementsList: [Item]? {
        didSet {
            addSupplementCollectionView.reloadData()
        }
    }
    
    var foodsList: [Item]? {
        didSet {
            addFoodCollectionView.reloadData()
        }
    }
    
    @Injected private var foodUnionSupplementsViewModel: CombinationSupplementsViewModel
    
    //RxSwift
    @Injected private var disposeBag : DisposeBag
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setView()
        registerXib()
        setCollectionView()
        bindButton()
    }
    
    private func setView() {
        self.selectionStyle = .none
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
        
//        supplementTitle = BasePaddingLabel()
//        foodTitle = BasePaddingLabel()
        supplementTitle.text = "영양제"
        foodTitle.text = "음식"
        supplementTitle.font = UIFont.systemFont(ofSize: 15)
        foodTitle.font = UIFont.systemFont(ofSize: 15)
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
    
    private func bindButton() {
        addButton.rx.tap.bind { [weak self] in
            self?.addAction()
        }.disposed(by: disposeBag)
    }
    
    private func addAction() {
        let vc = CollectionAddViewController()
        vc.supplementsList = supplementsList
        vc.foodsList = foodsList
        viewController?.navigationController?.pushViewController(vc, animated: false)
    }
}

extension FoodUnionSupplementsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AddCollectionViewCell.identifier,
            for: indexPath
        ) as? AddCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let supplementsList = supplementsList else { return cell }
        guard let foodsList = foodsList else { return cell }
    
        switch collectionView {
        case addSupplementCollectionView:
            cell.configureCell(type: "s", itemList: supplementsList, indexPathRow: indexPath.row)
            return cell
        case addFoodCollectionView:
            cell.configureCell(type: "f", itemList: foodsList, indexPathRow: indexPath.row)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? AddCollectionViewCell else { return }
        guard let supplementsList = supplementsList else { return }
        guard let foodsList = foodsList else { return }
        
        var itemType = ItemType.supplement
        var id = 0
        var vc = UIViewController()
        
        switch collectionView {
        case addSupplementCollectionView:
            itemType = .supplement
            id = supplementsList[safe: indexPath.row]?.supplementId ?? 0
            vc = SupplementsViewController()
        case addFoodCollectionView:
            itemType = .food
            id = foodsList[safe: indexPath.row]?.foodId ?? 0
            vc = FoodViewController()
        default:
            return
        }
        
        if cell.addImage.image != UIImage(systemName: "plus") {
            if cell.isSelected {
                guard let vc = viewController else { return }
                UtilFunction.showDeleteMessage(msg: "삭제 하시겠습니까?", vc: vc) { code in
                    if code == .Okay {
                        cell.requestDelete(type: itemType, id: id)
                    }
                    if code == .Cancel {
                        cell.hiddenDelete()
                    }
                }
            }
        }
        else {
            viewController?.navigationController?.pushViewController(vc, animated: false)
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
