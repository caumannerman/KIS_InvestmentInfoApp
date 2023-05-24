//
//  ChartViewCollectionView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/04.
//

import UIKit
import SnapKit


class ChartSectionCollectionView: UICollectionView {
    
     
    private var chartSections: [String] = MarketInfoData.getMarketSections()
    // 단 "하나"의 cell 만 true인 상태를 유지하도록 logic 구성
    private var chartSections_isClicked: [Bool] = Array(repeating: false, count: MarketInfoData.getMarketSectionsCount())
    private var now_section_idx: Int = 0
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        chartSections_isClicked[0] = true
        bind()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func bind(){
    
    }
    
    private func attribute(){
        
        self.register( ChartSectionCollectionViewCell.self, forCellWithReuseIdentifier: "ChartViewCollectionViewCell")
        self.showsHorizontalScrollIndicator = true
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.backgroundColor = .magenta
        self.isPagingEnabled = true
        self.dataSource = self
        self.delegate = self
    }

}

extension ChartSectionCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chartSections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChartViewCollectionViewCell", for: indexPath) as? ChartSectionCollectionViewCell else { return UICollectionViewCell() }
        // indexPath.rowrk 0부터 시작함
        cell.setup(title: chartSections[indexPath.row], isClicked: chartSections_isClicked[indexPath.row])
        return cell
    }
}

extension ChartSectionCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellWidth = chartSections[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 32.0, weight: .bold)]).width + 60
        return CGSize(width: cellWidth, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("clicked!", terminator: " ")
        print(chartSections[indexPath.row])
        chartSections_isClicked[now_section_idx] = false
        // 새로 받아온 cell true로 변경
        now_section_idx = indexPath.row
        chartSections_isClicked[indexPath.row] = true
        print(chartSections_isClicked)
        self.reloadData()
        // SubSection을 갖고있는 ChartViewController에게 보내서,
        // SubSection목록을 Section에 맞게 바꾸기 위해
        NotificationCenter.default.post(name:.DidTapUnClickedCell, object: .none, userInfo: ["idx": now_section_idx])
    }
}

