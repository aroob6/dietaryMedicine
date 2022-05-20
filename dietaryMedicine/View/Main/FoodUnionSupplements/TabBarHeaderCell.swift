//
//  FoodSupplementsListHeaderCell.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/20.
//

import UIKit

class TabBarHeaderCell: UICollectionViewCell {
    
    public let indicatior = UIView()
    public let label = UILabel()
    
    public var text: String! {
        didSet {
            label.text = text
        }
    }
    
    override var isSelected: Bool {
        willSet {
            newValue ? selectTabItem() : deselectTabItem()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFrame(){
        self.addSubview(indicatior)
        self.addSubview(label)
        
        indicatior.backgroundColor = .mainColor
        indicatior.snp.makeConstraints { make in
            make.height.equalTo(5)
            make.top.trailing.leading.equalToSuperview()
        }
        
        label.textAlignment = .center
        label.snp.makeConstraints { make in
            make.top.equalTo(indicatior.snp.bottom)
            make.trailing.leading.bottom.equalToSuperview()
        }
    }

    func selectTabItem(){
        label.textColor = .black
        indicatior.isHidden = false
    }
    
    func deselectTabItem(){
        label.textColor = .lightGray
        indicatior.isHidden = true
    }
    
}
