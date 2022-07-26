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

class ItemDetailViewController: UIViewController, UIScrollViewDelegate {
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
    private var name = BasePaddingLabel()
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
    private var moreAnalysisButton = UIButton()
    
    private var lowestInfoView = UIView()
    private var lowestInfoLabel = UILabel()
    private var lowestInfoImgView = UIImageView()
    private var lowestInfoTitle = UILabel()
    private var lowestInfoPrice = UILabel()
    private var lowestInfoButton = UIButton()
    
    var tabBarTitle: [String] = []
    var infoType: [String] = []
    var nutrientName = ""
    var brand = ""
    var nutrientAmount = ""
    var nutrientUnit = ""
    var unit = ""
    
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
        
        scrollView.delegate = self
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewY = scrollView.contentOffset.y
        var headerFrame = collectionView.frame
        
        if scrollViewY < 370 {
            headerFrame.origin.y = collectionView.frame.origin.y
        }
        else {
            headerFrame.origin.y = scrollView.contentOffset.y
        }
        collectionView.frame = headerFrame
        
        guard let selectedCell0 = collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) else {
            return
        }
        guard let selectedCell1 = collectionView.cellForItem(at: IndexPath(row: 1, section: 0)) else {
            return
        }
        guard let selectedCell2 = collectionView.cellForItem(at: IndexPath(row: 2, section: 0)) else {
            return
        }
        
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height + scrollView.contentInset.bottom)
        
        if scrollViewY < analysisView.frame.origin.y - 50 {
            selectedCell0.isSelected = true
            selectedCell1.isSelected = false
            selectedCell2.isSelected = false
        }
        if scrollView.contentOffset.y >= analysisView.frame.origin.y - 50 {
            selectedCell0.isSelected = false
            selectedCell1.isSelected = true
            selectedCell2.isSelected = false
        }
        if scrollViewY == bottomOffset.y {
            selectedCell0.isSelected = false
            selectedCell1.isSelected = false
            selectedCell2.isSelected = true
        }
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
        stackView.bringSubviewToFront(collectionView)
        
        analysisView.addSubview(analysisLabel)
        analysisView.addSubview(analysisTableView)
        analysisView.addSubview(moreAnalysisButton)
        
        lowestInfoView.addSubview(lowestInfoLabel)
        lowestInfoView.addSubview(lowestInfoImgView)
        lowestInfoView.addSubview(lowestInfoTitle)
        lowestInfoView.addSubview(lowestInfoPrice)
        lowestInfoView.addSubview(lowestInfoButton)
        
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
        }
        
        imgView.snp.makeConstraints {
            $0.height.equalTo(300)
        }
        
        collectionView.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        analysisView.snp.makeConstraints {
            $0.height.equalTo(1030) // 130 + (분석 갯수 * 90)
        }
        
        analysisLabel.text = "영양소 분석"
        analysisLabel.textColor = .textGray
        analysisLabel.font = UIFont.boldSystemFont(ofSize: 14)
        analysisLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.leading.trailing.equalToSuperview().inset(20)
        }
        
        analysisTableView.snp.makeConstraints {
            $0.top.equalTo(analysisLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        moreAnalysisButton.setTitle("분석 더보기", for: .normal)
        moreAnalysisButton.setTitleColor(.black, for: .normal)
        moreAnalysisButton.backgroundColor = .mainGray
        moreAnalysisButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        moreAnalysisButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(analysisTableView.snp.bottom).offset(10)
            $0.bottom.leading.trailing.equalToSuperview().inset(20)
        }
        
        lowestInfoView.snp.makeConstraints {
            $0.height.equalTo(200)
        }
        
        lowestInfoLabel.text = "최저가 정보"
        lowestInfoLabel.textColor = .textGray
        lowestInfoLabel.font = UIFont.boldSystemFont(ofSize: 14)
        lowestInfoLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.leading.trailing.equalToSuperview().inset(20)
        }
        
        lowestInfoImgView.backgroundColor = .lightGray
        lowestInfoImgView.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.top.equalTo(lowestInfoLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(20)
        }
        
        lowestInfoTitle.text = "마켓컬리 어쩌고"
        lowestInfoTitle.font = UIFont.boldSystemFont(ofSize: 16)
        lowestInfoTitle.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(lowestInfoLabel.snp.bottom).offset(15)
            $0.leading.equalTo(lowestInfoImgView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(40)
        }
        
        lowestInfoPrice.text = "가격"
        lowestInfoPrice.font = UIFont.systemFont(ofSize: 14)
        lowestInfoPrice.textColor = .textGray
        lowestInfoPrice.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(lowestInfoTitle.snp.bottom).offset(10)
            $0.leading.equalTo(lowestInfoImgView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(40)
        }
        
        lowestInfoButton.setTitle("구매하기", for: .normal)
        lowestInfoButton.setTitleColor(.black, for: .normal)
        lowestInfoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        lowestInfoButton.backgroundColor = .mainGray
        lowestInfoButton.layer.cornerRadius = 8
        lowestInfoButton.snp.makeConstraints {
            $0.width.equalTo(120)
            $0.height.equalTo(40)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
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
        
        switch itemType {
        case .supplement:
            infoTableView.snp.makeConstraints {
                $0.height.equalTo(480)
            }
            tabBarTitle = ["비타민 정보", "비타민 분석", "구매정보"]
            infoType = ["영양제 종류", "브랜드", "데일리 복용량", "영양제 형태"]
            nutrientName = supplementData.nutrientAmounts.first?.nutrientNameKor ?? ""
            brand = supplementData.brand
            nutrientAmount = String(supplementData.nutrientAmounts.first?.nutrientAmount ?? 0.0)
            nutrientUnit = supplementData.nutrientAmounts.first?.nutrientAmountUnit ?? ""
            unit = unitChange(unit: supplementData.unit)
            
        case .food:
            //최저가 정보, 영양제 형태 없음 
            lowestInfoView.isHidden = true
            infoTableView.snp.makeConstraints {
                $0.height.equalTo(360)
            }
            tabBarTitle = ["식품 정보", "식품 분석"]
            infoType = ["식품 이름", "분류", "1인분"]
            nutrientName = foodData.nutrientAmounts.first?.nutrientNameKor ?? ""
            brand = foodData.brand
            nutrientAmount = String(foodData.nutrientAmounts.first?.nutrientAmount ?? 0.0)
            nutrientUnit = foodData.nutrientAmounts.first?.nutrientAmountUnit ?? ""
            unit = ""
        }
    }
    
    private func setTableView() {
        infoTableView.delegate = self
        infoTableView.dataSource = self
        analysisTableView.delegate = self
        analysisTableView.dataSource = self
        
        infoTableView.isScrollEnabled = false
        analysisTableView.isScrollEnabled = false
        
        infoTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        analysisTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let tabBarLayout = UICollectionViewFlowLayout()
        tabBarLayout.itemSize = CGSize.init(width: Int(self.view.frame.width) / tabBarTitle.count, height: 50)
        tabBarLayout.minimumLineSpacing = 0
        tabBarLayout.minimumInteritemSpacing = 0
        collectionView.collectionViewLayout = tabBarLayout
    }
    
    private func registerXib() {
        infoTableView.register(
            UINib(nibName: ItemInfoTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ItemInfoTableViewCell.identifier)
        analysisTableView.register(
            UINib(nibName: AnalysisTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: AnalysisTableViewCell.identifier)
        analysisTableView.register(
            UINib(nibName: SeeMoreCombinationTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: SeeMoreCombinationTableViewCell.identifier)
        collectionView.register(
            UINib(nibName: TabBarHeaderCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: TabBarHeaderCollectionViewCell.identifier)
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
    
    private func requestAddItem() {
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
    
    private func unitChange(unit: String) -> String {
        switch unit {
        case "L":
            return "액체"
        case "T":
            return "알약"
        case "P":
            return "파우더"
        default:
            return ""
        }
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
            
            imgView.kingFisherSetImage(url: url!)
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
            
            imgView.kingFisherSetImage(url: url!)
        }
        else {
            imgView.image = nil
        }
    }


}
extension ItemDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == analysisTableView {
            return 90
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case infoTableView:
            switch itemType {
            case .supplement: return 4
            case .food: return 3
            }
        case analysisTableView:
            return 10
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case infoTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemInfoTableViewCell.identifier, for: indexPath) as? ItemInfoTableViewCell else {
                return UITableViewCell()
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
        case analysisTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AnalysisTableViewCell.identifier, for: indexPath) as? AnalysisTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(
                nutrientName: "영양제",
                nutrientImgUrl: "https://nutrition-helper-bucket.s3.ap-northeast-2.amazonaws.com/image/nutrient-circle/1/LC.png"
            )
            
            return cell
            
        default:
            return UITableViewCell()
        }
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
            scrollView.scroll(to: .info, y: infoTableView.frame.origin.y)
        case 1:
            scrollView.scroll(to: .analysis, y: analysisView.frame.origin.y)
        case 2:
            scrollView.scroll(to: .buyInfo, y: lowestInfoView.frame.origin.y)
        default:
            return
        }
    }
}
