//
//  ItemSubSectionCollectionView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/22.
//

import UIKit
import SnapKit

class ItemSubSectionCollectionView: UICollectionView {
    
    private var subSections: [String] = ["주식시세", "신주인수권증서시세", "수익증권시세", "신주인수권증권시세"]
    private var subSectionsIsSelected: [Bool] = Array(repeating: false, count: 4)
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        bind()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind(){
    
    }
    
    private func attribute(){
        self.register( ItemSubSectionCollectionViewCell.self, forCellWithReuseIdentifier: "ItemSubSectionCollectionViewCell")
        self.showsHorizontalScrollIndicator = true
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
//        self.isPagingEnabled = true
        self.dataSource = self
        self.delegate = self
    }
    
    func setup(idx: Int) {
        self.subSections = MarketInfoData.getMarketSubSections(idx: idx)
        self.subSectionsIsSelected = Array(repeating: false, count: MarketInfoData.getMarketSubSectionsCount(idx: idx))
    }
}


extension ItemSubSectionCollectionView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subSections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemSubSectionCollectionViewCell", for: indexPath) as? ItemSubSectionCollectionViewCell else { return UICollectionViewCell() }
        cell.setup(title: subSections[indexPath.row], isSelected: subSectionsIsSelected[indexPath.row])
        return cell
    }
}

extension ItemSubSectionCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        
        let cellWidth = subSections[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .regular)]).width + 30
        return CGSize(width: cellWidth, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(subSections[indexPath.row])
        print("Clicked section cell")
        
        //배열 변경
        subSectionsIsSelected = Array(repeating: false, count: subSections.count)
        subSectionsIsSelected[indexPath.row] = true
        //cell setup을 위해 reload
        self.reloadData()
        
//        NotificationCenter.default.post(name:.DidTapItemSectionCell, object: .none, userInfo: ["idx": indexPath.row])
    }
}
