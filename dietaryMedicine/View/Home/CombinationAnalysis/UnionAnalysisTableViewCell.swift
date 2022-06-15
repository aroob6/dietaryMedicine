//
//  UnionAnalysisTableViewCell.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/16.
//

import UIKit

class UnionAnalysisTableViewCell: UITableViewCell {
    public static let identifier = "UnionAnalysisTableViewCell"

//    @IBOutlet var outerView: UIView!
//    @IBOutlet var tableView: UITableView!
    @IBOutlet var lackCollenctionView: UICollectionView!
    @IBOutlet var overCollenctionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        setUpView()
//        setTableView()c

        setCollectionView()
        registerXib()
    }
    
//    private func setUpView() {
//        self.selectionStyle = .none
//        outerView.layer.cornerRadius = 8
//        outerView.layer.shadowColor = UIColor.black.cgColor
//        outerView.layer.shadowOpacity = 0.1
//        outerView.layer.shadowOffset = CGSize(width: 0, height: 0)
//        outerView.layer.masksToBounds = false
//    }
    
    private func setCollectionView() {
        lackCollenctionView.delegate = self
        lackCollenctionView.dataSource = self
        overCollenctionView.delegate = self
        overCollenctionView.dataSource = self
    }
    
    private func registerXib() {
        lackCollenctionView.register(
            UINib(nibName: NutrientImageCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: NutrientImageCollectionViewCell.identifier)
        overCollenctionView.register(
            UINib(nibName: NutrientImageCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: NutrientImageCollectionViewCell.identifier)
    }
}
extension UnionAnalysisTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case lackCollenctionView:
            return 10
        case overCollenctionView:
            return 10
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NutrientImageCollectionViewCell.identifier, for: indexPath) as? NutrientImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    
}
