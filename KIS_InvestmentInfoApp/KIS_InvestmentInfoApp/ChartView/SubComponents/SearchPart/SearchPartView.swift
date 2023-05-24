//
//  SearchPartView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/24.
//


import UIKit
import Alamofire

enum Section{
    case StockSecuritiesInfoService
    case MarketIndexInfoService
    case GeneralProductInfoService
    case SecuritiesProductInfoService
    case BondSecuritiesInfoService
    case DerivativeProductInfoService
}

enum SubSection {
    case getStockPriceInfo
    case getPreemptiveRightCertificatePriceInfo
    case getSecuritiesPriceInfo
    case getPreemptiveRightSecuritiesPriceInfo
    case getStockMarketIndex
    case getBondMarketIndex
    case getDerivationProductMarketIndex
    case getOilPriceInfo
    case getGoldPriceInfo
    case getCertifiedEmissionReductionPriceInfo
    case getETFPriceInfo
    case getETNPriceInfo
    case getELWPriceInfo
    case getBondPriceInfo
    case getStockFuturesPriceInfo
    case getOptionsPriceInfo
}


class SearchPartView: UIView {
    
    private var section: Section = .MarketIndexInfoService
    private var subSection: SubSection = .getStockMarketIndex
    private var now_section_idx: Int = 0
    private var now_subSection_idx: Int = 0
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0.0
        stackView.backgroundColor = .white
        return stackView
    }()
    private let itemNmLabel = UILabel()
    private let itemNmTextField = UITextField()
    private let startDateLabel = UILabel()
    private let startDateTextField = UITextField()
    private let endDateLabel = UILabel()
    private let endDateTextField = UITextField()
    private let blankView = UIView()
    private let requestButton = UIButton()
    private let blankView2 = UIView()
    private let searchPartCV = SearchPartCollectionView(frame: .zero, collectionViewLayout: SearchPartCollectionViewLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 200/255, green: 220/255, blue: 250/255, alpha: 1.0)
        NotificationCenter.default.addObserver(self, selector: #selector(chartSectionDidChanged(_:)), name: .DidTapUnClickedCell, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(chartSubSectionDidChanged(_:)), name: .DidTapItemSubSectionCell_Chart, object: nil)
        attribute()
        layout()
    }
    //section cell 선택이 바뀌었을 때 호출될 함수
    @objc func chartSectionDidChanged(_ notification: Notification){
        guard let clickedIdx = notification.userInfo?["idx"] as? Int else { return }
        now_section_idx = clickedIdx
        now_subSection_idx = 0

        print("SearchPartView에서도 section이 바뀜 : ", now_section_idx, now_subSection_idx)
    }
    
    //section cell 선택이 바뀌었을 때 호출될 함수
    @objc func chartSubSectionDidChanged(_ notification: Notification){
        guard let clickedIdx = notification.userInfo?["idx"] as? Int else { return }
        now_subSection_idx = clickedIdx
        print("SearchPartView에서도 subSection이 바뀜 : ", now_section_idx, now_subSection_idx)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attribute(){
        itemNmLabel.backgroundColor = .systemBackground
        itemNmLabel.text = "항목 이름"
        itemNmLabel.font = UIFont.systemFont(ofSize: 14)
        
        itemNmTextField.layer.borderWidth = 2.0
        itemNmTextField.layer.borderColor = UIColor(red: 195/255, green: 215/255, blue: 255/255, alpha: 1).cgColor
        itemNmTextField.layer.cornerRadius = 12.0
        itemNmTextField.backgroundColor = .systemBackground
        itemNmTextField.placeholder = "항목명 입력"
        itemNmTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: itemNmTextField.frame.height))
        itemNmTextField.leftViewMode = .always
        itemNmTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            
        startDateLabel.backgroundColor = .systemBackground
        startDateLabel.text = "차트조회 시작일"
        startDateLabel.font = UIFont.systemFont(ofSize: 14)
        
        startDateTextField.layer.borderWidth = 2.0
        startDateTextField.layer.borderColor = UIColor(red: 195/255, green: 215/255, blue: 255/255, alpha: 1).cgColor
        startDateTextField.layer.cornerRadius = 12.0
        startDateTextField.backgroundColor = .systemBackground
        startDateTextField.placeholder = "조회 시작일 선택"
            //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        startDateTextField.leftView =  UIView(frame: CGRect(x: 0, y: 0, width: 10, height: startDateTextField.frame.height))
        startDateTextField.leftViewMode = .always

        endDateLabel.backgroundColor = .systemBackground
        endDateLabel.text = "차트조회 종료일"
        endDateLabel.font = UIFont.systemFont(ofSize: 14)
        
        endDateTextField.layer.borderWidth = 2.0
        endDateTextField.layer.borderColor = UIColor(red: 195/255, green: 215/255, blue: 255/255, alpha: 1).cgColor
        endDateTextField.layer.cornerRadius = 12.0
        endDateTextField.backgroundColor = .systemBackground
        endDateTextField.placeholder = "조회 종료일 선택"
        endDateTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: endDateTextField.frame.height))
        endDateTextField.leftViewMode = .always
        
        requestButton.layer.cornerRadius = 8.0
        requestButton.layer.borderWidth = 2.0
        requestButton.layer.borderColor = UIColor(red: 195/255, green: 215/255, blue: 255/255, alpha: 1).cgColor
        requestButton.backgroundColor = UIColor(red: 170/255, green: 190/255, blue: 250/255, alpha: 1)
        requestButton.setTitle("조회", for: .normal)
        requestButton.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .bold)
    }
    
    func layout(){
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            //가로를 고정시켜주어 세로스크롤 뷰가 된다.
            $0.width.equalToSuperview()
        }
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        [ itemNmLabel, itemNmTextField, startDateLabel, startDateTextField, endDateLabel, endDateTextField, blankView, requestButton, blankView2, searchPartCV ].forEach{
            stackView.addArrangedSubview($0)
        }
        
        itemNmLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(34)
            $0.width.equalTo(80)
        }
        
        itemNmTextField.snp.makeConstraints{
            $0.leading.equalTo(itemNmLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview()
        }
        
        startDateLabel.snp.makeConstraints{
            $0.leading.equalTo(itemNmLabel.snp.leading)
            $0.height.equalTo(34)
            $0.width.equalTo(80)
        }
        
        startDateTextField.snp.makeConstraints{
            $0.leading.equalTo(itemNmLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview()
        }
        
        endDateLabel.snp.makeConstraints{
            $0.leading.equalTo(itemNmLabel.snp.leading)
            $0.height.equalTo(34)
            $0.width.equalTo(80)
        }
        
        endDateTextField.snp.makeConstraints{
            $0.leading.equalTo(itemNmLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview()
        }
        blankView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
        requestButton.snp.makeConstraints{
            $0.leading.equalTo(itemNmLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(46)
            $0.trailing.equalToSuperview()
        }
        
        blankView2.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
        searchPartCV.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1000)
        }
    }
    
    //request 보내는 것과 연동해야함 itemNmTextField
    @objc func textFieldDidChange(_ textField: UITextField){
        print(textField.text)
        
        let now_text: String = textField.text ?? ""
//        self.requestAPI(url: "", keyword: now_text)
        searchPartCV.reloadData()
    }
    
    
    func setupBySection(section: Section, subSection: SubSection){
        self.section = section
        self.subSection = subSection
        reloadViewBySection()
    }
    
    func reloadViewBySection(){
        //섹션, subSection값을 이용해 테마 변경
    }
}

extension SearchPartView{
//    private func requestAPI(url: String, keyword: String){
//        //addingPercentEncoding은 한글(영어 이외의 값) 이 url에 포함되었을 때 오류나는 것을 막아준다.
//        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
//            .responseDecodable(of: IS_StockPriceInfo.self){ [weak self] response in
//                // success 이외의 응답을 받으면, else문에 걸려 함수 종료
//                guard
//                    let self = self,
//                    case .success(let data) = response.result else { return }
//                print("실패 아니면 여기 나와야함!!!")
//                
//                let now_arr = data.response.body.items.item
//                //데이터 받아옴
//                self.itemsArr = now_arr.map{ now_item -> (String, String) in
//                    //여기서 각 변수들이 nil, 혹은 nil이 아닌 값일 수 있는데,
//                    // nil이 아닌 것들만 가지고 title을 정하고 , 나머지를 이어붙여 subtitle을 만든다
//                    let title: String = ((now_item.oilCtg != nil ? now_item.oilCtg : now_item.idxNm) != nil ? now_item.idxNm : now_item.itmsNm) ?? "제목없음"
//                    
//                    
//                    var subtitle: String = ""
//                    [(now_item.idxCsf, ""), (now_item.prdCtg, "상품분류 : "), (now_item.mrktCtg, ""), (now_item.epyItmsCnt, "채용종목수 : "), (now_item.ytm, "만기수익률 : "), (now_item.cnvt, "채권지수 볼록성 : "), (now_item.trqu, "포함종목 거래량 총합 : "), (now_item.trPrc, "포함종목 거래대금 총합 : "), (now_item.bssIdxIdxNm, "기초지수 명칭 : "), (now_item.udasAstNm, "기초자산 명칭 : "),  (now_item.strnCd, "코드 : "), (now_item.isinCd, "국제 채권 식별번호 : ")].forEach {
//                        if $0.0 != nil {
//                            subtitle += $0.1 + $0.0! + " / "
//                        }
//                    }
//                    subtitle.removeLast()
//                    subtitle.removeLast()
//                    subtitle.removeLast()
//                    
//                    
//                    let temp = ( title, subtitle )
//                    return temp
//                }
//                //테이블 뷰 다시 그려줌
//                self.showMode = .all
//                self.tableView.reloadData()
//            }
//            .resume()
//    }
}

