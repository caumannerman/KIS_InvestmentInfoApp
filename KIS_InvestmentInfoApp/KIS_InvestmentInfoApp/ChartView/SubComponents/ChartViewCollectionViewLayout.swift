//
//  ChartViewCollectionViewLayout.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/04.
//


import UIKit

class ChartViewCollectionViewLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute(){
        self.minimumLineSpacing = 10
        self.minimumInteritemSpacing = 10
        self.scrollDirection = .horizontal
        self.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
}
