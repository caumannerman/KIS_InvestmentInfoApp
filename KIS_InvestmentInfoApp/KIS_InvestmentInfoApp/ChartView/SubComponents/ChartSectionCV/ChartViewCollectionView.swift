//
//  ChartViewCollectionView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/04.
//

import UIKit
import SnapKit


class ChartViewCollectionView: UICollectionView {
    
     
    private var days: [String] = MarketInfoData.getMarketSections()
    // 단 "하나"의 cell 만 true인 상태를 유지하도록 logic 구성
    private var days_isClicked: [Bool] = Array(repeating: false, count: MarketInfoData.getMarketSectionsCount())
    private var now_section_idx: Int = 0
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        days_isClicked[0] = true
        bind()
        attribute()
        NotificationCenter.default.addObserver(self, selector: #selector(chartSectionDidChanged(_:)), name: .DidTapUnClickedCell, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func bind(){
    
    }
    
    private func attribute(){
        
        self.register( ChartViewCollectionViewCell.self, forCellWithReuseIdentifier: "ChartViewCollectionViewCell")
        self.showsHorizontalScrollIndicator = true
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.backgroundColor = .magenta
        self.isPagingEnabled = true
        self.dataSource = self
        self.delegate = self
    }
    @objc func chartSectionDidChanged(_ notification: Notification){
        guard let clickedIdx = notification.userInfo as? Dictionary<String, Int> else { return }
        guard let clickedRow = clickedIdx["row"] as? Int else { return }
        // 유일하게 true였던 cell false로 바꾸고
        days_isClicked[now_section_idx] = false
        // 새로 받아온 cell true로 변경
        now_section_idx = clickedRow
        days_isClicked[clickedRow] = true
        print(days_isClicked)
        self.reloadData()
        
    }
    
    
}

extension ChartViewCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChartViewCollectionViewCell", for: indexPath) as? ChartViewCollectionViewCell else { return UICollectionViewCell() }
        // indexPath.rowrk 0부터 시작함
        cell.setup(title: days[indexPath.row], isClicked: days_isClicked[indexPath.row], rowNum: indexPath.row)
        return cell
    }
}

extension ChartViewCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellWidth = days[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 32.0, weight: .bold)]).width + 60
        
        return CGSize(width: cellWidth, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("clicked!", terminator: " ")
        print(days[indexPath.row])
    }
}

