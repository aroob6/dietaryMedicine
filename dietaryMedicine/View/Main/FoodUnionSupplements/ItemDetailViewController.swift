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
import Resolver

class ItemDetailViewController: UIViewController {
    private var stackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .clear
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()
    
    private var buttonStackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .clear
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()
    
    private var imgView = UIImageView()
    private var name = UILabel()
    private var content = UILabel()
    private var link = UILabel()
    private var bookMarkButton = UIButton()
    private var addButton = UIButton()
    private var supplementID = 0
    
    @Injected private var itemDetailViewModel: ItemDetailViewModel
    
    //RxSwift
    @Injected private var disposeBag : DisposeBag

    override func viewDidLoad() {
        super.viewDidLoad()

        setFrame()
        setUpButton()
    }
    
    private func setFrame() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        view.addSubview(buttonStackView)
        
        stackView.addArrangedSubview(imgView)
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(content)
        stackView.addArrangedSubview(link)
//        stackView.addArrangedSubview(buttonStackView)
        
        buttonStackView.addArrangedSubview(bookMarkButton)
        buttonStackView.addArrangedSubview(addButton)
        
        imgView.backgroundColor = .green
        
        name.textColor = .black
        name.backgroundColor = .lightGray
        
        content.textColor = .black
        content.backgroundColor = .blue
        
        link.textColor = .black
        link.backgroundColor = .yellow
        
        bookMarkButton.setImage(UIImage(named: "bookMark"), for: .normal)
        
        addButton.backgroundColor = .mainColor
        addButton.setTitle("추가하기", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.layer.cornerRadius = 8
        
        stackView.snp.makeConstraints { make in
//            make.edges.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)

        }
        imgView.snp.makeConstraints { make in
            make.height.equalTo(360)
        }
        name.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        content.snp.makeConstraints { make in
            make.height.equalTo(250)
        }
        link.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalTo(stackView.snp.bottom).inset(-20)
            make.bottom.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            
        }
        
        bookMarkButton.snp.makeConstraints { make in
            make.width.height.equalTo(55)
        }
        
        addButton.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        
    }
    
    private func setUpButton() {
        addButton.rx.tap.bind { [weak self] in
            self?.addButtonAction()
        }.disposed(by: disposeBag)
    }
    
    @objc func addButtonAction() {
        let parameter : [String: Int] = [
            "supplement_id": supplementID
        ]
        
        itemDetailViewModel.fetch(parameters: parameter)
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    func configureCell(supplementList: SupplementList, indexPath: IndexPath) {
        let supplementData = supplementList.data[indexPath.row]
        supplementID = supplementData.supplementID
        name.text = supplementData.name
        content.text = supplementData.content
        link.text = supplementData.link
        
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

}
