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
}

extension AnotherCombinationTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    
}
