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
    private var nutrientView = UIView()
    private var currentView = UIView()
    
    private var currentLabel = UILabel()
    private var countLabel = UILabel()
    private var underLine = UIView()
    private var tableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    private func setUI(){
        self.navigationItem.title = "개별 영양분 분석"
        self.view.backgroundColor = .analysisColor
        self.view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        scrollView.addSubview(nutrientView)
        scrollView.addSubview(currentView)
        
        currentView.addSubview(currentLabel)
        currentView.addSubview(countLabel)
        currentView.addSubview(underLine)
        currentView.addSubview(tableView)
        
        scrollView.backgroundColor = .clear
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.view.snp.bottom)
        }
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.snp.makeConstraints {
            $0.height.equalTo(260)
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }
        
        nutrientView.backgroundColor = .white
        nutrientView.layer.cornerRadius = 16
        nutrientView.snp.makeConstraints {
            $0.height.equalTo(150)
            $0.top.equalTo(contentView.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }
        
        currentView.backgroundColor = .white
        currentView.snp.makeConstraints {
            $0.top.equalTo(nutrientView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.view.snp.bottom)
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
        
        underLine.backgroundColor = .underLine
        underLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(currentLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(underLine.snp.bottom).offset(20)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
}
