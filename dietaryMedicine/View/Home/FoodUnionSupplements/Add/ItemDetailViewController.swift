//
//  DetailFoodViewController.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/17.
//

import UIKit
import SnapKit
import Moya
import Kingfisher
import RxSwift
import RxCocoa
import Resolver
import SwiftUI

enum ItemType {
    case supplement
    case food
}

class ItemDetailViewController: UIViewController {
    private var stackView: UIStackView = {
        let view = UIStackView().then {
            $0.backgroundColor = .clear
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fillProportionally
        }
        return view
    }()
    
    private var buttonStackView: UIStackView = {
        let view = UIStackView().then {
            $0.backgroundColor = .clear
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fill
        }
        return view
    }()
    
    private let scrollView = UIScrollView()
    private var imgView = UIImageView()
    private var name: UILabel = {
        let label = BasePaddingLabel(padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        return label
    }()
    
    private var bookMarkButton = UIButton()
    private var addButton = UIButton()
    private var supplementID = 0
    private var foodID = 0
    var itemType = ItemType.supplement
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
        }
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    private var infoTableView = UITableView()
    private var analysisView = UIView()
    private var analysisLabel = UILabel()
    private var analysisTableView = UITableView()
    
    private var lowestInfoView = UIView()
    private var lowestInfoLabel = UILabel()
    
    let tabBarTitle = ["비타민 정보", "비타민 분석", "구매정보"]
    let infoType = ["영양제 종류", "브랜드", "데일리 복용량", "영양제 형태"]
    var supplementData = Supplements()
    var foodData = Foods()
    
    @Injected private var itemDetailViewModel: ItemAddViewModel
    
    //RxSwift
    @Injected private var disposeBag : DisposeBag

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setTableView()
        setCollectionView()
        registerXib()
        
        bindButton()
        bindAddItem()
    }
    
    private func setUI() {
        view.backgroundColor = .white
        stackView.backgroundColor = .mainGray
        scrollView.backgroundColor = .mainGray
        analysisView.backgroundColor = .white
        lowestInfoView.backgroundColor = .white
        buttonStackView.backgroundColor = .white
        
        view.addSubview(scrollView)
        view.addSubview(buttonStackView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(imgView)
        stackView.setCustomSpacing(20, after: imgView)
        stackView.addArrangedSubview(collectionView)
        stackView.addArrangedSubview(infoTableView)
        stackView.addArrangedSubview(analysisView)
        stackView.setCustomSpacing(20, after: analysisView)
        stackView.addArrangedSubview(lowestInfoView)
        
        analysisView.addSubview(analysisLabel)
        analysisView.addSubview(analysisTableView)
        lowestInfoView.addSubview(lowestInfoLabel)
        
        buttonStackView.addArrangedSubview(bookMarkButton)
        buttonStackView.addArrangedSubview(addButton)
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        stackView.snp.makeConstraints {
            $0.width.equalTo(self.view.frame.width)
            $0.edges.equalToSuperview()
        }
        
        name.font = .boldSystemFont(ofSize: 25)
        name.backgroundColor = .white
        name.snp.makeConstraints {
            $0.height.equalTo(50)
//            $0.width.equalTo(self.scrollView).inset(scrollView.layoutMargins)
        }
        
        imgView.snp.makeConstraints {
            $0.height.equalTo(300)
        }
        
        imgView.backgroundColor = .yellow
        
        collectionView.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        collectionView.backgroundColor = .green
        
        infoTableView.snp.makeConstraints {
            $0.height.equalTo(480)
        }
        
        analysisView.snp.makeConstraints {
            $0.height.equalTo(210)
        }
        
        analysisLabel.text = "비타민 분석"
        analysisLabel.textColor = .textGray
        analysisLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.leading.trailing.equalToSuperview().inset(20)
        }
        
        analysisTableView.backgroundColor = .magenta
        analysisTableView.snp.makeConstraints {
            $0.top.equalTo(analysisLabel.snp.bottom).offset(20)
            $0.bottom.leading.trailing.equalToSuperview().inset(20)
        }
        
        lowestInfoView.snp.makeConstraints {
            $0.height.equalTo(195)
        }
        
        lowestInfoLabel.text = "최저가 정보"
        lowestInfoLabel.textColor = .textGray
        lowestInfoLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.leading.trailing.equalToSuperview().inset(20)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.top.equalTo(scrollView.snp.bottom).offset(10)
            $0.bottom.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(10)
        }
        
        bookMarkButton.snp.makeConstraints {
            $0.width.height.equalTo(55)
        }
        
        addButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.height.equalTo(55)
        }
        
        bookMarkButton.setImage(UIImage(named: "bookMark"), for: .normal)
        
        addButton.backgroundColor = .mainColor
        addButton.setTitle("추가하기", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.layer.cornerRadius = 8
    }
    
    private func setTableView() {
        infoTableView.delegate = self
        infoTableView.dataSource = self
        
        infoTableView.isScrollEnabled = false
        infoTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let tabBarLayout = UICollectionViewFlowLayout()
        tabBarLayout.itemSize = CGSize.init(width: self.view.frame.width / 3, height: 50)
        tabBarLayout.minimumLineSpacing = 0
        tabBarLayout.minimumInteritemSpacing = 0
        collectionView.collectionViewLayout = tabBarLayout
    }
    
    private func registerXib() {
        infoTableView.register(UINib(nibName: ItemInfoTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ItemInfoTableViewCell.identifier)
        collectionView.register(UINib(nibName: TabBarHeaderCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TabBarHeaderCollectionViewCell.identifier)
    }
    
    private func bindButton() {
        addButton.rx.tap.bind { [weak self] in
            self?.requestAddItem()
        }.disposed(by: disposeBag)
    }
    
    private func bindAddItem() {
        itemDetailViewModel.output.data.asDriver(onErrorDriveWith: Driver.empty())
            .drive { result in
                switch result {
                case .success(let code):
                    if code == 2000 {
                        self.requestAddItemSuccess()
                        StaticDelegate.mainDelegate?.unionItemRefresh()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            }
            .disposed(by: disposeBag)
    }
    
    private func requestAddItemSuccess() {
        print("✅: ITEM ADD SUCCESS")
        
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    @objc func requestAddItem() {
        var parameter : [String: Int] = [:]
        
        switch itemType {
        case .supplement:
            parameter["supplement_id"] = supplementID
        case .food:
            parameter["food_id"] = foodID
        }
        itemDetailViewModel.itemType = itemType
        itemDetailViewModel.fetch(parameters: parameter)
    }
    
    func configureCell(supplementList: SupplementList, indexPath: IndexPath) {
        let supplementData = supplementList.data[indexPath.row]
        self.supplementData = supplementData
        supplementID = supplementData.supplementID
        name.text = supplementData.name
        itemType = .supplement
        
        if supplementData.image != "" {
            let imgURL = supplementData.image
            let url = URL(string: imgURL)
            
            imgView.kf.setImage(
                with: url,
                options: [
                    .transition(ImageTransition.fade(0.3)),
                    .keepCurrentImageWhileLoading
                ]
            )
        }
        else {
            imgView.image = nil
        }
    }
    
    func configureCell(foodList: FoodList, indexPath: IndexPath) {
        let foodData = foodList.data[indexPath.row]
        self.foodData = foodData
        foodID = foodData.foodID
        name.text = foodData.name
        itemType = .food
        
        if foodData.image != "" {
            let imgURL = foodData.image
            let url = URL(string: imgURL)
            
            imgView.kf.setImage(
                with: url,
                options: [
                    .transition(ImageTransition.fade(0.3)),
                    .keepCurrentImageWhileLoading
                ]
            )
        }
        else {
            imgView.image = nil
        }
    }


}
extension ItemDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemInfoTableViewCell.identifier, for: indexPath) as? ItemInfoTableViewCell else {
            return UITableViewCell()
        }
        
        var nutrientName = ""
        var brand = ""
        var nutrientAmount = ""
        var nutrientUnit = ""
        var unit = ""
        
        switch itemType {
        case .supplement:
            nutrientName = supplementData.nutrientAmounts.first?.nutrientNameKor ?? ""
            brand = supplementData.brand
            nutrientAmount = String(supplementData.nutrientAmounts.first?.nutrientAmount ?? 0.0)
            nutrientUnit = supplementData.nutrientAmounts.first?.nutrientAmountUnit ?? ""
            unit = supplementData.unit
        case .food:
            nutrientName = foodData.nutrientAmounts.first?.nutrientNameKor ?? ""
            brand = foodData.brand
            nutrientAmount = String(foodData.nutrientAmounts.first?.nutrientAmount ?? 0.0)
            nutrientUnit = foodData.nutrientAmounts.first?.nutrientAmountUnit ?? ""
            unit = ""
        }
        
        switch indexPath.row {
        case 0:
            cell.type.text = infoType[0]
            cell.name.text = nutrientName
        case 1:
            cell.type.text = infoType[1]
            cell.name.text = brand
        case 2:
            cell.type.text = infoType[2]
            cell.name.text = nutrientAmount + " " + nutrientUnit
        case 3:
            cell.type.text = infoType[3]
            cell.name.text = unit
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    
}

extension ItemDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabBarTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabBarHeaderCollectionViewCell.identifier, for: indexPath) as? TabBarHeaderCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.tabBarTitle.text = tabBarTitle[indexPath.row]
        cell.deselectTabItem()
        if indexPath.row == 0 {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
            cell.isSelected = true
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            scrollView.scroll(to: .info)
        case 1:
            scrollView.scroll(to: .analysis)
        case 2:
            scrollView.scroll(to: .buyInfo)
        default:
            return
        }
    }
}
