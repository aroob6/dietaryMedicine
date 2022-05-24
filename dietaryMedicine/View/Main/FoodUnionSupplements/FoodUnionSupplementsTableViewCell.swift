//
//  FoodUnionSupplementsTableViewCell.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/16.
//

import UIKit

class FoodUnionSupplementsTableViewCell: UITableViewCell {
    public static let identifier = "FoodUnionSupplementsTableViewCell"

    @IBOutlet weak var addCollectionView: UICollectionView!
    weak var viewController: UIViewController?
    
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let addCell = addCollectionView.dequeueReusableCell(
            withReuseIdentifier: AddCollectionViewCell.identifier,
            for: indexPath
        ) as? AddCollectionViewCell else {
            return UICollectionViewCell()
            
        }
        return addCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = FoodSupplementsListViewController()
//        viewController?.navigationController?.pushViewController(vc, animated: false)
        let storyboard = UIStoryboard.init(name: "FoodUnionSupplements", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductListViewController") as! AddListViewController
//        vc.modalPresentationStyle = .fullScreen
//        viewController?.present(vc, animated: false)
        viewController?.navigationController?.pushViewController(vc, animated: false)
    
    }
    
}
