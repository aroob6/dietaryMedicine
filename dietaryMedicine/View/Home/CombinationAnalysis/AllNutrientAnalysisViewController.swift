//
//  AllNutrientAnalysisViewController.swift
//  dietaryMedicine
//
//  Created by bora on 2022/07/14.
//

import UIKit
import Then

class AllNutrientAnalysisViewController: UIViewController {
    private var stackView: UIStackView = {
        let view = UIStackView().then {
            $0.backgroundColor = .clear
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fillProportionally
        }
        return view
    }()
    private var scrollView = UIScrollView()
    
    private var titleLabel = UILabel()
    private var nutrientLabel = UILabel()
    private var foodLabel = UILabel()
    private var nutrientAnalysisLabel = UILabel()
    
    private var nutrientCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
        }
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    private var foodCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
        }
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    private var nutrientAnalysisTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        registerXib()
        setCollectionView()
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.setCustomSpacing(10, after: titleLabel)
        stackView.addArrangedSubview(nutrientLabel)
        stackView.setCustomSpacing(10, after: nutrientLabel)
        stackView.addArrangedSubview(nutrientCollectionView)
        stackView.setCustomSpacing(10, after: nutrientCollectionView)
        stackView.addArrangedSubview(foodLabel)
        stackView.setCustomSpacing(10, after: foodLabel)
        stackView.addArrangedSubview(foodCollectionView)
        stackView.setCustomSpacing(10, after: foodCollectionView)
        stackView.addArrangedSubview(nutrientAnalysisLabel)
        stackView.setCustomSpacing(10, after: nutrientAnalysisLabel)
        stackView.addArrangedSubview(nutrientAnalysisTableView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        titleLabel.text = Info.share.name + "님의 영양분 분석"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(35)
        }
        
        nutrientLabel.text = "영양제"
        nutrientLabel.font = UIFont.systemFont(ofSize: 15)
        nutrientLabel.snp.makeConstraints {
            $0.height.equalTo(15)
        }
        
        nutrientCollectionView.snp.makeConstraints {
            $0.height.equalTo(100)
        }
        
        foodLabel.text = "음식"
        foodLabel.font = UIFont.systemFont(ofSize: 15)
        foodLabel.snp.makeConstraints {
            $0.height.equalTo(15)
        }
        
        foodCollectionView.snp.makeConstraints {
            $0.height.equalTo(100)
        }
        
        nutrientAnalysisLabel.text = "영양소 분석"
        nutrientAnalysisLabel.font = UIFont.boldSystemFont(ofSize: 15)
        nutrientAnalysisLabel.snp.makeConstraints {
            $0.height.equalTo(15)
        }
        
        nutrientAnalysisTableView.snp.makeConstraints {
            $0.height.equalTo(10 * 90)
        }
        
    }

    private func registerXib() {
        nutrientCollectionView.register(
            UINib(nibName: AddCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: AddCollectionViewCell.identifier
        )
        foodCollectionView.register(
            UINib(nibName: AddCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: AddCollectionViewCell.identifier
        )
    }
    
    private func setCollectionView () {
        nutrientCollectionView.delegate = self
        nutrientCollectionView.dataSource = self
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
    }
}

extension AllNutrientAnalysisViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
