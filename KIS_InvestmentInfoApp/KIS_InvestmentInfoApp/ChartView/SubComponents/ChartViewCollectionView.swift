//
//  ChartViewCollectionView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/04.
//

import UIKit
import SnapKit


class ChartViewCollectionView: UICollectionView {
    
     
    private var days: [String] = ["주식", "채권", "기타1", "기타2", "기타3", "기타7"]
    private var days_isClicked: [Bool] = [true, false, false, false, false, false]
    private var now_section_idx: Int = 0
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        bind()
        attribute()
        NotificationCenter.default.addObserver(self, selector: #selector(chartSectionDidChanged(_:)), name: .chartSectionChanged, object: nil)
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
        days_isClicked[now_section_idx] = false
        now_section_idx = clickedRow
        days_isClicked[clickedRow] = true
        print(days_isClicked)
    }
    
    
}

extension ChartViewCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChartViewCollectionViewCell", for: indexPath) as? ChartViewCollectionViewCell else { return UICollectionViewCell() }
        // indexPath.rowrk 0부터 시작함
        cell.setup(title: days[indexPath.row], rowNum: indexPath.row)
        return cell
    }
}

extension ChartViewCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

//        return CGSize(width: (UIScreen.main.bounds.size.width - 8) / 7, height: (safeAreaLayoutGuide.layoutFrame.size.height ) / 5)
        return CGSize(width: 180, height: 180)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("clicked!", terminator: " ")
        print(days[indexPath.row])
        
    }
}
