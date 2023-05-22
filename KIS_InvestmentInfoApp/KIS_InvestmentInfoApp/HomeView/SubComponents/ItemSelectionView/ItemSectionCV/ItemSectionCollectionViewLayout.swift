//
//  ItemSectionCollectionViewLayout.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/22.
//
import UIKit

class ItemSectionCollectionViewLayout: UICollectionViewFlowLayout {

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
        self.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}



