//
//  ChartViewCollectionViewCell.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/04.
//

import UIKit
import SnapKit

final class ChartSectionCollectionViewCell: UICollectionViewCell{
    
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
        layer.borderColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0).cgColor
        layer.cornerRadius = 10.0
        self.backgroundColor = .white
       
        titleLabel.backgroundColor = .white
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 32.0, weight: .bold)
        titleLabel.layer.cornerRadius = 10.0
        titleLabel.textAlignment = .center
    }
    
    private func layout() {
        [ titleLabel ].forEach{ addSubview($0)}
        
        titleLabel.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func setup(title: String, isClicked: Bool){
        titleLabel.text = title

        if isClicked {
            layer.borderWidth = 5
            layer.borderColor = UIColor(red: 200/255, green: 210/255, blue: 250/255, alpha: 1.0).cgColor
        }
        else {
            layer.borderWidth = 2
            layer.borderColor = UIColor(red: 220/255, green: 230/255, blue: 255/255, alpha: 1.0).cgColor
        }
        
    }
  
}

