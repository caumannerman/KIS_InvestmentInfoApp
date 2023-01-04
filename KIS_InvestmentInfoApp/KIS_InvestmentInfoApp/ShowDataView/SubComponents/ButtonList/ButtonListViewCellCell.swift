//
//  ButtonListViewCellCell.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/04.
//

import UIKit
import SnapKit

final class ButtonListViewCellCell: UICollectionViewCell{
    
    private lazy var titleLabel: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .bold)
        button.backgroundColor = .cyan
        button.layer.cornerRadius = 12.0
        
        return button
    }()
    
    override func layoutSubviews() {
        [ titleLabel].forEach{ addSubview($0)}
        
        titleLabel.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func setup(title: String){
        titleLabel.setTitle(title, for: .normal)
    }
    
}
