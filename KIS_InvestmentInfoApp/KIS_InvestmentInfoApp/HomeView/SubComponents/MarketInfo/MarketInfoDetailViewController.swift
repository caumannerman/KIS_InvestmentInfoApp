//
//  MarketInfoDetailViewController.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/15.
//

import UIKit
import SnapKit
import SwiftUI
import Alamofire

class MarketInfoDetailViewController: UIViewController {
    
    private var url: String = ""
    private var apiResult: [ValueForLineChartCellData] = []
    
    private let alphaView: UIButton = UIButton()
    
    private let restView: UIView = UIView()
    
    
    private var marketInfoHostingController1: UIHostingController = {
        let hostingController = UIHostingController( rootView: TradingChartView(dailyData: Array(repeating: 0.0, count: 90), startDate: Date(), endDate: Date(), name: "로딩중..." ) )
        if #available(iOS 16.0, *) {
            hostingController.sizingOptions = .preferredContentSize
        }
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController
    }()
    
    private var marketInfoHostingController2: UIHostingController = {
        let hostingController = UIHostingController( rootView: TradingChartView(dailyData: Array(repeating: 0.0, count: 90), startDate: Date(), endDate: Date(), name: "로딩중..." ) )
        if #available(iOS 16.0, *) {
            hostingController.sizingOptions = .preferredContentSize
        }
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController
    }()
    private var marketInfoHostingController3: UIHostingController = {
        let hostingController = UIHostingController( rootView: TradingChartView(dailyData: Array(repeating: 0.0, count: 90), startDate: Date(), endDate: Date(), name: "로딩중..." ) )
        if #available(iOS 16.0, *) {
            hostingController.sizingOptions = .preferredContentSize
        }
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController
    }()
    private var marketInfoHostingController4: UIHostingController = {
        let hostingController = UIHostingController( rootView: TradingChartView(dailyData: Array(repeating: 0.0, count: 90), startDate: Date(), endDate: Date(), name: "로딩중..." ) )
        if #available(iOS 16.0, *) {
            hostingController.sizingOptions = .preferredContentSize
        }
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController
    }()
    private var marketInfoHostingController5: UIHostingController = {
        let hostingController = UIHostingController( rootView: TradingChartView(dailyData: Array(repeating: 0.0, count: 90), startDate: Date(), endDate: Date(), name: "로딩중..." ) )
        if #available(iOS 16.0, *) {
            hostingController.sizingOptions = .preferredContentSize
        }
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController
    }()
    private var marketInfoHostingController6: UIHostingController = {
        let hostingController = UIHostingController( rootView: TradingChartView(dailyData: Array(repeating: 0.0, count: 90), startDate: Date(), endDate: Date(), name: "로딩중..." ) )
        if #available(iOS 16.0, *) {
            hostingController.sizingOptions = .preferredContentSize
        }
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController
    }()
    
    init(title: String, subTitle: String, section: Int, subSection: Int){
        super.init(nibName: nil, bundle: nil)
        attribute()
        layout()
        print(title, subTitle, section, subSection)
        self.url = MarketInfoData.getMarketSubSectionsUrl(row: section, col: subSection) +  ( section == 1 ? "&idxNm=" : ( section == 2 && subSection == 0 ? "&oilCtg=" : "&itmsNm=")) + ( title != "제목없음" ? title : "")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("원래 생성자")
        attribute()
        layout()
  
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.0)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        requestAPI(url: self.url)
        print("api 호출 끝 appear")
        DispatchQueue.main.asyncAfter(deadline: .now() + 4){
            self.marketInfoHostingController1.view.snp.removeConstraints()
            self.marketInfoHostingController1 = UIHostingController( rootView: TradingChartView(dailyData: self.apiResult.map{ a -> Double in
                return Double(a.clpr ?? "0.0") ?? 0.0
            }, startDate: Date(), endDate: Date(), name: "종가" ) )
            
            if #available(iOS 16.0, *) {
                self.marketInfoHostingController1.sizingOptions = .preferredContentSize
            }
            self.addChild(self.marketInfoHostingController1)
            self.marketInfoHostingController1.view.translatesAutoresizingMaskIntoConstraints = false
            
            self.restView.addSubview(self.marketInfoHostingController1.view)
            self.marketInfoHostingController1.view.snp.makeConstraints{
                $0.top.leading.equalToSuperview().inset(10)
                $0.width.equalTo((UIScreen.main.bounds.width - 30 ) / 2)
                $0.height.equalTo(UIScreen.main.bounds.height / 4)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4){
            self.marketInfoHostingController2.view.snp.removeConstraints()
            self.marketInfoHostingController2 = UIHostingController( rootView: TradingChartView(dailyData: self.apiResult.map{ a -> Double in
                return Double(a.hipr ?? "0.0") ?? 0.0
            }, startDate: Date(), endDate: Date(), name: "고가" ) )
            
            if #available(iOS 16.0, *) {
                self.marketInfoHostingController2.sizingOptions = .preferredContentSize
            }
            self.addChild(self.marketInfoHostingController2)
            self.marketInfoHostingController2.view.translatesAutoresizingMaskIntoConstraints = false
            
            self.restView.addSubview(self.marketInfoHostingController2.view)
            self.marketInfoHostingController2.view.snp.makeConstraints{
                $0.top.trailing.equalToSuperview().inset(10)
                $0.width.equalTo((UIScreen.main.bounds.width - 30 ) / 2)
                $0.height.equalTo(UIScreen.main.bounds.height / 4)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4){
            self.marketInfoHostingController3.view.snp.removeConstraints()
            self.marketInfoHostingController3 = UIHostingController( rootView: TradingChartView(dailyData: self.apiResult.map{ a -> Double in
                return Double(a.lopr ?? "0.0") ?? 0.0
            }, startDate: Date(), endDate: Date(), name: "저가" ) )
            
            if #available(iOS 16.0, *) {
                self.marketInfoHostingController3.sizingOptions = .preferredContentSize
            }
            self.addChild(self.marketInfoHostingController3)
            self.marketInfoHostingController3.view.translatesAutoresizingMaskIntoConstraints = false
            
            self.restView.addSubview(self.marketInfoHostingController3.view)
            self.marketInfoHostingController3.view.snp.makeConstraints{
                $0.top.equalTo(self.marketInfoHostingController1.view.snp.bottom).offset(10)
                $0.leading.equalToSuperview().inset(10)
                $0.width.equalTo((UIScreen.main.bounds.width - 30 ) / 2)
                $0.height.equalTo(UIScreen.main.bounds.height / 4)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4){
            self.marketInfoHostingController4.view.snp.removeConstraints()
            self.marketInfoHostingController4 = UIHostingController( rootView: TradingChartView(dailyData: self.apiResult.map{ a -> Double in
                return Double(a.vs ?? "0.0") ?? 0.0
            }, startDate: Date(), endDate: Date(), name: "전일대비등락" ) )
            
            if #available(iOS 16.0, *) {
                self.marketInfoHostingController4.sizingOptions = .preferredContentSize
            }
            self.addChild(self.marketInfoHostingController4)
            self.marketInfoHostingController4.view.translatesAutoresizingMaskIntoConstraints = false
            
            self.restView.addSubview(self.marketInfoHostingController4.view)
            self.marketInfoHostingController4.view.snp.makeConstraints{
                $0.top.equalTo(self.marketInfoHostingController2.view.snp.bottom).offset(10)
                $0.trailing.equalToSuperview().inset(10)
                $0.width.equalTo((UIScreen.main.bounds.width - 30 ) / 2)
                $0.height.equalTo(UIScreen.main.bounds.height / 4)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4){
            self.marketInfoHostingController5.view.snp.removeConstraints()
            self.marketInfoHostingController5 = UIHostingController( rootView: TradingChartView(dailyData: self.apiResult.map{ a -> Double in
                return Double(a.trqu ?? "0.0") ?? 0.0
            }, startDate: Date(), endDate: Date(), name: "체결량 총합" ) )
            
            if #available(iOS 16.0, *) {
                self.marketInfoHostingController5.sizingOptions = .preferredContentSize
            }
            self.addChild(self.marketInfoHostingController5)
            self.marketInfoHostingController5.view.translatesAutoresizingMaskIntoConstraints = false
            
            self.restView.addSubview(self.marketInfoHostingController5.view)
            self.marketInfoHostingController5.view.snp.makeConstraints{
                $0.top.equalTo(self.marketInfoHostingController3.view.snp.bottom).offset(10)
                $0.leading.equalToSuperview().inset(10)
                $0.width.equalTo((UIScreen.main.bounds.width - 30 ) / 2)
                $0.height.equalTo(UIScreen.main.bounds.height / 4)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4){
            self.marketInfoHostingController6.view.snp.removeConstraints()
            self.marketInfoHostingController6 = UIHostingController( rootView: TradingChartView(dailyData: self.apiResult.map{ a -> Double in
                return Double(a.trPrc ?? "0.0") ?? 0.0
            }, startDate: Date(), endDate: Date(), name: "포함종목 거래대금 총합" ) )
            
            if #available(iOS 16.0, *) {
                self.marketInfoHostingController6.sizingOptions = .preferredContentSize
            }
            self.addChild(self.marketInfoHostingController6)
            self.marketInfoHostingController6.view.translatesAutoresizingMaskIntoConstraints = false
            
            self.restView.addSubview(self.marketInfoHostingController6.view)
            self.marketInfoHostingController6.view.snp.makeConstraints{
                $0.top.equalTo(self.marketInfoHostingController4.view.snp.bottom).offset(10)
                $0.trailing.equalToSuperview().inset(10)
                $0.width.equalTo((UIScreen.main.bounds.width - 30 ) / 2)
                $0.height.equalTo(UIScreen.main.bounds.height / 4)
            }
        }
        
    }
    func attribute(){
        
        alphaView.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.1)
        alphaView.addTarget(self, action: #selector(backTo), for: .touchUpInside)
        
        restView.backgroundColor = UIColor(red: 200/255, green: 220/255, blue: 250/255, alpha: 0.7)
        
        [ marketInfoHostingController1, marketInfoHostingController2, marketInfoHostingController3, marketInfoHostingController4, marketInfoHostingController5, marketInfoHostingController6].forEach{
//            $0.sizingOptions = .preferredContentSize
            $0.view.layer.borderWidth = 2.0
            $0.view.layer.borderColor = UIColor.black.cgColor
            $0.view.layer.cornerRadius = 10
        }
       
        
    }
    
    @objc func backTo(){
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func layout(){
        [alphaView, restView].forEach{
            view.addSubview($0)
        }
        
        alphaView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.height / 6)
            
        }
        restView.snp.makeConstraints{
            $0.top.equalTo(alphaView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        [marketInfoHostingController1, marketInfoHostingController2, marketInfoHostingController3, marketInfoHostingController4, marketInfoHostingController5, marketInfoHostingController6].forEach{
            restView.addSubview($0.view)
        }
       
        marketInfoHostingController1.view.snp.makeConstraints{
            $0.top.leading.equalToSuperview().inset(10)
            $0.width.equalTo((UIScreen.main.bounds.width - 30 ) / 2)
            $0.height.equalTo(UIScreen.main.bounds.height / 4)
        }
        
        marketInfoHostingController2.view.snp.makeConstraints{
            $0.top.trailing.equalToSuperview().inset(10)
            $0.width.equalTo((UIScreen.main.bounds.width - 30 ) / 2)
            $0.height.equalTo(UIScreen.main.bounds.height / 4)
        }
        
        marketInfoHostingController3.view.snp.makeConstraints{
            $0.top.equalTo(marketInfoHostingController1.view.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.width.equalTo((UIScreen.main.bounds.width - 30 ) / 2)
            $0.height.equalTo(UIScreen.main.bounds.height / 4)
        }
        
        marketInfoHostingController4.view.snp.makeConstraints{
            $0.top.equalTo(marketInfoHostingController2.view.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(10)
            
            $0.width.equalTo((UIScreen.main.bounds.width - 30 ) / 2)
            $0.height.equalTo(UIScreen.main.bounds.height / 4)
        }
        
        marketInfoHostingController5.view.snp.makeConstraints{
            $0.top.equalTo(marketInfoHostingController3.view.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.width.equalTo((UIScreen.main.bounds.width - 30 ) / 2)
            $0.height.equalTo(UIScreen.main.bounds.height / 4)
        }
        
        marketInfoHostingController6.view.snp.makeConstraints{
            $0.top.equalTo(marketInfoHostingController4.view.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.equalTo((UIScreen.main.bounds.width - 30 ) / 2)
            $0.height.equalTo(UIScreen.main.bounds.height / 4)
        }

    }
}

extension MarketInfoDetailViewController{
    private func requestAPI(url: String){
    
        let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"])))
        print("encode된 url string : ", encoded)
        //addingPercentEncoding은 한글(영어 이외의 값) 이 url에 포함되었을 때 오류나는 것을 막아준다.
        AF.request(encoded ?? "")
            .responseDecodable(of: ValueForLineChart.self){ [weak self] response in
                // success 이외의 응답을 받으면, else문에 걸려 함수 종료
                guard
                    let self = self,
                    case .success(let data) = response.result else {
                    print("실패ㅜㅜ")
                    return }
                print("실패 아니면 여기 나와야함!!!")
               
                let now_arr = data.response.body.items.item
                //데이터 받아옴
                self.apiResult = now_arr.map{ now_item -> ValueForLineChartCellData in
                    //여기서 각 변수들이 nil, 혹은 nil이 아닌 값일 수 있는데,
                    // nil이 아닌 것들만 가지고 title을 정하고 , 나머지를 이어붙여 subtitle을 만든다
                    
                    let now_cellData: ValueForLineChartCellData = ValueForLineChartCellData(mkp: now_item.mkp, clpr: now_item.clpr, hipr: now_item.hipr, lopr: now_item.lopr, vs: now_item.vs, fltRt: now_item.fltRt, trqu: now_item.trqu, trPrc: now_item.trPrc, purRgtScrtItmsClpr: now_item.purRgtScrtItmsClpr, exertPric: now_item.exertPric, basIdx: now_item.basIdx, yrWRcrdHgst: now_item.yrWRcrdHgst, yrWRcrdLwst: now_item.yrWRcrdLwst, totBnfIdxClpr: now_item.totBnfIdxClpr, totBnfIdxVs: now_item.totBnfIdxVs, nPrcIdxClpr: now_item.nPrcIdxClpr, nPrcIdxVs: now_item.nPrcIdxVs, zrRinvIdxClpr: now_item.zrRinvIdxClpr, zrRinvIdxVs: now_item.zrRinvIdxVs, clRinvIdxClpr: now_item.clRinvIdxClpr, clRinvIdxVs: now_item.clRinvIdxVs, mrktPrcIdxClpr: now_item.mrktPrcIdxClpr, mrktPrcIdxVs: now_item.mrktPrcIdxVs, cnvt: now_item.cnvt, nav: now_item.nav, nPptTotAmt: now_item.nPptTotAmt, bssIdxClpr: now_item.bssIdxClpr, hiprPrc: now_item.hiprPrc, loprPrc: now_item.loprPrc, clprPrc: now_item.clprPrc, clprVs: now_item.clprVs, clprBnfRt: now_item.clprBnfRt, sptPrc: now_item.sptPrc, stmPrc: now_item.stmPrc, opnint: now_item.opnint, iptVlty: now_item.iptVlty)
                    
                    return now_cellData
                }
            }
            .resume()
        print("api끝!")
    }
}
