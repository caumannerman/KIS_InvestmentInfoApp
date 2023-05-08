//
//  NotifiCenter.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/08.
//

import Foundation

extension Notification.Name {
    
    static let DidTapCell = Notification.Name("DidTapCell")

    // ChartViewCollectionView ->
    // 선택된 cell이 바뀌었을 때, 기존에 선택되어있던 cell에 신호를 보내주어
    static let NotifySelectedCellIdx = Notification.Name("NotifySelectedCellIdx")
    
    // ChartViewCollectionViewCell
    static let DidTapUnClickedCell = Notification.Name("DidTapUnClickedCell")
    
    //ShowDataViewCollectionViewCell
    static let cellColorChange = Notification.Name("cellColorChange")
}

