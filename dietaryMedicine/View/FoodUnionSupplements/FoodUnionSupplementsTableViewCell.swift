//
//  FoodUnionSupplementsTableViewCell.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/16.
//

import UIKit

class FoodUnionSupplementsTableViewCell: UITableViewCell {

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
        let addCollectionViewNibName = UINib(nibName: "AddCollectionViewCell", bundle: nil)
        addCollectionView.register(addCollectionViewNibName, forCellWithReuseIdentifier: "AddCollectionViewCell")
    }
    
}
extension FoodUnionSupplementsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let addCell = addCollectionView.dequeueReusableCell(withReuseIdentifier: "AddCollectionViewCell", for: indexPath) as! AddCollectionViewCell
        return addCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "FoodUnionSupplements", bundle: nil)
        let productListVC = storyboard.instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
        viewController?.navigationController?.pushViewController(productListVC, animated: false)
    }
    
}
