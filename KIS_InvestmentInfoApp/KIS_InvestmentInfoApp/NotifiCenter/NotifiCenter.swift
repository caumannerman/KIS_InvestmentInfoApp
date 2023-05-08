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
    
    //UrlSearchTableViewCell -> UrlSearchTableView
    // 즐겨찾기 버튼을 눌렀을 때, UrlSearchTableView에 갖고있는 즐찾 관련 배열을 수정하고, 그것을 다시 UserDefaults에 저장해줘야하므로 신호 보냄
    static let DidChangeUrlStar = Notification.Name("DidChangeUrlStar")
}

