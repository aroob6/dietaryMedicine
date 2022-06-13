//
//  CollectionAddViewController.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/06/11.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        registerXib()
        setTableView()
    }

    private func setUI(){
        self.tabBarController?.tabBar.isHidden = true
        self.view.backgroundColor = .white
        self.view.addSubview(tableViewLabel)
        self.view.addSubview(stackView)
        self.view.addSubview(addButton)
        
        stackView.addArrangedSubview(tableView)
        stackView.setCustomSpacing(15, after: tableView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(contentLabel)
        stackView.addArrangedSubview(contentTextField)
        
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

}

extension CollectionAddViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AddTableViewCell.identifier,
            for: indexPath) as? AddTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}
