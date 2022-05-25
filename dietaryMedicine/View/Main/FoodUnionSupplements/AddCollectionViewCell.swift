//
//  AddCollectionViewCell.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/16.
//

import UIKit
import SnapKit
import Kingfisher

class AddCollectionViewCell: UICollectionViewCell {
    public static let identifier = "AddCollectionViewCell"
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var addImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.masksToBounds = false
    }
    
    func configureCell(unionItemList: UnionItemList, indexPath: IndexPath) {
        if unionItemList.list.count == indexPath.row {
            addImage.image = UIImage(systemName: "plus")
            return
        }
        
        let unionItemData = unionItemList.list[indexPath.row]
        
        if unionItemData.image != "" {
            let imgURL = URL(string: unionItemData.image)
            
            addImage.kf.setImage(
                with: imgURL,
                options: [
                    .transition(ImageTransition.fade(0.3)),
                    .keepCurrentImageWhileLoading
                ]
            )
        }
    }
}
