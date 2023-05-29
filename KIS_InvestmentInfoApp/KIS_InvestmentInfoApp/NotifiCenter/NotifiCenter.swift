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
    
    // MarketCollectionView -> HomeViewController
    // 금 가격 / 은 가격 등, 시장정보 Tab에서 어떤 Cell을 눌렀을 때 해당 정보에 대해 Chart, 원형 차트 등을 보여주는 화면을 present하기 위해
    // 컬렉션뷰에서 ViewController로 신호를 보내줘야한다.
    static let DidTapMarketInfoCell = Notification.Name("DidTapMarketInfoCell")
    
    
    // ItemSectionCollectionView에서 Cell을 클릭했을 때 신호를
    // ItemSelectionViewController로 신호 전달 ( 아래의 TableView화면도 변경해줘야하기 때문)
    static let DidTapItemSectionCell = Notification.Name("DidTapItemSectionCell")
    
    // ItemSectionCollectionView에서 Cell을 클릭했을 때 신호를
    // ItemSelectionViewController로 신호 전달 ( 아래의 TableView화면도 변경해줘야하기 때문)
    static let DidTapItemSubSectionCell = Notification.Name("DidTapItemSubSectionCell")
    static let DidTapItemSubSectionCell_Chart = Notification.Name("DidTapItemSubSectionCell_Chart")
    // ItemSelectionViewController에서 검색 후 cell을 클릭하였을 때
    // 해당 이름을 MarketCollectionView로 넘겨주기 위함
    // MarketCollectionView에서는 해당 cell을 추가한다.
    static let AddNewItemOnMarketCV = Notification.Name("AddNewItemOnMarketCV")
    
    
    //SearchPartView에서, 검색어를 검색하고, 그에 알맞은 항목들만, 하단의 collectionView( SearchPartCollectionView)에 보내줘야하기 때문에,
    static let SendSearchResult = Notification.Name("SendSearchResult")
    // SendSearchResult와 반대로, 검색결과 CollectionView에서 cell을 클릭했을 때,
    // 그 index를 SearchPartView로 보내기 위한 신호
    static let SendSelectedSearchResultCell = Notification.Name("SendSelectedSearchResultCell")
    
    //URL검색에서 검색창에 써놓은 텍스트를 tableView에 띄우기 위함
    static let sendUrlSearchText = Notification.Name("sendUrlSearchText")
    
    static let market_url_changed = Notification.Name("market_url_changed")
    
    //ShowDataViewCollectionViewCell에서 버튼을 클릭했을 때, 짤린 텍스트를 모두 보여줄 수 있는 창을 띄워주기위함
    // button.text를 userInfo로 보내준다.
    static let ChartCellClicked = Notification.Name("ChartCellClicked")
    
}

