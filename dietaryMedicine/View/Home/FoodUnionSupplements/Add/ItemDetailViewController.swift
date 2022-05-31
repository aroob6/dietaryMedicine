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
    private var name = UILabel()
    private var content = UILabel()
    private var link = UILabel()
    private var bookMarkButton = UIButton()
    private var addButton = UIButton()
    private var supplementID = 0
    private var foodID = 0
    var itemType = ItemType.supplement
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.minimumInteritemSpacing = 0
            $0.minimumLineSpacing = 15
        }
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    private var infoTableView = UITableView()
    private var analysisView = UIView()
    private var lowestInfoView = UIView()
    
    let tabBarTitle = ["비타민 정보", "비타민 분석", "구매정보"]
    
    @Injected private var itemDetailViewModel: ItemAddViewModel
    
    //RxSwift
    @Injected private var disposeBag : DisposeBag

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setUpCollectionView()
        
        bindButton()
        bindAddItem()
    }
    
    private func setUI() {
        view.backgroundColor = .white
        stackView.backgroundColor = .mainGray
        scrollView.backgroundColor = .mainGray
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.addSubview(buttonStackView)
        
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(imgView)
        stackView.setCustomSpacing(20, after: imgView)
        
        stackView.addArrangedSubview(collectionView)
        stackView.addArrangedSubview(infoTableView)
        stackView.addArrangedSubview(analysisView)
        stackView.setCustomSpacing(20, after: analysisView)
        
        stackView.addArrangedSubview(lowestInfoView)
        
        buttonStackView.addArrangedSubview(bookMarkButton)
        buttonStackView.addArrangedSubview(addButton)
        buttonStackView.setCustomSpacing(10, after: addButton)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.width.equalTo(self.view.frame.width)
            $0.top.leading.trailing.equalToSuperview()
        }
        
        name.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        name.backgroundColor = .red
        
        imgView.snp.makeConstraints {
            $0.height.equalTo(300)
        }
        
        imgView.backgroundColor = .yellow
        
        collectionView.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        collectionView.backgroundColor = .green
        
        infoTableView.snp.makeConstraints {
            $0.height.equalTo(400)
        }
        
        infoTableView.backgroundColor = .blue
        
        analysisView.snp.makeConstraints {
            $0.height.equalTo(210)
        }
        
        analysisView.backgroundColor = .magenta
        
        lowestInfoView.snp.makeConstraints {
            $0.height.equalTo(195)
        }
        
        lowestInfoView.backgroundColor = .gray
        
        buttonStackView.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.top.equalTo(stackView.snp.bottom).offset(20)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        bookMarkButton.snp.makeConstraints {
            $0.width.height.equalTo(55)
        }
        
        addButton.snp.makeConstraints {
            $0.height.equalTo(55)
        }
        
        bookMarkButton.setImage(UIImage(named: "bookMark"), for: .normal)
        
        addButton.backgroundColor = .mainColor
        addButton.setTitle("추가하기", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.layer.cornerRadius = 8
    }
    
    func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }
    
//    private func setUI(){
//        view.backgroundColor = .white
//        view.addSubview(scrollView)
//        scrollView.addSubview(stackView)
//        scrollView.addSubview(buttonStackView)
//
//        stackView.addArrangedSubview(imgView)
//        stackView.addArrangedSubview(name)
//        stackView.addArrangedSubview(content)
//        stackView.addArrangedSubview(link)
//
//        buttonStackView.addArrangedSubview(bookMarkButton)
//        buttonStackView.addArrangedSubview(addButton)
//
//        imgView.backgroundColor = .green
//
//        name.textColor = .black
//        name.backgroundColor = .lightGray
//
//        content.textColor = .black
//        content.backgroundColor = .blue
//
//        link.textColor = .black
//        link.backgroundColor = .yellow
//
//        bookMarkButton.setImage(UIImage(named: "bookMark"), for: .normal)
//
//        addButton.backgroundColor = .mainColor
//        addButton.setTitle("추가하기", for: .normal)
//        addButton.setTitleColor(.white, for: .normal)
//        addButton.layer.cornerRadius = 8
//
//        scrollView.snp.makeConstraints {
//            $0.edges.equalToSuperview().inset(10)
//        }
//
//        stackView.snp.makeConstraints {
//            $0.width.equalTo(self.view.frame.width - 20)
//            $0.top.leading.trailing.equalToSuperview()
//
//        }
//        imgView.snp.makeConstraints {
//            $0.height.equalTo(view.frame.height/12 * 5)
//        }
//        name.snp.makeConstraints {
//            $0.height.equalTo(view.frame.height/12 * 1)
//        }
//        content.snp.makeConstraints {
//            $0.height.equalTo(view.frame.height/12 * 5)
//        }
//        link.snp.makeConstraints {
//            $0.height.equalTo(view.frame.height/12 * 1)
//        }
//
//        buttonStackView.snp.makeConstraints {
//            $0.height.equalTo(60)
//            $0.top.equalTo(stackView.snp.bottom).offset(20)
//            $0.bottom.leading.trailing.equalToSuperview()
//
//        }
//
//        bookMarkButton.snp.makeConstraints {
//            $0.width.height.equalTo(60)
//        }
//
//        addButton.snp.makeConstraints {
//            $0.height.equalTo(60)
//        }
//    }
    
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
        supplementID = supplementData.supplementID
        name.text = supplementData.name
        content.text = supplementData.content
        link.text = supplementData.link
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
        foodID = foodData.foodID
        name.text = foodData.name
        content.text = foodData.content
        link.text = foodData.link
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

extension ItemDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let tabBarCell = collectionView.dequeueReusableCell(withReuseIdentifier: TabBarHeaderCell.identifier, for: indexPath) as! TabBarHeaderCell
//        tabBarCell.tabBarTitle.text = tabBarTitle[indexPath.row]
//        tabBarCell.deselectTabItem()
//        if indexPath.row == 0 {
//            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
//            tabBarCell.isSelected = true
//        }
//        return tabBarCell
        
        return UICollectionViewCell()
    }
    
    
}
