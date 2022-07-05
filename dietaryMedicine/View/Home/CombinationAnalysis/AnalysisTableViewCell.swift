//
//  AnalysisTableViewCell.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/20.
//

import UIKit
import Kingfisher

class AnalysisTableViewCell: UITableViewCell {
    public static let identifier = "AnalysisTableViewCell"

//    @IBOutlet var imgView: UIImageView!
    
    private var nutrientView = UIView()
    private var nutrientImgView = UIImageView()
    private var nutrientLabel = UILabel()
    private var progressBar = UIProgressView()
    private var triangleRecommend = TriangleView()
    private var triangleRecommendLabel = UILabel()
    private var triangleMax = TriangleView()
    private var triangleMaxLabel = UILabel()
    private var triangleCurrent = TriangleView()
    private var triangleCurrentLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        self.selectionStyle = .none
        self.contentView.addSubview(nutrientView)
        
        nutrientView.addSubview(nutrientImgView)
        nutrientView.addSubview(nutrientLabel)
        nutrientView.addSubview(progressBar)
        nutrientView.addSubview(triangleRecommend)
        nutrientView.addSubview(triangleRecommendLabel)
        nutrientView.addSubview(triangleMax)
        nutrientView.addSubview(triangleMaxLabel)
        nutrientView.addSubview(triangleCurrent)
        nutrientView.addSubview(triangleCurrentLabel)
        
        nutrientView.backgroundColor = .white
        nutrientView.layer.cornerRadius = 16
        nutrientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let imgURL = URL(string: "https://nutrition-helper-bucket.s3.ap-northeast-2.amazonaws.com/image/nutrient-circle/1/LC.png") ?? URL(string: "")
        let processor = RoundCornerImageProcessor(cornerRadius: 8)
        nutrientImgView.kingFisherSetImage(url: imgURL!, processor: processor)

        nutrientImgView.layer.cornerRadius = nutrientImgView.frame.height / 2
        nutrientImgView.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        nutrientLabel.text = "네임" //nutrientData.nutrientName + " " + nutrientStandardText
        nutrientLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nutrientLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.equalToSuperview()
            $0.leading.equalTo(nutrientImgView.snp.trailing).offset(10)
        }
        
        progressBar.tintColor = .analysisColor
        progressBar.setProgress(0.95, animated: false)
        progressBar.snp.makeConstraints {
            $0.width.equalTo(270)
            $0.height.equalTo(3)
            $0.top.equalTo(nutrientLabel.snp.bottom).offset(10)
            $0.leading.equalTo(nutrientImgView.snp.trailing).offset(10)
        }
        
        let currentValue = progressBar.progress
        let recommendValue = 0.1
        let maxValue = 0.6
        
        
        triangleRecommend.backgroundColor = .white
        triangleRecommend.snp.makeConstraints {
            $0.width.equalTo(6)
            $0.height.equalTo(5)
            $0.top.equalTo(progressBar.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(270 * recommendValue + 35)
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
            $0.leading.equalToSuperview().inset(270 * maxValue + 35)
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
            $0.leading.equalToSuperview().inset(270 * currentValue + 35)
        }
        
        triangleCurrentLabel.text = "현재"
        triangleCurrentLabel.textColor = .textGray
        triangleCurrentLabel.font = UIFont.systemFont(ofSize: 8)
        triangleCurrentLabel.snp.makeConstraints {
            $0.width.equalTo(40)
            $0.top.equalTo(triangleCurrent.snp.bottom).offset(5)
            $0.centerX.equalTo(triangleCurrent.snp.centerX).offset(13)
        }
    }
}
