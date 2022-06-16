//
//  CollectionAddViewController.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/06/11.
//

import UIKit
import RxSwift
import RxCocoa
import Resolver
import Alamofire

class CollectionAddViewController: UIViewController {

    private var stackView: UIStackView = {
        let view = UIStackView().then {
            $0.backgroundColor = .clear
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fillProportionally
        }
        return view
    }()
    
    private var addButton = UIButton()
    private var tableViewLabel = BasePaddingLabel()
    private var tableView = UITableView()
    private var titleLabel = BasePaddingLabel()
    private var contentLabel = BasePaddingLabel()
    private var titleTextField = UITextField()
    private var contentTextField = UITextField()
    
    var supplementsList: [Item]?
    var foodsList: [Item]?
    var itemList = [Item]()
    var titleText = ""
    var contentText = ""
    
//    private var keyBoardManager: KeyboardManager?
//    private var scrollView = UIScrollView()
    
    @Injected private var nutrientDiaryAddViewModel: NutrientDiaryAddViewModel
    @Injected private var disposeBag: DisposeBag
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
//        keyBoardManager = KeyboardManager(view: view, set: false)
//        keyBoardManager?.addKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        keyBoardManager?.removeKeyboardNotification()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        registerXib()
        setTableView()
        setItem()
        
        bindButton()
        bindNutrientDiaryAdd()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setUI(){
        self.navigationItem.title = "컬렉션 추가"
//        self.navigationController?.navigationBar.backgroundColor = .white
        self.view.backgroundColor = .white
//        self.view.addSubview(scrollView)
//
//        scrollView.addSubview(tableViewLabel)
//        scrollView.addSubview(stackView)
//        scrollView.addSubview(addButton)
        self.view.addSubview(tableViewLabel)
        self.view.addSubview(stackView)
        self.view.addSubview(addButton)
        
        stackView.addArrangedSubview(tableView)
        stackView.setCustomSpacing(15, after: tableView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(contentLabel)
        stackView.addArrangedSubview(contentTextField)
        
//        scrollView.snp.makeConstraints {
//            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
//        }
        
        tableViewLabel.text = "내 아이템"
        tableViewLabel.font = UIFont.boldSystemFont(ofSize: 14)
        tableViewLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        stackView.backgroundColor = .mainGray
        stackView.snp.makeConstraints {
            $0.height.equalTo(475)
            $0.top.equalTo(tableViewLabel.snp.bottom)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        addButton.setTitle("추가하기", for: .normal)
        addButton.backgroundColor = .mainColor
        addButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.bottom.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints {
            $0.height.equalTo(300)
        }
        
        titleLabel.text = "컬렉션 제목"
        contentLabel.text = "컬렉션 내용"
        
        titleTextField.placeholder = "제목을 적어주세요"
        contentTextField.placeholder = "내용을 적어주세요"
        
        titleTextField.addLeftPadding()
        contentTextField.addLeftPadding()
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        contentLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleTextField.font = UIFont.boldSystemFont(ofSize: 16)
        contentTextField.font = UIFont.boldSystemFont(ofSize: 16)
        
        titleLabel.backgroundColor = .white
        contentLabel.backgroundColor = .white
        titleTextField.backgroundColor = .white
        contentTextField.backgroundColor = .white
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        titleTextField.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        contentLabel.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        contentTextField.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
    }
    
    private func registerXib() {
        tableView.register(
            UINib(nibName: AddTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: AddTableViewCell.identifier)
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func bindButton() {
        addButton.rx.tap.bind { [weak self] in
            self?.addAction()
        }.disposed(by: disposeBag)
    }
    
    private func setItem() {
        guard let supplementsList = supplementsList else { return }
        guard let foodsList = foodsList else { return }
        
        for i in 0 ..< supplementsList.count {
            itemList.append(supplementsList[i])
        }
        for i in 0 ..< foodsList.count {
            itemList.append(foodsList[i])
        }
    }
    
    private func addAction() {
        guard let titleText = titleTextField.text, !titleText.isEmpty else {
            let msg = "컬렉션 제목을 입력해주세요."
            UtilFunction.showMessage(msg: msg, vc: self)
            return
        }
        
        guard let contentText = titleTextField.text, !contentText.isEmpty else {
            let msg = "컬렉션 내용을 입력해주세요."
            UtilFunction.showMessage(msg: msg, vc: self)
            return
        }
        
        self.titleText = titleText
        self.contentText = contentText
        
        requestNutrientDiaryAdd()
    }
    
    private func requestNutrientDiaryAdd() {
        let parameter: [String : String] = [
            "title": titleText,
            "content": contentText
        ]
        
        nutrientDiaryAddViewModel.fetch(parameters: parameter)
    }

    private func bindNutrientDiaryAdd() {
        nutrientDiaryAddViewModel.output.data.asDriver(onErrorDriveWith: Driver.empty()).drive { result in
            switch result {
            case .success(let code):
                if code == 2000 {
                    self.requestNutrientDiaryListSuccess()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        .disposed(by: disposeBag)
    }
    
    private func requestNutrientDiaryListSuccess() {
        print("✅: NUTRIENTDIARYADD NET SUCCESS")
        
        self.navigationController?.popViewController(animated: false)
    }
}

extension CollectionAddViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (supplementsList?.count ?? 0) + (foodsList?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AddTableViewCell.identifier,
            for: indexPath) as? AddTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(itemList: itemList, indexPath: indexPath)
        return cell
    }
}
