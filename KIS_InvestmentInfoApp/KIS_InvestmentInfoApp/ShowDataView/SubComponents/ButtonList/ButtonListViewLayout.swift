//
//  ButtonListViewLayout.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/02.
//

import UIKit

final class ButtonListViewLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        self.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        self.minimumLineSpacing = 8
        minimumInteritemSpacing = 10
        
//        let screenWIdth = UIScreen.main.bounds.width
        self.itemSize = CGSize(width: 60, height: 30)
        self.scrollDirection = .horizontal
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
