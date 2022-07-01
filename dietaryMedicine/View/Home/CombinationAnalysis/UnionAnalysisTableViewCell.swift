//
//  UnionAnalysisTableViewCell.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/16.
//

import UIKit

class UnionAnalysisTableViewCell: UITableViewCell {
    public static let identifier = "UnionAnalysisTableViewCell"
    weak var viewController: UIViewController?
    
    @IBOutlet var lackCollenctionView: UICollectionView!
    @IBOutlet var overCollenctionView: UICollectionView!
    
    var nutrientAnalysis: NutrientAnalysis? {
        didSet {
            lackCollenctionView.reloadData()
            overCollenctionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        setCollectionView()
        registerXib()
    }
    
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
            return nutrientAnalysis?.deficiency.count ?? 0
        case overCollenctionView:
            return nutrientAnalysis?.excess.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NutrientImageCollectionViewCell.identifier, for: indexPath) as? NutrientImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let nutrientAnalysis = nutrientAnalysis else { return cell }
        
        switch collectionView {
        case lackCollenctionView:
            cell.configureCell(data: nutrientAnalysis.deficiency, indexPath: indexPath)
            return cell
        case overCollenctionView:
            cell.configureCell(data: nutrientAnalysis.excess, indexPath: indexPath)
            return cell
        default:
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let nutrientAnalysis = nutrientAnalysis else { return }
        let vc = EachNutrientViewController()
        
        switch collectionView {
        case lackCollenctionView:
            vc.nutrientStandardText = "부족"
            vc.nutrientData = nutrientAnalysis.deficiency[indexPath.row]
            viewController?.navigationController?.pushViewController(vc, animated: false)
        case overCollenctionView:
            vc.nutrientStandardText = "과다"
            vc.nutrientData = nutrientAnalysis.excess[indexPath.row]
            viewController?.navigationController?.pushViewController(vc, animated: false)
        default:
            return
        }
    }
}
