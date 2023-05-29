//
//  ChartViewController.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/02.
//

import UIKit
import Charts
import SnapKit
import Alamofire
import SwiftUI

//날짜정보 / 종목코드 / 종목명 / 상장시장명 / 시가 / 종가 / 최고가 / 최저가
class ChartViewController: UIViewController {
    
    let navi_titles: [String] = ["주식 시세정보", "지수 시세정보", "일반상품 시세정보", "증권상품 시세정보", "채권 시세정보", "파생상품 시세정보"]
    // ---------------------======================== Variables ========================--------------------- //
    
    //저장할 파일의 이름을 담을 변수
    private var saveFileName: String = ""
    //저장 파일 이름 받아올 UIAlert
    private let alert = UIAlertController(title: "파일 제목", message: "저장할 파일의 이름을 입력해주세요", preferredStyle: .alert)
    private var ok = UIAlertAction()
    private var cancel = UIAlertAction()
    
    private var apiResultStr = ""
    // 이것이 json String을 이용해 최종적으로 얻은 배열이라고 생각하고 개발중
    private var jsonResultArr: [[String]] = DummyClass.getJsonResultArr()
    
    private var isClickedArr_row: [Bool] = [true, false, false, true, false, false, false, true, true, false, true, false, false, false, true, false, true, false, false, true]
    private var isClickedArr_col: [Bool] = [false, false,true, true, false, false, false, true, false, false, true, true, ]
    

    var api_result: String = ""
    
    // 원하는 기간의 주가정보를 받아와 저장할 배열
    private var securityDataArr: [SecurityDataCellData] = []
    
    // Identifiable 프로토콜을 따르는 [SecurityInfo] 배열, SwiftUI view로 넘겨줘야함
    private var securityInfoArr: [SecurityInfo] = []
    // SiteView를 따르는 것 시가/종가/ 최저가 /최고가
    private var mkpInfoArr: [SiteView] = []
    private var clprInfoArr: [SiteView] = []
    private var hiprInfoArr: [SiteView] = []
    private var loprInfoArr: [SiteView] = []
    
    private var now_section_idx: Int = 0
    private var now_subSection_idx: Int = 0
    // ---------------------========================----------------========================--------------------- //
    
    
    
    
    
    
    
    
    
    
    // ---------------------======================== UI Components ========================--------------------- //
    
    // section을 선택하는 collectionView
    private let sectionCollectionView = ChartSectionCollectionView(frame: .zero, collectionViewLayout: ChartSectionCollectionViewLayout())
    private let subSectionCollectionView = ItemSubSectionCollectionView(frame: .zero, collectionViewLayout: ItemSubSectionCollectionViewLayout())
    private let searchPartView = SearchPartView()

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setNavigationItems()
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        subSectionCollectionView.setup(idx: 0)
        subSectionCollectionView.setupOnWhichView(onWhich: .Chart)
        NotificationCenter.default.addObserver(self, selector: #selector(chartSectionDidChanged(_:)), name: .DidTapUnClickedCell, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(chartSubSectionDidChanged(_:)), name: .DidTapItemSubSectionCell_Chart, object: nil)
    }
    
    //section cell 선택이 바뀌었을 때 호출될 함수
    @objc func chartSectionDidChanged(_ notification: Notification){
        guard let clickedIdx = notification.userInfo?["idx"] as? Int else { return }
        now_section_idx = clickedIdx
        now_subSection_idx = 0
        navigationItem.title = navi_titles[now_section_idx]
        // 여기서 subSectionCollectionView도 바꿔줘야한다.
        subSectionCollectionView.setup(idx: clickedIdx)
        subSectionCollectionView.reloadData()
        
        print("section이 바뀜 : ", now_section_idx, now_subSection_idx)
    }
    
    //section cell 선택이 바뀌었을 때 호출될 함수
    @objc func chartSubSectionDidChanged(_ notification: Notification){
        guard let clickedIdx = notification.userInfo?["idx"] as? Int else { return }
        now_subSection_idx = clickedIdx
        print("subSection이 바뀜 : ", now_section_idx, now_subSection_idx)
    }
    
    private func attribute(){
        sectionCollectionView.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
    }
    
    private func layout(){
        [ sectionCollectionView, subSectionCollectionView, searchPartView ].forEach {
            view.addSubview($0)
        }
        
        sectionCollectionView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(90)
        }
        
        subSectionCollectionView.snp.makeConstraints{
            $0.top.equalTo(sectionCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        searchPartView.snp.makeConstraints{
            $0.top.equalTo(subSectionCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func setNavigationItems(){
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = navi_titles[0]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
