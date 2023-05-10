//
//  NotifiCenter.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/08.
//

import Foundation

extension Notification.Name {
    
    // UrlSearchTableView -> HomeViewController
    // UrlCell을 클릭하면 Url 검색 결과 표를 그릴 창을 Present해야하는데, 이는 VC에서 할 수 있으므로 신호를 보냄
    static let DidTapUrlTVCell = Notification.Name("DidTapUrlTVCell")
    
    // ChartViewCollectionViewCell
    static let DidTapUnClickedCell = Notification.Name("DidTapUnClickedCell")
    
    //ShowDataViewCollectionViewCell
    static let cellColorChange = Notification.Name("cellColorChange")
    
    //UrlSearchTableViewCell -> UrlSearchTableView
    // 즐겨찾기 버튼을 눌렀을 때, UrlSearchTableView에 갖고있는 즐찾 관련 배열을 수정하고, 그것을 다시 UserDefaults에 저장해줘야하므로 신호 보냄
    static let DidChangeUrlStar = Notification.Name("DidChangeUrlStar")
    
    // ApiListTableViewCell -> UrlSearchView
    // Settings 화면에서 즐겨찾기를 수정하였을 때, Home에도 반영해야하는데, HOme의 TableVIew가 VC-> UIView -> TV구조로
    // depth가 3단계이므로, VC에서 reload()하여 해결할 수 없다. 따라서 UrlSearchView로 신호 보내서 tv를 relaodData한다.
    static let DidChangeUrlStarInSettings = Notification.Name("DidChangeUrlStarInSettings")
}

