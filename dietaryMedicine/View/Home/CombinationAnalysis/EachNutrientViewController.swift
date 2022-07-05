//
//  EachNutrientViewController.swift
//  dietaryMedicine
//
//  Created by bora on 2022/06/27.
//

import UIKit
import Kingfisher

class EachNutrientViewController: UIViewController {
    static let progressBarSize: Float = 290.0
    
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    private var analysisView = UIView()
    private var nutrientView = UIView()
    private var currentView = UIView()
    
    private var titleLabel = UILabel()
    private var contentLabel = UILabel()
    
    private var nutrientImgView = UIImageView()
    private var nutrientLabel = UILabel()
    private var progressBar = UIProgressView()
    private var triangleRecommend = TriangleView()
    private var triangleRecommendLabel = UILabel()
    private var triangleMax = TriangleView()
    private var triangleMaxLabel = UILabel()
    private var triangleCurrent = TriangleView()
    private var triangleCurrentLabel = UILabel()
    
    private var currentLabel = UILabel()
    private var countLabel = UILabel()
    private var underLine = UIView()
    private var tableView = UITableView()
    
    private let bottomLayoutGuideBox = UIView()
    
    var nutrientData = DeficiencyNutrient()
    var nutrientStandardText = ""
    
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
        
        analysisView.addSubview(titleLabel)
        analysisView.addSubview(contentLabel)
        
        nutrientView.addSubview(nutrientImgView)
        nutrientView.addSubview(nutrientLabel)
        nutrientView.addSubview(progressBar)
        nutrientView.addSubview(triangleRecommend)
        nutrientView.addSubview(triangleRecommendLabel)
        nutrientView.addSubview(triangleMax)
        nutrientView.addSubview(triangleMaxLabel)
        nutrientView.addSubview(triangleCurrent)
        nutrientView.addSubview(triangleCurrentLabel)
        
        currentView.addSubview(currentLabel)
        currentView.addSubview(countLabel)
        currentView.addSubview(underLine)
        currentView.addSubview(tableView)
        
        scrollView.backgroundColor = .clear
        scrollView.snp.makeConstraints {
            $0.bottom.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
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
        
        titleLabel.text = Info.share.name + "님의 " + nutrientData.nutrientName
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        contentLabel.text = "비타민 B6는 신경전달물질 합성, 유전자 발현 등 여러 반응을 보조해요. \n\n비타민 B6 효능: 혈당 유지, 지루성 피부염, 관절염, 지방대사 \n비타민 B6 부족 시: 빈혈, 신경 손상, 피부염, 습진, 면역반응 억제 \n비타민 B6 과다 시: 신경을 손상시켜 발과 다리에 통증과 무감각증을 유발할 수 있어요\n비타민 B6 과다 시: 신경을 손상시켜 발과 다리에 통증과 무감각증을 유발할 수 있어요\n비타민 B6 과다 시: 신경을 손상시켜 발과 다리에 통증과 무감각증을 유발할 수 있어요"
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.textColor = .textGray
        contentLabel.numberOfLines = 0
        contentLabel.sizeToFit()
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        nutrientView.backgroundColor = .white
        nutrientView.layer.cornerRadius = 16
        nutrientView.snp.makeConstraints {
            $0.height.equalTo(150)
            $0.top.equalTo(analysisView.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }
        
        let imgURL = URL(string: nutrientData.nutrientImg) ?? URL(string: "")
        let processor = RoundCornerImageProcessor(cornerRadius: 8)
        nutrientImgView.kingFisherSetImage(url: imgURL!, processor: processor)

        nutrientImgView.layer.cornerRadius = nutrientImgView.frame.height / 2
        nutrientImgView.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.top.leading.equalToSuperview().inset(20)
        }
        
        nutrientLabel.text = nutrientData.nutrientName + " " + nutrientStandardText
        nutrientLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nutrientLabel.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalTo(nutrientImgView.snp.trailing).offset(20)
        }
        
        progressBar.tintColor = .analysisColor
        progressBar.setProgress(0.95, animated: false)
        progressBar.snp.makeConstraints {
            $0.width.equalTo(EachNutrientViewController.progressBarSize)
            $0.height.equalTo(3)
            $0.top.equalTo(nutrientImgView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        
        let currentValue = progressBar.progress
        let recommendValue: Float = 0.1
        let maxValue: Float = 0.6
        
        
        triangleRecommend.backgroundColor = .white
        triangleRecommend.snp.makeConstraints {
            $0.width.equalTo(6)
            $0.height.equalTo(5)
            $0.top.equalTo(progressBar.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(EachNutrientViewController.progressBarSize * recommendValue + 15)
        }
        
        triangleRecommendLabel.text = "권장"
        triangleRecommendLabel.textColor = .textGray
        triangleRecommendLabel.font = UIFont.systemFont(ofSize: 8)
        triangleRecommendLabel.snp.makeConstraints {
            $0.width.equalTo(40)
            $0.top.equalTo(triangleCurrent.snp.bottom).offset(5)
            $0.centerX.equalTo(triangleRecommend.snp.centerX).offset(13)
        }
        
        triangleMax.backgroundColor = .white
        triangleMax.snp.makeConstraints {
            $0.width.equalTo(6)
            $0.height.equalTo(5)
            $0.top.equalTo(progressBar.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(EachNutrientViewController.progressBarSize * maxValue + 15)
        }
        
        triangleMaxLabel.text = "최대"
        triangleMaxLabel.textColor = .textGray
        triangleMaxLabel.font = UIFont.systemFont(ofSize: 8)
        triangleMaxLabel.snp.makeConstraints {
            $0.width.equalTo(40)
            $0.top.equalTo(triangleCurrent.snp.bottom).offset(5)
            $0.centerX.equalTo(triangleMax.snp.centerX).offset(13)
        }
        
        triangleCurrent.backgroundColor = .white
        triangleCurrent.snp.makeConstraints {
            $0.width.equalTo(6)
            $0.height.equalTo(5)
            $0.top.equalTo(progressBar.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(EachNutrientViewController.progressBarSize * currentValue + 15)
        }
        
        triangleCurrentLabel.text = "현재"
        triangleCurrentLabel.textColor = .textGray
        triangleCurrentLabel.font = UIFont.systemFont(ofSize: 8)
        triangleCurrentLabel.snp.makeConstraints {
            $0.width.equalTo(40)
            $0.top.equalTo(triangleCurrent.snp.bottom).offset(5)
            $0.centerX.equalTo(triangleCurrent.snp.centerX).offset(13)
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
