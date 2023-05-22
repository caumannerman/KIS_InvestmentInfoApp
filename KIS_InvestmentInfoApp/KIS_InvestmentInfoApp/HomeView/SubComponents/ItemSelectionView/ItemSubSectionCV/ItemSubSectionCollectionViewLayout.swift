//
//  ItemSubSectionCollectionViewLayout.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/22.
//
import UIKit

class ItemSubSectionCollectionViewLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute(){
        self.minimumLineSpacing = 6
        self.minimumInteritemSpacing = 6
        self.scrollDirection = .horizontal
        self.sectionInset = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
    }
}



