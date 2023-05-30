//
//  MarketCollectionViewCell.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/12.
//

import UIKit
import SnapKit
import Alamofire
import SwiftUI

enum MarketCellShowMode {
    case Simple
    case AllTextData
    case price3Chart
}

class MarketCollectionViewCell: UICollectionViewCell {
    

    private let terms: [String] = Array(MarketInfoData.r_dict.values)
    private var showMode: MarketCellShowMode = .Simple
    private var url: String = ""
    private var apiResult: [ValueForAllCellData] = []
    private var apiResultToShow: [Double] = []
    private var title: String = ""
    private var subTitle: String = ""
    private var section: Int = 0
    private var subSection: Int = 0
    private var chartName: String = ""
    
    private let modeButton = UIButton()
    private let titleLabel = UILabel()
    private let scrollView = UIScrollView()
    private let subTitleLabel = UILabel()

    private let tableView = UITableView()
    
    private let uiView = UIView()
    private var marketInfoHostingController1: UIHostingController = {
        let hostingController = UIHostingController( rootView: TradingChartView(dailyData: Array(repeating: 0.0, count: 90), startDate: Date(), endDate: Date(), name: "로딩중..." ) )
        if #available(iOS 16.0, *) {
            hostingController.sizingOptions = .preferredContentSize
        }
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func attribute(){
        layer.borderWidth = 3
        layer.borderColor = UIColor(red: 160/255, green: 170/255, blue: 240/255, alpha: 1.0).cgColor
        layer.cornerRadius = 10.0
        layer.borderWidth = 3.0
       
        self.backgroundColor = .systemBackground
        
        modeButton.layer.borderWidth = 1.0
        modeButton.layer.borderColor = UIColor.lightGray.cgColor
        modeButton.layer.cornerRadius = 8.0
        modeButton.setTitle("simple", for: .normal)
        modeButton.setTitleColor(.lightGray, for: .normal)
        modeButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        modeButton.backgroundColor = .white
        modeButton.addTarget(self, action: #selector(modeButtonClicked), for: .touchUpInside)
        
        scrollView.showsHorizontalScrollIndicator = false
        titleLabel.font = .systemFont(ofSize: 32.0, weight: .bold)
        titleLabel.textColor = .darkGray
        titleLabel.textAlignment = .center
        
        subTitleLabel.font = .systemFont(ofSize: 20.0, weight: .bold)
        subTitleLabel.textColor = .darkGray
        subTitleLabel.textAlignment = .left
        
        tableView.backgroundColor = .lightGray
        tableView.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self

        tableView.rowHeight = 30
    }
    @objc func modeButtonClicked(){
        print("clicked")
        switch self.showMode {
        case .Simple:
            self.showMode = .AllTextData
            modeButton.setTitle("all", for: .normal)
            changeLayoutByMode()
        case .AllTextData:
            self.showMode = .price3Chart
            modeButton.setTitle("chart", for: .normal)
            changeLayoutByMode()
        case .price3Chart:
            self.showMode = .Simple
            modeButton.setTitle("simple", for: .normal)
            changeLayoutByMode()
        }
    }
    
    private func changeLayoutByMode(){
        switch self.showMode {
        case .Simple:
            self.uiView.removeFromSuperview()
            self.marketInfoHostingController1.view.removeFromSuperview()
            self.marketInfoHostingController1.view.isHidden = true
            self.uiView.isHidden = true
//            self.uiView.snp.removeConstraints()
            titleLabel.isHidden = false
            titleLabel.font = .systemFont(ofSize: 32.0, weight: .bold)
            titleLabel.snp.removeConstraints()
            titleLabel.snp.makeConstraints{
                $0.leading.trailing.equalToSuperview().inset(10)
                $0.centerY.equalToSuperview().offset(-20)
            }
            
            scrollView.isHidden = false
            
        case .AllTextData:
            titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
            titleLabel.snp.removeConstraints()
            scrollView.isHidden = true
            addSubview(titleLabel)
            titleLabel.snp.makeConstraints{
                $0.leading.top.equalToSuperview().inset(10)
            }
            tableView.isHidden = false
            addSubview(tableView)
            tableView.snp.makeConstraints{
                $0.top.equalTo(modeButton.snp.bottom).offset(8)
                $0.leading.trailing.bottom.equalToSuperview().inset(10)
            }
            
            
           
        case .price3Chart:
            
           
                self.tableView.isHidden = true
                self.marketInfoHostingController1.view.isHidden = false
                self.uiView.isHidden = false
            self.marketInfoHostingController1 = UIHostingController( rootView: TradingChartView(dailyData: self.apiResultToShow, startDate: Date(), endDate: Date(), name: "" ) )
                
                if #available(iOS 16.0, *) {
                    self.marketInfoHostingController1.sizingOptions = .preferredContentSize
                }
            
            self.addSubview(self.uiView)
            self.uiView.snp.makeConstraints{
                $0.top.equalTo(self.modeButton.snp.bottom).offset(40)
                $0.leading.trailing.bottom.equalToSuperview().inset(40)
            }
                self.uiView.addSubview(self.marketInfoHostingController1.view)
                self.marketInfoHostingController1.view.translatesAutoresizingMaskIntoConstraints = false
                self.marketInfoHostingController1.view.snp.makeConstraints{
                    $0.top.bottom.equalToSuperview().inset(20)
                    $0.leading.trailing.equalToSuperview()
                }
                
                
            
        }
    }
    private func layout(){
        [ modeButton, titleLabel, scrollView ].forEach{ addSubview($0)}
        
        modeButton.snp.makeConstraints{
            $0.top.trailing.equalToSuperview().inset(6)
            $0.height.equalTo(30)
            $0.width.equalTo("simple".size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10, weight: .regular)]).width + 20)
        }
        
        titleLabel.snp.makeConstraints{
//            $0.top.equalTo(modeButton.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview().offset(-20)
            
        }
        scrollView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(26)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(6)
        }
        scrollView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }

    }
    
    func setup(title: String, subtitle: String, section: Int, subSection: Int){
        self.titleLabel.text = title
        self.subTitleLabel.text = subtitle
        
        self.title = title
        self.subTitle = subtitle
        self.section = section
        self.subSection = subSection
        self.url = MarketInfoData.getMarketSubSectionsUrl(row: section, col: subSection) +  ( section == 1 ? "&idxNm=" : ( section == 2 && subSection == 0 ? "&oilCtg=" : "&itmsNm=")) + ( title != "제목없음" ? title : "")
        print("setup한 url", self.url)
    }
    
}



extension MarketCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        requestAPI(url: self.url, term: terms[indexPath.row])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4){
            self.showMode = .price3Chart
            self.modeButton.setTitle("chart", for: .normal)
            self.changeLayoutByMode()
        }
    }
}

extension MarketCollectionViewCell: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MarketInfoData.r_dict.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
       
        cell.textLabel?.text = terms[indexPath.row]
       
        cell.selectionStyle = .none
        return cell
    }
}


extension MarketCollectionViewCell{
    private func requestAPI(url: String, term: String){
    
        let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"])))
        print("encode된 url string : ", encoded)
        //addingPercentEncoding은 한글(영어 이외의 값) 이 url에 포함되었을 때 오류나는 것을 막아준다.
        AF.request(encoded ?? "")
            .responseDecodable(of: ValueForAll.self){ [weak self] response in
                // success 이외의 응답을 받으면, else문에 걸려 함수 종료
                guard
                    let self = self,
                    case .success(let data) = response.result else {
                    print("실패ㅜㅜ")
                    return }
                print("실패 아니면 여기 나와야함!!!")
               
                let now_arr = data.response.body.items.item
                //데이터 받아옴
                self.apiResult = now_arr.map{ now_item -> ValueForAllCellData in
                    //여기서 각 변수들이 nil, 혹은 nil이 아닌 값일 수 있는데,
                    // nil이 아닌 것들만 가지고 title을 정하고 , 나머지를 이어붙여 subtitle을 만든다
                    
                    let now_cellData: ValueForAllCellData = ValueForAllCellData(basDt: now_item.basDt, srtnCd: now_item.srtnCd, itmsNm: now_item.itmsNm, mrktCtg: now_item.mrktCtg, mkp: now_item.mkp, clpr: now_item.clpr, hipr: now_item.hipr, lopr: now_item.lopr, vs: now_item.vs, fltRt: now_item.fltRt, trqu: now_item.trqu, trPrc: now_item.trPrc, lstgStCnt: now_item.lstgStCnt, isinCd: now_item.isinCd, mrktTotAmt: now_item.mrktTotAmt, nstIssPrc: now_item.nstIssPrc, dltDt: now_item.dltDt, purRgtScrtItmsCd: now_item.purRgtScrtItmsCd, purRgtScrtItmsNm: now_item.purRgtScrtItmsNm, purRgtScrtItmsClpr: now_item.purRgtScrtItmsClpr, stLstgCnt: now_item.stLstgCnt, exertPric: now_item.exertPric, subtPdSttgDt: now_item.subtPdSttgDt, subtPdEdDt: now_item.subtPdEdDt, lstgScrtCnt: now_item.lstgScrtCnt, lsYrEdVsFltRt: now_item.lsYrEdVsFltRt, basPntm: now_item.basPntm, basIdx: now_item.basIdx, idxCsf: now_item.idxCsf, idxNm: now_item.idxNm, epyItmsCnt: now_item.epyItmsCnt, lstgMrktTotAmt: now_item.lstgMrktTotAmt, lsYrEdVsFltRg: now_item.lsYrEdVsFltRg, yrWRcrdHgst: now_item.yrWRcrdHgst, yrWRcrdHgstDt: now_item.yrWRcrdHgstDt, yrWRcrdLwst: now_item.yrWRcrdLwst, yrWRcrdLwstDt: now_item.yrWRcrdLwstDt, totBnfIdxClpr: now_item.totBnfIdxClpr, totBnfIdxVs: now_item.totBnfIdxVs, nPrcIdxClpr: now_item.nPrcIdxClpr, nPrcIdxVs: now_item.nPrcIdxVs, zrRinvIdxClpr: now_item.zrRinvIdxClpr, zrRinvIdxVs: now_item.zrRinvIdxVs, clRinvIdxClpr: now_item.clRinvIdxClpr, clRinvIdxVs: now_item.clRinvIdxVs, mrktPrcIdxClpr: now_item.mrktPrcIdxClpr, mrktPrcIdxVs: now_item.mrktPrcIdxVs, durt: now_item.durt, cnvt: now_item.cnvt, ytm: now_item.ytm, wtAvgPrcCptn: now_item.wtAvgPrcCptn, wtAvgPrcDisc: now_item.wtAvgPrcDisc, oilCtg: now_item.oilCtg, nav: now_item.nav, nPptTotAmt: now_item.nPptTotAmt, bssIdxIdxNm: now_item.bssIdxIdxNm, bssIdxClpr: now_item.bssIdxClpr, indcValTotAmt: now_item.indcValTotAmt, indcVal: now_item.indcVal, udasAstNm: now_item.udasAstNm, udasAstClpr: now_item.udasAstClpr, mkpBnfRt: now_item.mkpBnfRt, hiprPrc: now_item.hiprPrc, hiprBnfRt: now_item.hiprBnfRt, loprPrc: now_item.loprPrc, loprBnfRt: now_item.loprBnfRt, xpYrCnt: now_item.xpYrCnt, itmsCtg: now_item.itmsCtg, clprPrc: now_item.clprPrc, clprVs: now_item.clprVs, clprBnfRt: now_item.clprBnfRt, prdCtg: now_item.prdCtg, sptPrc: now_item.sptPrc, stmPrc: now_item.stmPrc, opnint: now_item.opnint, nxtDdBsPrc: now_item.nxtDdBsPrc, iptVlty: now_item.iptVlty)
                    
                    return now_cellData
                }
                if term == "최고가" {
                    self.apiResultToShow = self.apiResult.map{ a -> Double in
                        return Double(a.hipr ?? "0.0") ?? 0.0
                    }
                    self.chartName = "최고가"
                }
                else if term == "최저가" {
                    self.apiResultToShow = self.apiResult.map{ a -> Double in
                        return Double(a.lopr ?? "0.0") ?? 0.0
                    }
                    self.chartName = "최저가"
                }
                else if term == "종가" {
                    self.apiResultToShow = self.apiResult.map{ a -> Double in
                        return Double(a.clpr ?? "0.0") ?? 0.0
                    }
                    self.chartName = "종가"
                }
                else if term == "시가" {
                    self.apiResultToShow = self.apiResult.map{ a -> Double in
                        return Double(a.mkp ?? "0.0") ?? 0.0
                    }
                    self.chartName = "시가"
                }
            
                
              
            }
            .resume()
        print("api끝!")
    }
}
