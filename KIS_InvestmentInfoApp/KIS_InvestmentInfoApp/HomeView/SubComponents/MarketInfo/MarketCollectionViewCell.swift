//
//  MarketCollectionViewCell.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/12.
//

import UIKit

class MarketCollectionViewCell: UICollectionViewCell {
    
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
        layer.borderWidth = 2
        layer.borderColor = UIColor(red: 210/255, green: 157/255, blue: 200/255, alpha: 1.0).cgColor
        layer.cornerRadius = 10.0
        layer.borderWidth = 3.0
        layer.borderColor = UIColor(red: 255/255, green: 200/255, blue: 190/255, alpha: 1.0).cgColor
        self.backgroundColor = .systemBackground
        
        titleLabel.font = .systemFont(ofSize: 32.0, weight: .bold)
        titleLabel.textColor = .blue
        titleLabel.textAlignment = .center
    }
    
    private func layout(){
        [ titleLabel ].forEach{ addSubview($0)}
        
        titleLabel.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func setup(title: String){
        self.titleLabel.text = title
    }
    
}
