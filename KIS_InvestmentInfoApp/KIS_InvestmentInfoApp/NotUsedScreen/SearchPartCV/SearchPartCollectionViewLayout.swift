//
//  SearchPartCollectionViewLayout.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/24.
//

import UIKit

class SearchPartCollectionViewLayout: UICollectionViewFlowLayout {

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
        self.scrollDirection = .vertical
        self.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        self.itemSize = CGSize(width: (UIScreen.main.bounds.width - 40 ) / 3, height: 90)
        
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            if collectionView.tag == 0 {
//                return CGSize(width: (UIScreen.main.bounds.width - 40 ) / 3, height: 90)
//            }
//            return CGSize(width: (UIScreen.main.bounds.width - 40 ) / 3, height: 90)
//        }
//        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            if collectionView.tag == 0 {
//                print(arrsToShow[indexPath.row])
//            }
//        }
    }
}
