//
//  AddCollectionViewCell.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/16.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Resolver
import Alamofire
import Kingfisher
import MapKit

class AddCollectionViewCell: UICollectionViewCell {
    public static let identifier = "AddCollectionViewCell"
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet var deleteImage: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                showDelete()
            }
            else {
                hiddenDelete()
            }
        }
    }
    
    private var item: Item?
    var itemType: ItemType = .supplement
    
    @Injected private var itemDeleteViewModel: ItemDeleteViewModel
    @Injected private var disposeBag : DisposeBag
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpView()
        
        bindDeleteItem()
    }
    
    private func setUpView() {
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.masksToBounds = false
        
        let clearColor = UIColor.black.withAlphaComponent(0.5)
        deleteImage.backgroundColor = clearColor
        deleteImage.layer.cornerRadius = 8
        deleteImage.isHidden = true
        
        addImage.image = UIImage(systemName: "plus")
        addImage.contentMode = .center
        addImage.layer.cornerRadius = 8
    }
    
    func showDelete() {
        deleteImage.isHidden = false
    }
    
    func hiddenDelete() {
        deleteImage.isHidden = true
    }
    
    @objc func requestDelete() {
        var parameter : [String: Int] = [:]
        
        if item?.supplementId == 0 {
            itemType = .food
        }
        if item?.foodId == 0 {
            itemType = .supplement
        }

        switch itemType {
        case .supplement:
            parameter["supplement_id"] = item?.supplementId
        case .food:
            parameter["food_id"] = item?.foodId
        }
        
        itemDeleteViewModel.itemType = itemType
        itemDeleteViewModel.fetch(parameters: parameter)
    }
    
    private func bindDeleteItem() {
        itemDeleteViewModel.output.data.asDriver(onErrorDriveWith: Driver.empty())
            .drive { result in
            switch result {
            case .success(let code):
                if code == 2000 {
                    self.requestDeleteSuccess()
                    StaticDelegate.mainDelegate?.unionItemRefresh()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }.disposed(by: disposeBag)
    }
    
    private func requestDeleteSuccess() {
        print("✅: DELETE ITEM NET SUCCESS")
    }
    
    func configureCell(unionItemList: UnionItemList, indexPathRow: Int) {
        let unionSupplementData = unionItemList.list[indexPathRow].supplementId
//        if unionItemList.list.count == indexPathRow {
//            addImage.image = UIImage(systemName: "plus")
//            addImage.contentMode = .center
//            return
//        }
        
//        if let unionItemData = unionItemList.list[indexPathRow], unionItemData.combinationId != 0 else {
//            return
//        }
//        self.item = unionItemData
//        
//        if unionItemData.image != "" {
//            let imgURL = URL(string: unionItemData.image)
//            addImage.contentMode = .scaleAspectFit
//            
//            addImage.kf.setImage(
//                with: imgURL,
//                options: [
//                    .transition(ImageTransition.fade(0.3)),
//                    .keepCurrentImageWhileLoading
//                ]
//            )
//        }
    }
}
