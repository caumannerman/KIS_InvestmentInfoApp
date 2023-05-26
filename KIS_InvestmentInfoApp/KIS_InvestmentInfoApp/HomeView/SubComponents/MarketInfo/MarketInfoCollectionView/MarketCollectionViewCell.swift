//
//  MarketCollectionViewCell.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/12.
//

import UIKit

class MarketCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
//    private let marketCVCellCollectionView = MarketCVCellCollectionView(frame: .zero, collectionViewLayout: MarketCVCellCollectionViewLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func attribute(){
        layer.borderWidth = 3
        layer.borderColor = UIColor(red: 160/255, green: 170/255, blue: 240/255, alpha: 1.0).cgColor
        layer.cornerRadius = 10.0
        layer.borderWidth = 3.0
       
        self.backgroundColor = .systemBackground
        
        titleLabel.font = .systemFont(ofSize: 32.0, weight: .bold)
        titleLabel.textColor = .darkGray
        titleLabel.textAlignment = .center
    }
    
    private func layout(){
        [ titleLabel, subTitleLabel ].forEach{ addSubview($0)}
        
        titleLabel.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(30)
        }
        subTitleLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
//        marketCVCellCollectionView.snp.makeConstraints{
//            $0.edges.equalToSuperview().inset(12)
//        }
    }
    
    func setup(title: String, subtitle: String){
        self.titleLabel.text = title
        self.subTitleLabel.text = subtitle
    }
    
}
