//
//  ItemSubSectionCollectionViewCell.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/22.
//

import UIKit

class ItemSubSectionCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func attribute(){
        layer.cornerRadius = 10.0
        layer.borderWidth = 2.0
       
        self.backgroundColor = .systemBackground
        
        titleLabel.font = .systemFont(ofSize: 18.0, weight: .regular)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
    }
    
    private func layout(){
        [ titleLabel ].forEach{ addSubview($0)}
        
        titleLabel.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(10)
        }
    }
    
    func setup(title: String, isSelected: Bool){
        self.titleLabel.text = title
        if isSelected{
            layer.borderColor = UIColor(red: 190/255, green: 200/255, blue: 230/255, alpha: 1.0).cgColor
        }
        else {
            layer.borderColor = UIColor(red: 230/255, green: 240/255, blue: 250/255, alpha: 1.0).cgColor
        }
    }
}
