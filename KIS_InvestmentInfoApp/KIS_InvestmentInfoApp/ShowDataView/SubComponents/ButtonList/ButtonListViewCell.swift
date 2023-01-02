//
//  ButtonListViewCell.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/02.
//

import UIKit
import SnapKit

final class ButtonListViewCell: UICollectionViewCell{
    private lazy var titleLabel: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .bold)
        button.backgroundColor = .cyan
        button.layer.cornerRadius = 12.0
        
        return button
    }()
    
    func setup(title: String){
        setupLayout()
        titleLabel.setTitle(title, for: .normal)
    }
}

private extension ButtonListViewCell{
    func setupLayout(){
        [ titleLabel].forEach{ addSubview($0)}
        
        titleLabel.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
