//
//  ItemSubSectionCollectionView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/22.
//

import UIKit
import SnapKit

enum SubSection_OnWhichView {
    case Home
    case Chart
}

class ItemSubSectionCollectionView: UICollectionView {
    
    private var onWhichView: SubSection_OnWhichView = .Home
    private var subSections: [String] = ["주식시세"]
    private var subSectionsIsSelected: [Bool] = [false]
    private var now_subSection_idx: Int = 0
    
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
        subSectionsIsSelected[0] = true
        now_subSection_idx = 0
    }
    
    func setupOnWhichView(onWhich: SubSection_OnWhichView){
        self.onWhichView = onWhich
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

        let cellWidth = subSections[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .regular)]).width + 50
        return CGSize(width: cellWidth, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(subSections[indexPath.row])
        print("Clicked section cell")
        
        //배열 변경
        subSectionsIsSelected[now_subSection_idx] = false
        now_subSection_idx = indexPath.row
        subSectionsIsSelected[now_subSection_idx] = true
        
        switch onWhichView {
        case .Home:
            NotificationCenter.default.post(name:.DidTapItemSubSectionCell, object: .none, userInfo: ["idx": indexPath.row])
        case .Chart:
            NotificationCenter.default.post(name:.DidTapItemSubSectionCell_Chart, object: .none, userInfo: ["idx": indexPath.row])
        }
        
        //cell setup을 위해 reload
        self.reloadData()
    }
}
