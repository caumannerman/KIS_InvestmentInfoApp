//
//  SearchPartCollectionViewCell.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/24.
//

import UIKit
import SnapKit

final class SearchPartCollectionViewCell: UICollectionViewCell{
    
    private lazy var titleLabel = UILabel()
    private lazy var subtitleLabel = UILabel()
    
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
        layer.borderColor = UIColor(red: 170/255, green: 170/255, blue: 200/255, alpha: 1.0).cgColor
        layer.cornerRadius = 10.0
        self.backgroundColor = .white
       
        titleLabel.backgroundColor = .white
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 32.0, weight: .bold)
        titleLabel.layer.cornerRadius = 10.0

        subtitleLabel.backgroundColor = .white
        subtitleLabel.textColor = .darkGray
        subtitleLabel.font = .systemFont(ofSize: 20.0, weight: .regular)
    }
   
    
    private func layout() {
        [ titleLabel, subtitleLabel ].forEach{ addSubview($0)}
        
        titleLabel.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setup(title: String, subtitle: String){
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
    }
  
}

