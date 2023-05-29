//
//  SearchPartView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/24.
//


import UIKit
import Alamofire
import SnapKit

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
    private var startDate: Date?
    private var endDate: Date?

    var arrsToShow: [(String, String)] = []
    
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
    
    
    
    // ---------------------========================----------------========================--------------------- //
    
    
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
    private let blankView0 = UIView()
//    private let searchPartCV = SearchPartCollectionView(frame: .zero, collectionViewLayout: SearchPartCollectionViewLayout())
    private let tableView: UITableView = UITableView()
    private let hideTableStackView = UIStackView()
    private let hideTableButton: UIButton = UIButton()
    private let startDateLabel = UILabel()
    private let startDateTextField = UITextField()
    private let startDateDatePicker = SearchDatePicker()
    private let endDateLabel = UILabel()
    private let endDateTextField = UITextField()
    private let endDateDatePicker = SearchDatePicker()
    private let blankView = UIView()
    private let requestButton = UIButton()
    private let blankView20 = UIView()
    private let blankView2 = UIView()
    private let blankView3 = UIView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = GridLayout()
        layout.cellHeight = 44
        layout.cellWidths = Array(repeating: CGFloat(120), count: jsonResultArr[0].count + 1)
        let cv = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        
        cv.isDirectionalLockEnabled = true
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        cv.register(ShowDataViewCollectionViewCell.self, forCellWithReuseIdentifier: "ShowDataViewCollectionViewCell")
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = true
        cv.backgroundColor = .systemBackground
        cv.layer.borderWidth = 1.0
        cv.layer.borderColor = UIColor.lightGray.cgColor
        cv.backgroundColor = .white
        return cv
    }()
    
    private let hide_save_stackView = UIStackView()
    private let hideChartButton = UIButton()
    private let saveButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 200/255, green: 220/255, blue: 250/255, alpha: 1.0)
        NotificationCenter.default.addObserver(self, selector: #selector(chartSectionDidChanged(_:)), name: .DidTapUnClickedCell, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(chartSubSectionDidChanged(_:)), name: .DidTapItemSubSectionCell_Chart, object: nil)
     
        attribute()
        layout()
        hideTableStackView.isHidden = true
        hideTableButton.isHidden = true
        collectionView.isHidden = true
        hide_save_stackView.isHidden = true
        blankView0.isHidden = true
        tableView.isHidden = true
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
        itemNmTextField.autocapitalizationType = .none
        itemNmTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemBackground
        
            
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
        requestButton.addTarget(self, action: #selector(requestfunc), for: .touchUpInside)
        
        hideTableButton.layer.cornerRadius = 6
        hideTableButton.layer.borderWidth = 2.0
        hideTableButton.layer.borderColor = UIColor.darkGray.cgColor
        hideTableButton.backgroundColor = UIColor(red: 195/255, green: 215/255, blue: 255/255, alpha: 1)
        hideTableButton.setTitle("숨기기", for: .normal)
        hideTableButton.titleLabel?.font = .systemFont(ofSize: 12.0, weight: .bold)
        hideTableButton.addTarget(self, action: #selector(hideTablefunc), for: .touchUpInside)
        hideTableButton.setTitleColor(.black, for: .normal)
        
        hideChartButton.layer.cornerRadius = 8.0
        hideChartButton.layer.borderWidth = 2.0
        hideChartButton.layer.borderColor = UIColor(red: 195/255, green: 215/255, blue: 255/255, alpha: 1).cgColor
        hideChartButton.backgroundColor = UIColor(red: 170/255, green: 190/255, blue: 250/255, alpha: 1)
        hideChartButton.setTitle("숨기기", for: .normal)
        hideChartButton.setTitleColor(.white, for: .normal)
        hideChartButton.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .bold)
        hideChartButton.addTarget(self, action: #selector(hidefunc), for: .touchUpInside)
        
        saveButton.layer.cornerRadius = 8.0
        saveButton.layer.borderWidth = 2.0
        saveButton.layer.borderColor = UIColor(red: 195/255, green: 215/255, blue: 255/255, alpha: 1).cgColor
        saveButton.backgroundColor = UIColor(red: 170/255, green: 190/255, blue: 250/255, alpha: 1)
        saveButton.setTitle("CSV 저장", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .bold)
        saveButton.addTarget(self, action: #selector(savefunc), for: .touchUpInside)
        
        // for에는 어떤 event가 일어났을 때 action에 정의한 메서드를 호출할 것인지
        // 첫 번째 parameter에는 target
        self.startDateDatePicker.addTarget(
            self,
            action: #selector(startDateDatePickerValueDidChange(_:) ),
            for: .valueChanged
        )
        //dateTextField를 눌렀을 때, keyboard가 아닌 datePicker가 나오게 된다!
        self.startDateTextField.inputView = self.startDateDatePicker
        
        self.endDateDatePicker.addTarget(
            self,
            action: #selector(endDateDatePickerValueDidChange(_:) ),
            for: .valueChanged
        )
        //dateTextField를 눌렀을 때, keyboard가 아닌 datePicker가 나오게 된다!
        self.endDateTextField.inputView = self.endDateDatePicker
        
        
       

        let toolBar1 = UIToolbar()
        let toolBar2 = UIToolbar()

        [toolBar1, toolBar2].forEach {
            let doneBT = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.pickerDone))
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let cancelBT = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.pickerDone))
            $0.tintColor = .systemBrown
            $0.isTranslucent = true
            $0.sizeToFit()
            $0.setItems([cancelBT,flexibleSpace,doneBT], animated: false)
            $0.isUserInteractionEnabled = true
        }
        
        startDateTextField.inputAccessoryView = toolBar1
        endDateTextField.inputAccessoryView = toolBar2
    }
        @objc func pickerDone(){
            self.endEditing(true)
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
        
        [ itemNmLabel, itemNmTextField, blankView0, tableView, hideTableStackView, startDateLabel, startDateTextField, endDateLabel, endDateTextField, blankView, collectionView, blankView20, hide_save_stackView, blankView2, requestButton, blankView3 ].forEach{
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
            
        }
        
        blankView0.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(14)
        }
        
        tableView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        hideTableStackView.snp.makeConstraints{
            $0.leading.equalTo(itemNmLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }
        
        hideTableStackView.addSubview(hideTableButton)
        hideTableButton.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalTo(80)
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
        
        collectionView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(400)
        }
        blankView20.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
        
        hide_save_stackView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(46)
        }
        
        [hideChartButton, saveButton].forEach {
            hide_save_stackView.addSubview($0)
        }
        
        hideChartButton.snp.makeConstraints{
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo((UIScreen.main.bounds.width - 40) / 2 - 6)
        }
        
        saveButton.snp.makeConstraints{
            $0.trailing.top.bottom.equalToSuperview()
            $0.width.equalTo((UIScreen.main.bounds.width - 40) / 2 - 6)
        }
        blankView2.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
        
        requestButton.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(46)
        }
        
        blankView3.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}

// #Selector 함수들
extension SearchPartView {
    //section cell 선택이 바뀌었을 때 호출될 함수
    @objc func chartSectionDidChanged(_ notification: Notification){
        guard let clickedIdx = notification.userInfo?["idx"] as? Int else { return }
        now_section_idx = clickedIdx
        now_subSection_idx = 0
        print("SearchPartView에서도 section이 바뀜 : ", now_section_idx, now_subSection_idx)
        
        self.itemNmTextField.text = ""
        self.startDateTextField.text = ""
        self.endDateTextField.text = ""
        self.startDate = nil
        self.endDate = nil
    }
    
    //section cell 선택이 바뀌었을 때 호출될 함수
    @objc func chartSubSectionDidChanged(_ notification: Notification){
        guard let clickedIdx = notification.userInfo?["idx"] as? Int else { return }
        now_subSection_idx = clickedIdx
        print("SearchPartView에서도 subSection이 바뀜 : ", now_section_idx, now_subSection_idx)
        
        self.itemNmTextField.text = ""
        self.startDateTextField.text = ""
        self.endDateTextField.text = ""
        self.startDate = nil
        self.endDate = nil
    }
    
    //datePicker 선택값이 달라지면 호출될 메서드
    @objc func startDateDatePickerValueDidChange(_ datePicker: UIDatePicker){
        //날짜, text를 반환해주는 역할
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy 년 MM월 dd일(EEEEE)"
//        formatter.dateFormat = "yyyyMMdd"
        formatter.locale = Locale(identifier: "ko_KR")

        self.startDate = datePicker.date
        self.startDateTextField.text = formatter.string(from: datePicker.date)
        // 다른 날짜를 선택해도,키보드로 텍스트를 입력받은 것이 아니기 때문에 dateTextFieldDidChange가 #selector에서 정상적으로 호출되지 않는다. 따라서 pick한 날짜가 변하면, .editingChanged 이벤트를 인위적으로 발생시켜준다.
        self.endDateTextField.sendActions(for: .editingChanged)
        self.endEditing(true)
    }
    
    //datePicker 선택값이 달라지면 호출될 메서드
    @objc func endDateDatePickerValueDidChange(_ datePicker: UIDatePicker){
        //날짜, text를 반환해주는 역할
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy 년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")

        self.endDate = datePicker.date
        self.endDateTextField.text = formatter.string(from: datePicker.date)
        // 다른 날짜를 선택해도,키보드로 텍스트를 입력받은 것이 아니기 때문에 dateTextFieldDidChange가 #selector에서 정상적으로 호출되지 않는다. 따라서 pick한 날짜가 변하면, .editingChanged 이벤트를 인위적으로 발생시켜준다.
        self.endDateTextField.sendActions(for: .editingChanged)
        self.endEditing(true)
    }
    
    //request 보내는 것과 연동해야함 itemNmTextField
    @objc func textFieldDidChange(_ textField: UITextField){
        print(textField.text)
    
        if textField.text == nil || textField.text == "" {
            blankView0.isHidden = true
            tableView.isHidden = true
            hideTableStackView.isHidden = true
            hideTableButton.isHidden = true
        }else {
            blankView0.isHidden = false
            tableView.isHidden = false
            hideTableStackView.isHidden = false
            hideTableButton.isHidden = false
            let now_url: String = MarketInfoData.getMarketSubSectionsUrl(row: now_section_idx, col: now_subSection_idx) +
            ( now_section_idx == 1 ? "&likeIdxNm=" : ( now_section_idx == 2 && now_subSection_idx == 0 ? "&oilCtg=" : "&likeItmsNm=")) + textField.text!
            print(textField.text!)
            requestAPI_ForSearch(url: now_url)
        }
//        tableView.reloadData()
    }
    
    @objc func requestfunc(){
        print("requestfunc 버튼 클릭")
        self.requestAPI(itemName: self.itemNmTextField.text, startDate: self.startDate, endDate: self.endDate)
        self.requestAPI2(itemName: self.itemNmTextField.text, startDate: self.startDate, endDate: self.endDate)
        
        collectionView.isHidden = false
        hide_save_stackView.isHidden = false
    }
    
    @objc func hidefunc(){
        print("hide 버튼 클릭")
        collectionView.isHidden = true
        hide_save_stackView.isHidden = true
    }
    
    @objc func hideTablefunc(){
        print("hideTable clicked")
        hideTableStackView.isHidden = true
        hideTableButton.isHidden = true
        tableView.isHidden = true
    }
    
    @objc func savefunc(){
        print("저장 버튼 클릭")
    }
    
}


extension SearchPartView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return records.count
        return self.jsonResultArr.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return records[section].count
        return self.jsonResultArr[0].count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowDataViewCollectionViewCell", for: indexPath) as? ShowDataViewCollectionViewCell else { return UICollectionViewCell() }
        let isFirstRow: Bool = (indexPath.section == 0)
        let isFirstColumn: Bool = (indexPath.row == 0)


        if !isFirstColumn{
            let now_title: String = jsonResultArr[indexPath.section][indexPath.row - 1]
            if isFirstRow{
                cell.setup(isFirstRow: isFirstRow, isFirstColumn: isFirstColumn, title: now_title, isClicked: isClickedArr_col[indexPath.row - 1], rowIdx: -1, colIdx: indexPath.row - 1)
            }// FirstColumn도 FirstRow도 아닌 경우는 클릭 X
            else{
                cell.setup(isFirstRow: isFirstRow, isFirstColumn: isFirstColumn, title: now_title, isClicked: false, rowIdx: -3, colIdx: -3)
            }

//            cell.setup(isFirstRow: isFirstRow, isFirstColumn: isFirstColumn, title: "sct = " + String(indexPath.section) + "idx = " + String(indexPath.item))
        }
        //FirstColumn인 경우
        else{
            //여기는 firstCol이자 firstRow이므로
            if isFirstRow{
                cell.setup(isFirstRow: isFirstRow, isFirstColumn: isFirstColumn, title: String(indexPath.section), isClicked: false, rowIdx: 0, colIdx: 0)
            }
            else{
                cell.setup(isFirstRow: isFirstRow, isFirstColumn: isFirstColumn, title: String(indexPath.section), isClicked: isClickedArr_row[indexPath.section - 1], rowIdx: indexPath.section - 1, colIdx: -2)
            }

        }
//        cell.setRecord(records[indexPath.section][indexPath.item])
        return cell
    }
}

//@objc func getSelectedSearchResultCell(_ notification: Notification){
//    print("Notification SendSearchResult")
//    guard let now_dict = notification.userInfo as? Dictionary<String, Any> else { return }
//    guard let now_idx = now_dict["searchResultIndex"] as? Int else {return}
//
//    itemNmTextField.text = self.arrsToShow[now_idx].0 + " / " + self.arrsToShow[now_idx].1
//    tableView.isHidden = true
//}

extension SearchPartView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrsToShow.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = arrsToShow[indexPath.row].0
        cell.detailTextLabel?.text = arrsToShow[indexPath.row].1
        
        cell.selectionStyle = .none
        return cell
    }
}

extension SearchPartView: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            print( arrsToShow[indexPath.row] )
        itemNmTextField.text = arrsToShow[indexPath.row].0 + " / " + arrsToShow[indexPath.row].1
            tableView.isHidden = true
        hideTableStackView.isHidden = true
        hideTableButton.isHidden = true
        
    }
}
extension SearchPartView{
    //(itemCode: String, startDate: Date?, endDate: Date?) 매개변수 부분 이걸로 바꿔야함
    private func requestAPI(itemName: String?, startDate: Date?, endDate: Date?) {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        formatter.locale = Locale(identifier: "ko_KR")

        var sDateText: String = ""
        var eDateText: String = ""
        var nowName: String = ""

        if startDate == nil || endDate == nil{
            sDateText = "20221201"
            eDateText = "20221231"

            //입력 안했을 시에 default로 입력할 기간
            self.startDate = formatter.date(from: sDateText)
            self.endDate = formatter.date(from: eDateText)

            let formatter_show = DateFormatter()
            formatter_show.dateFormat = "yyyy 년 MM월 dd일(EEEEE)"
    //        formatter.dateFormat = "yyyyMMdd"
            formatter_show.locale = Locale(identifier: "ko_KR")

            self.startDateTextField.text = formatter_show.string(from: self.startDate!)
            self.endDateTextField.text = formatter_show.string(from: self.endDate!)
        }else{
            sDateText = formatter.string(from: startDate!)
            eDateText = formatter.string(from: endDate!)
        }

        if itemName == nil || itemName == ""{
            nowName = "한국금융지주"
            self.itemNmTextField.text = nowName
        }else{
            nowName = itemName!.trimmingCharacters(in: .whitespaces)
        }

        let newnewurl = "http://apis.data.go.kr/1160100/service/GetStockSecuritiesInfoService/getStockPriceInfo" + "?numOfRows=365&resultType=json&serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D&itmsNm=" + nowName + "&beginBasDt=" + sDateText + "&endBasDt=" + eDateText

        print("url = " + newnewurl)
        let encoded = newnewurl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"])))
        print(encoded)

        //addingPercentEncoding은 한글(영어 이외의 값) 이 url에 포함되었을 때 오류나는 것을 막아준다.
        AF.request(newnewurl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"]))) ?? "")
            .responseDecodable(of: SecurityResponse.self){ [weak self] response in
                // success 이외의 응답을 받으면, else문에 걸려 함수 종료

                print(response)

                guard let self = self,
                    case .success(let data) = response.result else {
                    print("실패ㅜㅜ")
                          return }

                print("실패 아니면 여기 나와야함!!! ")
                //데이터 받아옴
                // [SecurityData] 형태임
                let now_arr = data.response.body.items.item

                self.securityDataArr = now_arr.map{ sd -> SecurityDataCellData in
                    let temp = SecurityDataCellData(basDt: sd.basDt, strnCd: sd.srtnCd, itmsNm: sd.itmsNm, mrktCtg: sd.mrktCtg, mkp: sd.mkp, clpr: sd.clpr, hipr: sd.hipr, lopr: sd.lopr)
                    return temp
                }
                // Identifiable인 SecurityInfo 배열에 방금 받아온 json으로 값을 채움
                self.securityInfoArr = now_arr.map{ sd -> SecurityInfo in
                    let temp = SecurityInfo(basDt: sd.basDt ?? "20220101", strnCd: sd.srtnCd ?? "071050", itmsNm: sd.itmsNm ?? "한국금융지주", mrktCtg: sd.mrktCtg ?? "KOSPI", mkp: sd.mkp ?? "57600", clpr: sd.clpr ?? "58600", hipr: sd.hipr ?? "58600", lopr: sd.lopr ?? "55600")
                    return temp
                }
//                print("받아온 배열 (최종)")

//                print(self.securityDataArr)

                let formatterr = DateFormatter()
                formatterr.dateFormat = "yyyyMMdd"
                formatterr.locale = Locale(identifier: "ko_KR")

//                mkpInfoArr, clprInfoArr, hiprInfoArr, loprInfoArr
                self.mkpInfoArr = self.securityInfoArr.map{ item -> SiteView in
                    let temp = SiteView(hour: formatter.date(from: item.basDt)!, views: Double(item.mkp)!)
                    return temp
                }
                self.clprInfoArr = self.securityInfoArr.map{ item -> SiteView in
                    let temp = SiteView(hour: formatter.date(from: item.basDt)!, views:  Double(item.clpr)!)
                    return temp
                }
                self.hiprInfoArr = self.securityInfoArr.map{ item -> SiteView in
                    let temp = SiteView(hour: formatter.date(from: item.basDt)!, views:  Double(item.hipr)!)
                    return temp
                }
                self.loprInfoArr = self.securityInfoArr.map{ item -> SiteView in
                    let temp = SiteView(hour: formatter.date(from: item.basDt)!, views:  Double(item.lopr)!)
                    return temp
                }
            }
            .resume()
    }

     //String으로 하는 것
    private func requestAPI2(itemName: String?, startDate: Date?, endDate: Date?) {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        formatter.locale = Locale(identifier: "ko_KR")

        var sDateText: String = ""
        var eDateText: String = ""
        var nowName: String = ""

        if startDate == nil || endDate == nil{
            sDateText = "20221201"
            eDateText = "20221231"

            //입력 안했을 시에 default로 입력할 기간
            self.startDate = formatter.date(from: sDateText)
            self.endDate = formatter.date(from: eDateText)

            let formatter_show = DateFormatter()
            formatter_show.dateFormat = "yyyy 년 MM월 dd일(EEEEE)"
    //        formatter.dateFormat = "yyyyMMdd"
            formatter_show.locale = Locale(identifier: "ko_KR")

            self.startDateTextField.text = formatter_show.string(from: self.startDate!)
            self.endDateTextField.text = formatter_show.string(from: self.endDate!)
        }else{
            sDateText = formatter.string(from: startDate!)
            eDateText = formatter.string(from: endDate!)
        }

        if itemName == nil || itemName == ""{
            nowName = "한국금융지주"
            self.itemNmTextField.text = nowName
        }else{
            nowName = itemName!.trimmingCharacters(in: .whitespaces)
        }

        let newnewurl = "http://apis.data.go.kr/1160100/service/GetStockSecuritiesInfoService/getStockPriceInfo" + "?numOfRows=365&resultType=json&serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D&itmsNm=" + nowName + "&beginBasDt=" + sDateText + "&endBasDt=" + eDateText

        print("url = " + newnewurl)
        let encoded = newnewurl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"])))
        print(encoded)
        //addingPercentEncoding은 한글(영어 이외의 값) 이 url에 포함되었을 때 오류나는 것을 막아준다.

        let aaa = AF.request(newnewurl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"]))) ?? "")
            .response(){ [weak self] response in
                guard
                    let self = self,
                    case .success(let data) = response.result else { return }
                //str이, 받아온 json을 형태 그대로 STring으로 만든 것이다.
                let str = String(decoding: data!, as: UTF8.self)
                self.apiResultStr = str
                self.jsonResultArr = JsonParser.jsonToArr2(jsonString: str)
                print(self.jsonResultArr)
                self.isClickedArr_col = Array(repeating: false, count: self.jsonResultArr[0].count)
                self.isClickedArr_row = Array(repeating: false, count: self.jsonResultArr.count - 1)


//                //테이블 뷰 다시 그려줌
                self.collectionView.isHidden = false
                self.collectionView.reloadData()
            }
            .resume()
    }
    
    
    // keyword로 검색하여 SearchPartCollectionView를 검색
    private func requestAPI_ForSearch(url: String){ //
        
        
            let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"])))
            print("encode된 url string : ", encoded)
            //addingPercentEncoding은 한글(영어 이외의 값) 이 url에 포함되었을 때 오류나는 것을 막아준다.
            AF.request(encoded ?? "")
                .responseDecodable(of: IS_StockPriceInfo.self){ [weak self] response in
                    // success 이외의 응답을 받으면, else문에 걸려 함수 종료
                    guard
                        let self = self,
                        case .success(let data) = response.result else {
                        print("실패ㅜㅜ")
                        return }
                    print("실패 아니면 여기 나와야함!!!")
                    
                    let now_arr = data.response.body.items.item
                    print("지금의 url : ",url)
                    print(now_arr)
                    //데이터 받아옴
                    self.arrsToShow = now_arr.map{ now_item -> (String, String) in
                        //여기서 각 변수들이 nil, 혹은 nil이 아닌 값일 수 있는데,
                        // nil이 아닌 것들만 가지고 title을 정하고 , 나머지를 이어붙여 subtitle을 만든다
                        let title: String = ((now_item.oilCtg != nil ? now_item.oilCtg : now_item.idxNm) != nil ? now_item.idxNm : now_item.itmsNm) ?? "제목없음"
                        
                        
                        var subtitle: String = ""
                        [(now_item.idxCsf, ""), (now_item.prdCtg, "상품분류 : "), (now_item.mrktCtg, ""), (now_item.epyItmsCnt, "채용종목수 : "), (now_item.ytm, "만기수익률 : "), (now_item.cnvt, "채권지수 볼록성 : "), (now_item.trqu, "체결수량 총합 : "), (now_item.trPrc, "거래대금 총합 : "), (now_item.bssIdxIdxNm, "기초지수 명칭 : "), (now_item.udasAstNm, "기초자산 명칭 : "),  (now_item.strnCd, "코드 : "), (now_item.isinCd, "국제 식별번호 : ")].forEach {
                            if $0.0 != nil {
                                subtitle += $0.1 + $0.0! + " / "
                            }
                        }
                        subtitle.removeLast()
                        subtitle.removeLast()
                        subtitle.removeLast()
                        
                        return ( title, subtitle )
                    }
                    self.tableView.reloadData()
                }
                .resume()
    }
}



