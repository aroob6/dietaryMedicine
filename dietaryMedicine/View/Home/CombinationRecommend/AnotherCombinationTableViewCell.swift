//
//  AnalysisTableViewCell.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/20.
//

import UIKit

class AnotherCombinationTableViewCell: UITableViewCell {
    public static let identifier = "AnotherCombinationTableViewCell"
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var content: UILabel!
    
    var myNutrientDiaryList: MyNutrientDiaryList? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        registerXib()
        setCollectionView()
    }

    private func registerXib() {
        collectionView.register(
            UINib(nibName: ImageCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    }
    
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configureCell(_ title: String, _ content: String, _ myNutrientDiaryList: MyNutrientDiaryList?) {
        self.myNutrientDiaryList = myNutrientDiaryList
        self.titleLabel.text = title
        self.content.text = content
        
    }
}

extension AnotherCombinationTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myNutrientDiaryList?.nutrientDiaryItemList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let myNutrientDiaryList = myNutrientDiaryList else { return cell }
        cell.configureCell(imgUrl: myNutrientDiaryList.nutrientDiaryItemList[indexPath.row].image)
        
        return cell
    }
    
    
}
