//
//  DetailFoodViewController.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/17.
//

import UIKit
import SnapKit

class DetailFoodViewController: UIViewController {
    private var stackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .clear
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()
    
    private var imageView = UIImageView()
    private var name = UILabel()
    private var content = UILabel()
    private var link = UILabel()
    private var addButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        setFrame()
    }
    
    func setFrame() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        view.addSubview(addButton)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(content)
        stackView.addArrangedSubview(link)
        
        name.text = "예시"
        name.textColor = .black
        
        content.text = "내용"
        content.textColor = .black
        
        link.text = "링크"
        link.textColor = .black
        
        addButton.backgroundColor = .mainGray
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        
        imageView.backgroundColor = .green
        
        stackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(addButton.snp.top)
        }
        imageView.snp.makeConstraints { make in
            make.height.equalTo(340)
        }
        name.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        content.snp.makeConstraints { make in
            make.height.equalTo(290)
        }
        link.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        addButton.snp.makeConstraints { make in
            make.height.equalTo(58)
            make.top.equalTo(stackView.snp.bottom)
            make.bottom.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
        
    }

}
