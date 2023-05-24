//
//  SearchPartView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/24.
//


import UIKit


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
    
    // 그래프 이외의 Component들
    let itemNmLabel = UILabel()
   

    let itemNmTextField = UITextField()
        

    
    // 그래프 이외의 Component들
    let startDateLabel = UILabel()
  
    let startDateTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
        tf.layer.cornerRadius = 12.0
        tf.backgroundColor = .systemBackground
        tf.placeholder = "조회 시작일 선택"
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()

    // 그래프 이외의 Component들
    let endDateLabel = UILabel()
    
    private let endDateTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
        tf.layer.cornerRadius = 12.0
        tf.backgroundColor = .systemBackground
        tf.placeholder = "조회 종료일 선택"
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    private let blankView = UIView()
    
    let requestButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 8.0
        btn.layer.borderWidth = 2.0
        btn.layer.borderColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0).cgColor
        btn.backgroundColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 244/255.0, alpha: 1.0)
        btn.setTitle("조회", for: .normal)
//        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .semibold)
//        btn.addTarget(self, action: #selector(reqButtonClicked), for: .touchUpInside)
        return btn
    }()
    

    private let blankView2 = UIView()
    
    private let searchPartCV = SearchPartCollectionView(frame: .zero, collectionViewLayout: SearchPartCollectionViewLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 200/255, green: 220/255, blue: 250/255, alpha: 1.0)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attribute(){
        itemNmLabel.backgroundColor = .systemBackground
        itemNmLabel.text = "항목 이름"
        itemNmLabel.font = UIFont.systemFont(ofSize: 14)
        
        itemNmTextField.layer.borderWidth = 2.0
        itemNmTextField.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
        itemNmTextField.layer.cornerRadius = 12.0
        itemNmTextField.backgroundColor = .systemBackground
        itemNmTextField.placeholder = "항목명 입력"
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: itemNmTextField.frame.height))
        itemNmTextField.leftView = paddingView
        itemNmTextField.leftViewMode = .always
            
        
        startDateLabel.backgroundColor = .systemBackground
        startDateLabel.text = "차트조회 시작일"
        startDateLabel.font = UIFont.systemFont(ofSize: 14)
        
        endDateLabel.backgroundColor = .systemBackground
        endDateLabel.text = "차트조회 종료일"
        endDateLabel.font = UIFont.systemFont(ofSize: 14)
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
            $0.height.equalTo(34)
            $0.width.equalTo(80)
        }
        
        itemNmTextField.snp.makeConstraints{
            $0.leading.equalTo(itemNmLabel.snp.leading)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview()
        }
        
        startDateLabel.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.height.equalTo(34)
            $0.width.equalTo(80)
        }
        
        startDateTextField.snp.makeConstraints{
            $0.leading.equalTo(itemNmLabel.snp.leading)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview()
        }
        
        endDateLabel.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.height.equalTo(34)
            $0.width.equalTo(80)
        }
        
        endDateTextField.snp.makeConstraints{
            $0.leading.equalTo(itemNmLabel.snp.leading)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview()
        }
        blankView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
        requestButton.snp.makeConstraints{
            $0.leading.equalTo(itemNmLabel.snp.leading)
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
    
    func setupBySection(section: Section, subSection: SubSection){
        self.section = section
        self.subSection = subSection
        reloadViewBySection()
    }
    
    func reloadViewBySection(){
        //섹션, subSection값을 이용해 테마 변경
    }
    

    
}
