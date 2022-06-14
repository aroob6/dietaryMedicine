//
//  MyCollectionViewController.swift
//  dietaryMedicine
//
//  Created by bora on 2022/06/14.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Resolver
import Alamofire

class MyCollectionViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var myNutrientDiaryList: [MyNutrientDiaryList]?

    @Injected private var nutrientDiaryViewModel :NutrientDiaryViewModel
    @Injected private var disposeBag : DisposeBag
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        requestMyNutrientDiaryList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
        registerXib()
        
        bindMyNutrientDiaryList()
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
    }
    
    private func registerXib() {
        tableView.register(
            UINib(nibName: AnotherCombinationTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: AnotherCombinationTableViewCell.identifier
        )
    }
    
    private func requestMyNutrientDiaryList() {
        let parameter: [String : String] = [:]
        
        nutrientDiaryViewModel.fetch(parameters: parameter)
    }
    
    private func bindMyNutrientDiaryList() {
        nutrientDiaryViewModel.output.data.asDriver(onErrorDriveWith: Driver.empty()).drive { result in
            switch result {
            case .success(let list):
                self.requestMyNutrientDiaryListSuccess(list)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        .disposed(by: disposeBag)
    }
    
    private func requestMyNutrientDiaryListSuccess(_ result: MyNutrientDiary) {
        print("✅: MYNUTRIENTDIARYLIST NET SUCCESS")
    
        myNutrientDiaryList = result.list
        tableView.reloadData()
    }


}

extension MyCollectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 300
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myNutrientDiaryList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AnotherCombinationTableViewCell.identifier,
            for: indexPath) as? AnotherCombinationTableViewCell
        else {
            return UITableViewCell()
        }
        guard let myNutrientDiaryList = myNutrientDiaryList else { return cell }
        cell.configureCell(myNutrientDiaryList[indexPath.row].content, myNutrientDiaryList[indexPath.row])
        
        return cell
    }
    
    
}
