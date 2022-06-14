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
    }
    
    func configureCell(type: String, itemList: [Item], indexPathRow: Int) {
        guard let itemData = itemList[safe: indexPathRow] else {
            addImage.image = UIImage(systemName: "plus")
            addImage.contentMode = .center
            addImage.layer.cornerRadius = 8
            return
            
        }
        
        if type == itemData.type {
            let imgURL = URL(string: itemData.image)
            let processor = RoundCornerImageProcessor(cornerRadius: 8)
            addImage.contentMode = .scaleAspectFit
            
            addImage.kf.setImage(
                with: imgURL,
                options: [
                    .transition(ImageTransition.fade(0.3)),
                    .keepCurrentImageWhileLoading,
                    .processor(processor)
                ]
            )
        }
    }
    
    func showDelete() {
        deleteImage.isHidden = false
    }

    func hiddenDelete() {
        deleteImage.isHidden = true
    }

    func requestDelete(type: ItemType, id: Int) {
        var parameter : [String: Int] = [:]

        switch type {
        case .supplement:
            parameter["supplement_id"] = id
        case .food:
            parameter["food_id"] = id
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
}
