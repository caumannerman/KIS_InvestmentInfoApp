//
//  ItemSectionCollectionView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/22.
//

import UIKit
import SnapKit

class ItemSectionCollectionView: UICollectionView {
    
    private var sections: [String] = MarketInfoData.getMarketSections()
    private lazy var sectionsIsSelected: [Bool] = Array(repeating: false, count: MarketInfoData.getMarketSectionsCount())
    
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
        
        self.register( ItemSectionCollectionViewCell.self, forCellWithReuseIdentifier: "ItemSectionCollectionViewCell")
        self.showsHorizontalScrollIndicator = true
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.backgroundColor = UIColor(red: 230/255, green: 236/255, blue: 250/255, alpha: 1.0)
//        self.isPagingEnabled = true
        self.dataSource = self
        self.delegate = self        
    }
}


extension ItemSectionCollectionView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemSectionCollectionViewCell", for: indexPath) as? ItemSectionCollectionViewCell else { return UICollectionViewCell() }
        cell.setup(title: sections[indexPath.row], isSelected: sectionsIsSelected[indexPath.row])
        return cell
    }
    
}

extension ItemSectionCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellWidth = sections[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 34, weight: .regular)]).width + 30
        return CGSize(width: cellWidth, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(sections[indexPath.row])
        print("Clicked section cell")
        
        //배열 변경
        sectionsIsSelected = Array(repeating: false, count: sections.count)
        sectionsIsSelected[indexPath.row] = true
        //cell setup을 위해 reload
        self.reloadData()
        
        NotificationCenter.default.post(name:.DidTapItemSectionCell, object: .none, userInfo: ["idx": indexPath.row])
    }
}
