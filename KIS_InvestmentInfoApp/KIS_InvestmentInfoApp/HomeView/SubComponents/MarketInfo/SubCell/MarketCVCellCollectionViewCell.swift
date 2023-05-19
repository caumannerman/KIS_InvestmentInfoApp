//
//  MarketCVCellCollectionViewCell.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/17.
//

import UIKit
import SnapKit

class MarketCVCellCollectionViewCell: UICollectionViewCell {
    
    private let imageButton = UIButton()
//    private let titleLabel = UILabel()
    private final let UNIT_WIDTH: Int = Int(( UIScreen.main.bounds.width - 50 ) / 4)
    
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
    
        layer.cornerRadius = 10.0
        layer.borderWidth = 3.0
        layer.borderColor = UIColor(red: 255/255, green: 200/255, blue: 190/255, alpha: 1.0).cgColor
        self.backgroundColor = .black
        
        
        imageButton.setImage(UIImage(named: "nasdaq"), for: .normal)
//        titleLabel.font = .systemFont(ofSize: 32.0, weight: .bold)
//        titleLabel.textColor = .blue
//        titleLabel.textAlignment = .center
    }
    
    private func layout(){
        [ imageButton ].forEach{ addSubview($0)}
        
        imageButton.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
//            $0.width.equalTo( (UNIT_WIDTH - 18) / 2 )
//            $0.height.equalTo( (UNIT_WIDTH - 18) / 2 )
        }
        
//        titleLabel.snp.makeConstraints{
//            $0.edges.equalToSuperview()
//        }
    }
//
//    func setup(title: String){
//        self.titleLabel.text = title
//    }
//
}
