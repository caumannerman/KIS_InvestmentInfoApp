//
//  MarketCollectionViewLayout.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/12.
//

import UIKit

class MarketCollectionViewLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute(){
        self.minimumLineSpacing = 40
        self.minimumInteritemSpacing = 10
        self.scrollDirection = .vertical
        self.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}



