//
//  HotNewsTableViewCell.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/16.
//

import UIKit

class HotNewsTableViewCell: UITableViewCell {
    public static let identifier = "HotNewsTableViewCell"
    
    @IBOutlet var hashTagCollectionView: UICollectionView!
    @IBOutlet var newsCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setCollectionView()
        registerXib()
    }
    
    private func setCollectionView() {
        hashTagCollectionView.delegate = self
        hashTagCollectionView.dataSource = self
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
    }
    
    private func registerXib() {
        hashTagCollectionView.register(
            UINib(nibName: HashTagCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: HashTagCollectionViewCell.identifier
        )
        newsCollectionView.register(
            UINib(nibName: NewsCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: NewsCollectionViewCell.identifier
        )
    }
}

extension HotNewsTableViewCell: UICollectionViewDelegate {
    
}

extension HotNewsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case hashTagCollectionView:
            return 10
        case newsCollectionView:
            return 3
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case hashTagCollectionView:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HashTagCollectionViewCell.identifier,
                for: indexPath) as? HashTagCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.deSelectItem()
            return cell
        case newsCollectionView:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NewsCollectionViewCell.identifier,
                for: indexPath) as? NewsCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    
}
