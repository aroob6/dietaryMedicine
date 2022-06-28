//
//  EachNutrientViewController.swift
//  dietaryMedicine
//
//  Created by bora on 2022/06/27.
//

import UIKit

class EachNutrientViewController: UIViewController {
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    private var analysisView = UIView()
    private var nutrientView = UIView()
    private var currentView = UIView()
    
    private var currentLabel = UILabel()
    private var countLabel = UILabel()
    private var underLine = UIView()
    private var tableView = UITableView()
    
    let bottomLayoutGuideBox = UIView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        registerXib()
        setTableView()
    }

    private func setUI(){
        self.navigationItem.title = "개별 영양분 분석"
        self.view.backgroundColor = .analysisColor
        bottomLayoutGuideBox.backgroundColor = .white
        
        self.view.addSubview(scrollView)
        self.view.addSubview(bottomLayoutGuideBox)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(analysisView)
        contentView.addSubview(nutrientView)
        contentView.addSubview(currentView)
        
        currentView.addSubview(currentLabel)
        currentView.addSubview(countLabel)
        currentView.addSubview(underLine)
        currentView.addSubview(tableView)
        
        scrollView.backgroundColor = .clear
        scrollView.snp.makeConstraints {
            $0.bottom.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
//            $0.bottom.equalTo(self.view.snp.bottom)
        }
        
        bottomLayoutGuideBox.snp.makeConstraints {
            $0.left.equalTo(self.view)
            $0.right.equalTo(self.view)
            $0.top.equalTo(self.bottomLayoutGuide.snp.top)
            $0.bottom.equalTo(self.bottomLayoutGuide.snp.bottom)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        analysisView.backgroundColor = .white
        analysisView.layer.cornerRadius = 16
        analysisView.snp.makeConstraints {
            $0.height.equalTo(260)
            $0.top.equalTo(contentView.snp.top).inset(10)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }
        
        nutrientView.backgroundColor = .white
        nutrientView.layer.cornerRadius = 16
        nutrientView.snp.makeConstraints {
            $0.height.equalTo(150)
            $0.top.equalTo(analysisView.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }
        
        currentView.backgroundColor = .white
        currentView.snp.makeConstraints {
            $0.top.equalTo(nutrientView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
        
        currentLabel.text = "현황"
        currentLabel.font = UIFont.boldSystemFont(ofSize: 14)
        currentLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalToSuperview().inset(30)
            $0.leading.equalToSuperview().inset(20)
        }
        
        countLabel.text = "총 2개"
        countLabel.textColor = .underLine
        countLabel.font = UIFont.boldSystemFont(ofSize: 14)
        countLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        underLine.backgroundColor = .mainGray
        underLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(currentLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
        
        tableView.snp.makeConstraints {
            $0.height.equalTo(150 * 5)
            $0.top.equalTo(underLine.snp.bottom).offset(10)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func registerXib() {
        tableView.register(
            UINib(nibName: CurrentTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CurrentTableViewCell.identifier)
    }
    
    private func setTableView () {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension EachNutrientViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentTableViewCell.identifier, for: indexPath) as? CurrentTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}
