//
//  AllNutrientAnalysisViewController.swift
//  dietaryMedicine
//
//  Created by bora on 2022/07/14.
//

import UIKit
import Then
import RxSwift
import RxCocoa
import Resolver

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
    private var nutrientCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
        }
        layout.itemSize = CGSize(width: 85, height: 85)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    private var foodCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
        }
        layout.itemSize = CGSize(width: 85, height: 85)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    private var scrollView = UIScrollView()
    private var titleLabel = UILabel()
    private var nutrientLabel = UILabel()
    private var foodLabel = UILabel()
    private var nutrientAnalysisLabel = UILabel()
    private var nutrientAnalysisTableView = UITableView()

    @Injected private var allNutrientAnalysisViewModel: AllNutrientAnalysisViewModel
    @Injected private var disposeBag : DisposeBag
    
    var supplementsList: [Item]?
    var foodsList: [Item]?
    var allNutrientAnalysis: AllNutrientAnalysis? {
        didSet {
            nutrientAnalysisTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        registerXib()
        setCollectionView()
        setTableView()
        requestNutrientList()
        bindNutrientList()
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
            $0.width.equalTo(self.view.frame.width - 20)
            $0.top.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
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
            $0.height.equalTo(44 * 90)
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
        
        nutrientAnalysisTableView.register(
            UINib(nibName: AnalysisTableViewCell.identifier, bundle: nil)
            , forCellReuseIdentifier: AnalysisTableViewCell.identifier
        )
    }
    
    private func setCollectionView () {
        nutrientCollectionView.delegate = self
        nutrientCollectionView.dataSource = self
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
    }
    
    private func setTableView() {
        nutrientAnalysisTableView.delegate = self
        nutrientAnalysisTableView.dataSource = self
    }
    
    private func requestNutrientList() {
        let parameter: [String : String] = [:]
        allNutrientAnalysisViewModel.fetch(parameters: parameter)
    }
    
    private func bindNutrientList() {
        allNutrientAnalysisViewModel.output.data.asDriver(onErrorDriveWith: Driver.empty()).drive { result in
            switch result {
            case .success(let list):
                self.requestNutrientAnalysisSuccess(list)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }.disposed(by: disposeBag)
    }
    
    private func requestNutrientAnalysisSuccess(_ result: AllNutrientAnalysis) {
        allNutrientAnalysis = result
        print("✅: NUTRIENTANALYSIS NET SUCCESS")
    }
    
}

extension AllNutrientAnalysisViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case nutrientCollectionView:
            return supplementsList?.count ?? 0
        case foodCollectionView:
            return foodsList?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AddCollectionViewCell.identifier,
            for: indexPath
        ) as? AddCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let supplementsList = supplementsList else { return cell }
        guard let foodsList = foodsList else { return cell }
    
        switch collectionView {
        case nutrientCollectionView:
            cell.configureCellAll(type: "s", itemList: supplementsList, indexPathRow: indexPath.row)
            return cell
        case foodCollectionView:
            cell.configureCell(type: "f", itemList: foodsList, indexPathRow: indexPath.row)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension AllNutrientAnalysisViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AnalysisTableViewCell.identifier,
            for: indexPath) as? AnalysisTableViewCell else {
            return UITableViewCell()
        }
        
        guard let allNutrientAnalysisData = allNutrientAnalysis?.list else { return cell }
        cell.configure(
            nutrientName: allNutrientAnalysisData[indexPath.row].nutrientNameKor,
            nutrientImgUrl: allNutrientAnalysisData[indexPath.row].nutrientImage
        )
        
        return cell
    }
    
    
}
