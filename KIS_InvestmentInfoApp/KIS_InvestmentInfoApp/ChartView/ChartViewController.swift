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
    
    private var apiResultStr = ""
    // 이것이 json String을 이용해 최종적으로 얻은 배열이라고 생각하고 개발중
    private var jsonResultArr: [[String]] = [
    ["col이름1", "col이름2", "col이름3", "col이름4", "col이름5", "col이름6", "col이름7", "col이름8", "col이름9", "col이름10", "col이름11", "col이름12"],
    ["row1값1", "row1값2", "row1값3", "row1값4", "row1값5", "row1값6", "row1값7", "row1값8", "row1값9", "row1값10", "row1값11", "row1값12"],
    ["row2값1", "row2값2", "row2값3", "row2값4", "row1값5", "row1값6", "row1값7", "row1값8", "row1값9", "row1값10", "row1값11", "row1값12"],
    ["row3값1", "row3값2", "row3값3", "row3값4", "row1값5", "row1값6", "row1값7", "row1값8", "row1값9", "row1값10", "row1값11", "row1값12"],
    ["row4값1", "row4값2", "row4값3", "row4값4", "row1값5", "row1값6", "row1값7", "row1값8", "row1값9", "row1값10", "row1값11", "row1값12"],
    ["row5값1", "row5값2", "row5값3", "row5값4", "row1값5", "row1값6", "row1값7", "row1값8", "row1값9", "row1값10", "row1값11", "row1값12"],
    ["row6값1", "row6값2", "row6값3", "row6값4", "row1값5", "row1값6", "row1값7", "row1값8", "row1값9", "row1값10", "row1값11", "row1값12"],
    ["row7값1", "row7값2", "row7값3", "row7값4", "row1값5", "row1값6", "row1값7", "row1값8", "row1값9", "row1값10", "row1값11", "row1값12"],
    ["row8값1", "row8값2", "row8값3", "row8값4", "row1값5", "row1값6", "row1값7", "row1값8", "row1값9", "row1값10", "row1값11", "row1값12"],
    ["row9값1", "row9값2", "row9값3", "row9값4", "row1값5", "row1값6", "row1값7", "row1값8", "row1값9", "row1값10", "row1값11", "row1값12"],
    ["row10값1", "row10값2", "row10값3", "row10값4", "row10값5", "row10값6", "row10값7", "row10값8", "row10값9", "row10값10", "row10값11", "row10값12"],
    ["row11값1", "row11값2", "row11값3", "row11값4", "row11값5", "row11값6", "row11값7", "row11값8", "row11값9", "row11값10", "row11값11", "row11값12"],
    ["row12값1", "row12값2", "row12값3", "row12값4", "row12값5", "row12값6", "row12값7", "row12값8", "row12값9", "row12값10", "row12값11", "row12값12"],
    ["row13값1", "row13값2", "row13값3", "row13값4", "row13값5", "row13값6", "row13값7", "row13값8", "row13값9", "row13값10", "row13값11", "row13값12"],
    ["row14값1", "row14값2", "row14값3", "row14값4", "row14값5", "row14값6", "row14값7", "row14값8", "row14값9", "row14값10", "row14값11", "row14값12"],
    ["row15값1", "row15값2", "row15값3", "row15값4", "row15값5", "row15값6", "row15값7", "row15값8", "row15값9", "row15값10", "row15값11", "row15값12"],
    ["row16값1", "row16값2", "row16값3", "row16값4", "row16값5", "row16값6", "row16값7", "row16값8", "row16값9", "row16값10", "row16값11", "row16값12"],
    ["row17값1", "row17값2", "row17값3", "row17값4", "row17값5", "row17값6", "row17값7", "row17값8", "row17값9", "row17값10", "row17값11", "row17값12"],
    ["row18값1", "row18값2", "row18값3", "row18값4", "row18값5", "row18값6", "row18값7", "row18값8", "row18값9", "row18값10", "row18값11", "row18값12"],
    ["row19값1", "row19값2", "row19값3", "row19값4", "row19값5", "row19값6", "row19값7", "row19값8", "row19값9", "row19값10", "row19값11", "row19값12"],
    ["row20값1", "row20값2", "row10값3", "row20값4", "row20값5", "row20값6", "row20값7", "row20값8", "row20값9", "row20값10", "row20값11", "row20값12"],
    ]
    
    private var isClickedArr_row: [Bool] = [true, false, false, true, false, false, false, true, true, false, true, false, false, false, true, false, true, false, false, true]
    private var isClickedArr_col: [Bool] = [false, false,true, true, false, false, false, true, false, false, true, true, ]
    
    
    
    
    
    var api_result: String = ""
    
    // 원하는 기간의 주가정보를 받아와 저장할 배열
    private var securityDataArr: [SecurityDataCellData] = []
    
    // Identifiable 프로토콜을 따르는 [SecurityInfo] 배열, SwiftUI view로 넘겨줘야함
    private var securityInfoArr: [SecurityInfo] = []

//    private lazy var strategyPicker: UIPickerView = {
//        let pv = UIPickerView()
//        pv.frame = CGRect(x: 2000, y: 2000, width: 200, height: 200)
//        //숨겨놔야함
////        pv.isHidden = true
//        pv.delegate = self
//        pv.dataSource = self
//
//        return pv
//    }()
//    private let strategyList: [String] = ["5일 이평선 전략", "10일 이평선 전략", "20일 이평선 전략", "60일 이평선 전략"]
//    : UIPickerView = {
//        let myPicker = UIPickerView()
//
//
//        return myPicker
//    }()
    
//    var dataPoints: [String] = ["일","월", "화","수","목", "금","토"]
////    var dataEntries: [BarChartDataEntry] = []
//    var dataArray: [Int] = [10, 5, 6, 13, 15, 8, 2]
    
  
    
//    private var barGraphView = BarChartView()
//    var chartDataSet = BarChartDataSet()
//    var chartData = BarChartData()
    
//    let valFormatter = NumberFormatter()
    
//    var formatter = DefaultValueFormatter()
    
    // candleGraphView를 선언함
//    private var candleGraphView = CandleStickChartView()
//    var candleChartDataSet = CandleChartDataSet()
//    var candleChartData = CandleChartData()
    
    
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0.0
        return stackView
    }()
    
    // 그래프 이외의 Component들
    let itemNmLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.text = "종목명"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    let itemNmTextField: UITextField = {
        let tf = UITextField()
        
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
        tf.layer.cornerRadius = 12.0
        tf.backgroundColor = .systemBackground
        tf.placeholder = "종목명 입력"
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
//    // 매매법 전략을 선택할 UIPickerView를 연결할 곳
//    let strategyLabel: UILabel = {
//        let label = UILabel()
//        label.backgroundColor = .systemBackground
//        label.text = "이평선 매매전략"
//        label.font = UIFont.systemFont(ofSize: 14)
//        return label
//    }()
//
//    let strategyTextField: UITextField = {
//        let tf = UITextField()
//        tf.tag = 11
//        tf.layer.borderWidth = 2.0
//        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
//        tf.layer.cornerRadius = 12.0
//        tf.backgroundColor = .systemBackground
//        tf.placeholder = "이평선 매매전략 선택"
//        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
//        tf.leftView = paddingView
//        tf.leftViewMode = .always
//        return tf
//    }()
//
    // 그래프 이외의 Component들
    let startDateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.text = "차트조회 시작일"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
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
    let endDateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.text = "차트조회 종료일"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let endDateTextField: UITextField = {
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
    
    let requestButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 8.0
        btn.layer.borderWidth = 2.0
        btn.layer.borderColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0).cgColor
        btn.backgroundColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 244/255.0, alpha: 1.0)
        btn.setTitle("조회", for: .normal)
//        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .semibold)
        btn.addTarget(self, action: #selector(reqButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    let showChartButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 8.0
        btn.layer.borderWidth = 2.0
        btn.layer.borderColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0).cgColor
        btn.backgroundColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 244/255.0, alpha: 1.0)
        btn.setTitle("차트 보기", for: .normal)
//        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .bold)
        btn.addTarget(self, action: #selector(showChartButtonClicked), for: .touchUpInside)
        return btn
    }()
    
//    let purchaseDateLabel: UILabel = {
//        let label = UILabel()
//        label.backgroundColor = .systemBackground
//        label.text = "매수 시점"
//        label.font = UIFont.systemFont(ofSize: 14)
//        return label
//    }()
//
//    let purchaseDateTextField: UITextField = {
//        let tf = UITextField()
//        tf.layer.borderWidth = 2.0
//        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
//        tf.layer.cornerRadius = 12.0
//        tf.backgroundColor = .systemBackground
//        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
//        tf.leftView = paddingView
//        tf.leftViewMode = .always
//        return tf
//    }()
//
//    let sellDateLabel: UILabel = {
//        let label = UILabel()
//        label.backgroundColor = .systemBackground
//        label.text = "매도 시점"
//        label.font = UIFont.systemFont(ofSize: 14)
//        return label
//    }()
//    let sellDateTextField: UITextField = {
//        let tf = UITextField()
//        tf.layer.borderWidth = 2.0
//        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
//        tf.layer.cornerRadius = 12.0
//        tf.backgroundColor = .systemBackground
//        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
//        tf.leftView = paddingView
//        tf.leftViewMode = .always
//        return tf
//    }()
//
//    let profitLabel: UILabel = {
//        let label = UILabel()
//        label.backgroundColor = .systemBackground
//        label.text = "이익 (원)"
//        label.font = UIFont.systemFont(ofSize: 14)
//        return label
//    }()
//    let profitTextField: UITextField = {
//        let tf = UITextField()
//        tf.layer.borderWidth = 2.0
//        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
//        tf.layer.cornerRadius = 12.0
//        tf.backgroundColor = .systemBackground
//        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
//        tf.leftView = paddingView
//        tf.leftViewMode = .always
//        return tf
//    }()
//
//    let topProfitDateLabel: UILabel = {
//        let label = UILabel()
//        label.backgroundColor = .systemBackground
//        label.text = "최고 수익일"
//        label.font = UIFont.systemFont(ofSize: 14)
//        return label
//    }()
//    let topProfitDateTextField: UITextField = {
//        let tf = UITextField()
//        tf.layer.borderWidth = 2.0
//        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
//        tf.layer.cornerRadius = 12.0
//        tf.backgroundColor = .systemBackground
//        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
//        tf.leftView = paddingView
//        tf.leftViewMode = .always
//        return tf
//    }()
//
//    let worstProfitDateLabel: UILabel = {
//        let label = UILabel()
//        label.backgroundColor = .systemBackground
//        label.text = "최저 수익일"
//        label.font = UIFont.systemFont(ofSize: 14)
//        return label
//    }()
//    let worstProfitDateTextField: UITextField = {
//        let tf = UITextField()
//        tf.layer.borderWidth = 2.0
//        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
//        tf.layer.cornerRadius = 12.0
//        tf.backgroundColor = .systemBackground
//        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
//        tf.leftView = paddingView
//        tf.leftViewMode = .always
//        return tf
//    }()
    
//    private var jsonResultArr: [[String]] = [[]]
//    private var isClickedArr_row: [Bool] = []
//    private var isClickedArr_col: [Bool] = []
    //선택을 했는지 여부 동기화를 위한 배열
//    private var isClickedArr_row: [Bool] = Array(repeating: false, count: 20)
//    private var isClickedArr_col: [Bool] = Array(repeating: false, count: 12)
    

    
    // ----------------------------------------------------------------------------- 임시 --------------------------------------------------------------------------- //
    
    //JSon을 받아와 parsing한 뒤,
//    private var JsonRowCount: Int = 0
//    private var JsonColumnCount: Int = 0
    
   
   
    //TODO: dataTitles를 가져오는 api 항목에 맞게 따로 불러오는 기능 구현해야함
//    private var dataTitles: [String] = ["cur_unit", "ttb", "tts", "deal_bas_r", "bkpr", "yy_efee_r", "ten_dd_efee_r", "kftc_bkpr", "kftc_deal_bas_r", "cur_nm", "cur_unit", "ttb", "tts", "deal_bas_r", "bkpr", "yy_efee_r", "ten_dd_efee_r", "kftc_bkpr", "kftc_deal_bas_r", "cur_nm"]
//    private var erData: [ExchangeRateCellData] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = GridLayout()
        layout.cellHeight = 44
        layout.cellWidths = Array(repeating: CGFloat(120), count: jsonResultArr[0].count + 1)
        //layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
//        layout.minimumLineSpacing = 4
//        layout.minimumInteritemSpacing = 2
//        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.isDirectionalLockEnabled = true
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        collectionView.register(ShowDataViewCollectionViewCell.self, forCellWithReuseIdentifier: "ShowDataViewCollectionViewCell")
        collectionView.register(ShowDataViewCollectionViewCell.self, forCellWithReuseIdentifier: "ShowDataViewCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.backgroundColor = .systemBackground
        collectionView.layer.borderWidth = 1.0
        collectionView.layer.borderColor = UIColor.lightGray.cgColor
//        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    let blankView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemBackground
        return v
    }()
    
//    let tempTextView: UITextView = {
//        let tv = UITextView()
//        tv.layer.borderWidth = 1
//        tv.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
//        tv.layer.cornerRadius = 12.0
//
//        return tv
//    }()
    
    
    private let startDateDatePicker = UIDatePicker()
    private let endDateDatePicker = UIDatePicker()
    private let purchaseDateDatePicker = UIDatePicker()
    private let sellDateDatePicker = UIDatePicker()
    private let topProfitDateDatePicker = UIDatePicker()
    private let worstProfitDateDatePicker = UIDatePicker()
    
    // 차트 시작 전 입력받아야하는 것들 //
    private var securityName: String = ""
    private var strategyValye: String = ""
    private var startDate: Date?
    private var endDate: Date?
    // 차트 시작 전 입력받아야하는 것들 //
    
    private var purchaseDate: Date?
    private var sellDate: Date?
    private var topProfitDate: Date?
    private var worstProfitDate: Date?
    
    //PickerView를 종료하기 위한 콜백함수
    @objc func pickerExit(){
//        self.strategyTextField.text = nil
        self.view.endEditing(true)
    }
    
    @objc func pickerDone(){
        self.view.endEditing(true)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        itemNmTextField.tag = 1
        // strategyPicker를 꾸밈
//        let exitButton = UIBarButtonItem(title: "exit", style: .plain, target: self, action: #selector(pickerExit))
        let doneBT = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.pickerDone))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBT = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.pickerExit))
        
        let toolBar = UIToolbar()
        toolBar.tintColor = .systemBrown
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        toolBar.setItems([cancelBT,flexibleSpace,doneBT], animated: false)
        toolBar.isUserInteractionEnabled = true
        
//        strategyTextField.inputAccessoryView = toolBar
//        strategyTextField.inputView = strategyPicker
        
        setNavigationItems()
        //DatePicker 초기화
        setupStartDateDatePicker()
        setupEndDateDatePicker()
//        setupPurchaseDateDatePicker()
//        setupSellDateDatePicker()
//        setupTopProfitDateDatePicker()
//        setupWorstProfitDateDatePicker()
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.collectionView.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.isHidden = true
        
        
//        for i in 0...6 {
//            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(dataArray[i]))
//            dataEntries.append(dataEntry)
//        }
//
//        valFormatter.numberStyle = .currency
//        valFormatter.maximumFractionDigits = 2
//        valFormatter.currencySymbol = "$"
//
//        let format = NumberFormatter()
//        format.numberStyle = .none
//        formatter = DefaultValueFormatter(formatter: format)
//
//        chartDataSet = BarChartDataSet(entries:dataEntries, label: "그래프 값 명칭")
//        chartData = BarChartData(dataSet: chartDataSet)
//        chartData.setValueFormatter(formatter)
//        barGraphView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: valFormatter)
//        barGraphView.data = chartData
      
        
    }
    
    private func setNavigationItems(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "주가 정보"
        //TODO: title color
        
//        let searchController = UISearchController()
//        searchController.searchBar.placeholder = "요청 URL을 입력해주세요"
//        //화면 어두워지지 않도록 false 처리
//        searchController.obscuresBackgroundDuringPresentation = false
//        uiSc.searchBar.delegate = self
        
        // embed UISearchController
//        navigationItem.searchController = uiSc
    }
    @objc func reqButtonClicked(){
        print("조회 버튼 클릭")
        print(itemNmTextField.text ?? "nil")
        print(startDateTextField.text ?? "nil")
        print(endDateTextField.text ?? "nil")

   
        self.requestAPI(itemName: self.itemNmTextField.text, startDate: self.startDate, endDate: self.endDate)
        self.requestAPI2(itemName: self.itemNmTextField.text, startDate: self.startDate, endDate: self.endDate)

    }
    // 차트 SwiftUI ViewController present
    @objc func showChartButtonClicked(){
        print("차트 조회 버튼 클릭")
        //날짜정보 / 종목코드 / 종목명 / 상장시장명 / 시가 / 종가 / 최고가 / 최저가
        //Async 처리
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            print("정보 다 받아왔나?")
            print("차트 조회 버튼 클릭")
            // SwiftUI View를 출력하려면 UIHostingController로 감싸서 띄워야한다.
            let hostingController = UIHostingController(rootView: SwiftUIChartView(title: self.itemNmTextField.text ?? "종목 이름 오류", securityArr: self.securityInfoArr))
            if #available(iOS 16.0, *) {
                hostingController.sizingOptions = .preferredContentSize
            } else {
                // Fallback on earlier versions
            }
            hostingController.modalPresentationStyle = .popover
            self.present(hostingController, animated: true)
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            // SwiftUI View를 출력하려면 UIHostingController로 감싸서 띄워야한다.
//            let hostingController = UIHostingController(rootView: SwiftUIChartView(title: self.itemNmTextField.text ?? "종목 이름 오류", securityArr: self.securityInfoArr))
//            if #available(iOS 16.0, *) {
//                hostingController.sizingOptions = .preferredContentSize
//            } else {
//                // Fallback on earlier versions
//            }
//            hostingController.modalPresentationStyle = .popover
//            self.present(hostingController, animated: true)
//        }
//        requestAPI(itemCode: itemNmTextField.text ?? "nil", startDate: startDate, endDate: endDate )
    }
    
    private func attribute(){
        
    }
    
    private func layout(){
        [ scrollView ].forEach {
            view.addSubview($0)
        }
        
       
        scrollView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
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
        
        [ itemNmLabel, itemNmTextField, startDateLabel, startDateTextField, endDateLabel, endDateTextField, requestButton, collectionView, showChartButton, blankView].forEach{
//            view.addSubview($0)
            stackView.addArrangedSubview($0)
        }
//        barGraphView.snp.makeConstraints{
////            $0.top.equalTo(view.safeAreaLayoutGuide)
//            $0.top.equalToSuperview()
//            $0.leading.trailing.equalToSuperview().inset(20)
//            $0.height.equalTo(300)
//        }
//        candleGraphView.snp.makeConstraints{
//            $0.leading.trailing.equalToSuperview().inset(20)
//            $0.height.equalTo(300)
//        }
//
//        tempTextView.snp.makeConstraints{
////            $0.top.equalToSuperview()
//            $0.leading.trailing.equalToSuperview().inset(20)
//            $0.height.equalTo(100)
//        }
        
        
        
        itemNmLabel.snp.makeConstraints{
//            $0.top.equalTo(barGraphView.snp.bottom).offset(30)
//            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(34)
            $0.width.equalTo(80)
        }
        
        itemNmTextField.snp.makeConstraints{
//            $0.top.equalTo(itemNmLabel.snp.bottom).offset(30)
            $0.leading.equalTo(itemNmLabel.snp.trailing).offset(10)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(20)
        }
        
//        strategyLabel.snp.makeConstraints{
////            $0.top.equalTo(barGraphView.snp.bottom).offset(30)
////            $0.leading.equalToSuperview().inset(10)
//            $0.height.equalTo(34)
//            $0.width.equalTo(80)
//        }
//
//        strategyTextField.snp.makeConstraints{
////            $0.top.equalTo(itemNmLabel.snp.bottom).offset(30)
//            $0.leading.equalTo(itemNmLabel.snp.trailing).offset(10)
//            $0.height.equalTo(34)
//            $0.trailing.equalToSuperview().inset(20)
//        }
        
        startDateLabel.snp.makeConstraints{
//            $0.top.equalTo(tickerTextField.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(34)
            $0.width.equalTo(80)
        }
        
        startDateTextField.snp.makeConstraints{
//            $0.top.equalTo(tickerLabel2.snp.bottom).offset(30)
            $0.leading.equalTo(itemNmLabel.snp.trailing).offset(10)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        endDateLabel.snp.makeConstraints{
//            $0.top.equalTo(tickerTextField2.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(34)
            $0.width.equalTo(80)
        }
        
        endDateTextField.snp.makeConstraints{
//            $0.top.equalTo(tickerLabel3.snp.bottom).offset(30)
            $0.leading.equalTo(itemNmLabel.snp.trailing).offset(10)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        requestButton.snp.makeConstraints{
//            $0.top.equalTo(endDateTextField.snp.bottom).offset(20)
            $0.leading.equalTo(itemNmLabel.snp.trailing).inset(40)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        collectionView.snp.makeConstraints{
//            $0.top.equalTo(endDateTextField.snp.bottom).offset(20)
            $0.leading.equalTo(itemNmLabel.snp.trailing).inset(40)
            $0.height.equalTo(400)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        showChartButton.snp.makeConstraints{
//            $0.top.equalTo(endDateTextField.snp.bottom).offset(20)
            $0.leading.equalTo(itemNmLabel.snp.trailing).inset(40)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(20)
        }
        
//        purchaseDateLabel.snp.makeConstraints{
//            $0.leading.equalToSuperview().inset(10)
//            $0.height.equalTo(34)
//            $0.width.equalTo(80)
//        }
//
//        purchaseDateTextField.snp.makeConstraints{
//            $0.leading.equalTo(itemNmLabel.snp.trailing).offset(10)
//            $0.height.equalTo(34)
//            $0.trailing.equalToSuperview().inset(20)
//        }
//        sellDateLabel.snp.makeConstraints{
//            $0.leading.equalToSuperview().inset(10)
//            $0.height.equalTo(34)
//            $0.width.equalTo(80)
//        }
//
//        sellDateTextField.snp.makeConstraints{
//            $0.leading.equalTo(itemNmLabel.snp.trailing).offset(10)
//            $0.height.equalTo(34)
//            $0.trailing.equalToSuperview().inset(20)
//        }
//
//        profitLabel.snp.makeConstraints{
//            $0.leading.equalToSuperview().inset(10)
//            $0.height.equalTo(34)
//            $0.width.equalTo(80)
//        }
//
//        profitTextField.snp.makeConstraints{
//            $0.leading.equalTo(itemNmLabel.snp.trailing).offset(10)
//            $0.height.equalTo(34)
//            $0.trailing.equalToSuperview().inset(20)
//        }
//
//        topProfitDateLabel.snp.makeConstraints{
//            $0.leading.equalToSuperview().inset(10)
//            $0.height.equalTo(34)
//            $0.width.equalTo(80)
//        }
//
//        topProfitDateTextField.snp.makeConstraints{
//            $0.leading.equalTo(itemNmLabel.snp.trailing).offset(10)
//            $0.height.equalTo(34)
//            $0.trailing.equalToSuperview().inset(20)
//        }
//
//        worstProfitDateLabel.snp.makeConstraints{
//            $0.leading.equalToSuperview().inset(10)
//            $0.height.equalTo(34)
//            $0.width.equalTo(80)
//        }
//
//        worstProfitDateTextField.snp.makeConstraints{
//            $0.leading.equalTo(itemNmLabel.snp.trailing).offset(10)
//            $0.height.equalTo(34)
//            $0.trailing.equalToSuperview().inset(20)
//        }
        
        blankView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().offset(10)
            $0.height.equalTo(50)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension ChartViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(textField.tag)
    }
    
}

//extension ChartViewController: UIPickerViewDelegate, UIPickerViewDataSource{
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return strategyList.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return strategyList[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print("selece\(strategyList[row])")
//        self.strategyValye = strategyList[row]
//        strategyTextField.text = strategyList[row]
//    }
//}

// MARK: 여기는 DatePicker관련 4가지

extension ChartViewController{
    
    private func setupStartDateDatePicker(){
        //날짜만 나오게 ( 시간 제외 )
        self.startDateDatePicker.datePickerMode = .date
        self.startDateDatePicker.preferredDatePickerStyle = .inline
        //for에는 어떤 event가 일어났을 때 action에 정의한 메서드를 호출할 것인지
        // 첫 번째 parameter에는 target
        self.startDateDatePicker.addTarget(
            self,
            action: #selector(startDateDatePickerValueDidChange(_:) ),
            for: .valueChanged
        )
        //연-월-일 순으로 + 한글
        self.startDateDatePicker.locale = Locale(identifier: "ko-KR")
        //dateTextField를 눌렀을 때, keyboard가 아닌 datePicker가 나오게 된다!
        self.startDateTextField.inputView = self.startDateDatePicker
//        self.endDateTextField.inputView = self.startDateDatePicker
//        self.purchaseDateTextField.inputView = self.startDateDatePicker
//        self.sellDateTextField.inputView = self.startDateDatePicker
//        self.topProfitTextField.inputView = self.startDateDatePicker
//        self.worstProfitTextField.inputView = self.startDateDatePicker
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
        print(self.endDateTextField.isFocused)
    }
    
    private func setupEndDateDatePicker(){
        //날짜만 나오게 ( 시간 제외 )
        self.endDateDatePicker.datePickerMode = .date
        self.endDateDatePicker.preferredDatePickerStyle = .inline
        //for에는 어떤 event가 일어났을 때 action에 정의한 메서드를 호출할 것인지
        // 첫 번째 parameter에는 target
        self.endDateDatePicker.addTarget(
            self,
            action: #selector(endDateDatePickerValueDidChange(_:) ),
            for: .valueChanged
        )
        //연-월-일 순으로 + 한글
        self.endDateDatePicker.locale = Locale(identifier: "ko-KR")
        //dateTextField를 눌렀을 때, keyboard가 아닌 datePicker가 나오게 된다!
        self.endDateTextField.inputView = self.endDateDatePicker
//        self.endDateTextField.inputView = self.startDateDatePicker
//        self.purchaseDateTextField.inputView = self.startDateDatePicker
//        self.sellDateTextField.inputView = self.startDateDatePicker
//        self.topProfitTextField.inputView = self.startDateDatePicker
//        self.worstProfitTextField.inputView = self.startDateDatePicker
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
    }
    
//    private func setupPurchaseDateDatePicker(){
//        //날짜만 나오게 ( 시간 제외 )
//        self.purchaseDateDatePicker.datePickerMode = .date
//        self.purchaseDateDatePicker.preferredDatePickerStyle = .inline
//        //for에는 어떤 event가 일어났을 때 action에 정의한 메서드를 호출할 것인지
//        // 첫 번째 parameter에는 target
//        self.purchaseDateDatePicker.addTarget(
//            self,
//            action: #selector(purchaseDateDatePickerValueDidChange(_:) ),
//            for: .valueChanged
//        )
//        //연-월-일 순으로 + 한글
//        self.purchaseDateDatePicker.locale = Locale(identifier: "ko-KR")
//        //dateTextField를 눌렀을 때, keyboard가 아닌 datePicker가 나오게 된다!
////        self.endDateTextField.inputView = self.endDateDatePicker
////        self.endDateTextField.inputView = self.startDateDatePicker
//        self.purchaseDateTextField.inputView = self.purchaseDateDatePicker
////        self.sellDateTextField.inputView = self.startDateDatePicker
////        self.topProfitTextField.inputView = self.startDateDatePicker
////        self.worstProfitTextField.inputView = self.startDateDatePicker
//    }
//    @objc func purchaseDateDatePickerValueDidChange(_ datePicker: UIDatePicker){
//        //날짜, text를 반환해주는 역할
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy 년 MM월 dd일(EEEEE)"
//        formatter.locale = Locale(identifier: "ko_KR")
//
//        self.purchaseDate = datePicker.date
//        self.purchaseDateTextField.text = formatter.string(from: datePicker.date)
//        // 다른 날짜를 선택해도,키보드로 텍스트를 입력받은 것이 아니기 때문에 dateTextFieldDidChange가 #selector에서 정상적으로 호출되지 않는다. 따라서 pick한 날짜가 변하면, .editingChanged 이벤트를 인위적으로 발생시켜준다.
//        self.purchaseDateTextField.sendActions(for: .editingChanged)
//    }
//    private func setupSellDateDatePicker(){
//        //날짜만 나오게 ( 시간 제외 )
//        self.sellDateDatePicker.datePickerMode = .date
//        self.sellDateDatePicker.preferredDatePickerStyle = .inline
//        //for에는 어떤 event가 일어났을 때 action에 정의한 메서드를 호출할 것인지
//        // 첫 번째 parameter에는 target
//        self.sellDateDatePicker.addTarget(
//            self,
//            action: #selector(sellDateDatePickerValueDidChange(_:) ),
//            for: .valueChanged
//        )
//        //연-월-일 순으로 + 한글
//        self.sellDateDatePicker.locale = Locale(identifier: "ko-KR")
//        //dateTextField를 눌렀을 때, keyboard가 아닌 datePicker가 나오게 된다!
////        self.endDateTextField.inputView = self.endDateDatePicker
////        self.endDateTextField.inputView = self.startDateDatePicker
////        self.purchaseDateTextField.inputView = self.purchaseDateDatePicker
//        self.sellDateTextField.inputView = self.startDateDatePicker
////        self.topProfitTextField.inputView = self.startDateDatePicker
////        self.worstProfitTextField.inputView = self.startDateDatePicker
//    }
//    @objc func sellDateDatePickerValueDidChange(_ datePicker: UIDatePicker){
//        //날짜, text를 반환해주는 역할
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy 년 MM월 dd일(EEEEE)"
//        formatter.locale = Locale(identifier: "ko_KR")
//
//        self.sellDate = datePicker.date
//        self.sellDateTextField.text = formatter.string(from: datePicker.date)
//        // 다른 날짜를 선택해도,키보드로 텍스트를 입력받은 것이 아니기 때문에 dateTextFieldDidChange가 #selector에서 정상적으로 호출되지 않는다. 따라서 pick한 날짜가 변하면, .editingChanged 이벤트를 인위적으로 발생시켜준다.
//        self.sellDateTextField.sendActions(for: .editingChanged)
//    }
//    private func setupTopProfitDateDatePicker(){
//        //날짜만 나오게 ( 시간 제외 )
//        self.topProfitDateDatePicker.datePickerMode = .date
//        self.topProfitDateDatePicker.preferredDatePickerStyle = .inline
//        //for에는 어떤 event가 일어났을 때 action에 정의한 메서드를 호출할 것인지
//        // 첫 번째 parameter에는 target
//        self.topProfitDateDatePicker.addTarget(
//            self,
//            action: #selector(topProfitDateDatePickerValueDidChange(_:) ),
//            for: .valueChanged
//        )
//        //연-월-일 순으로 + 한글
//        self.topProfitDateDatePicker.locale = Locale(identifier: "ko-KR")
//        //dateTextField를 눌렀을 때, keyboard가 아닌 datePicker가 나오게 된다!
////        self.endDateTextField.inputView = self.endDateDatePicker
////        self.endDateTextField.inputView = self.startDateDatePicker
//        self.topProfitDateTextField.inputView = self.topProfitDateDatePicker
////        self.sellDateTextField.inputView = self.startDateDatePicker
////        self.topProfitTextField.inputView = self.startDateDatePicker
////        self.worstProfitTextField.inputView = self.startDateDatePicker
//    }
//    @objc func topProfitDateDatePickerValueDidChange(_ datePicker: UIDatePicker){
//        //날짜, text를 반환해주는 역할
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy 년 MM월 dd일(EEEEE)"
//        formatter.locale = Locale(identifier: "ko_KR")
//
//        self.topProfitDate = datePicker.date
//        self.topProfitDateTextField.text = formatter.string(from: datePicker.date)
//        // 다른 날짜를 선택해도,키보드로 텍스트를 입력받은 것이 아니기 때문에 dateTextFieldDidChange가 #selector에서 정상적으로 호출되지 않는다. 따라서 pick한 날짜가 변하면, .editingChanged 이벤트를 인위적으로 발생시켜준다.
//        self.topProfitDateTextField.sendActions(for: .editingChanged)
//    }
//    private func setupWorstProfitDateDatePicker(){
//        //날짜만 나오게 ( 시간 제외 )
//        self.worstProfitDateDatePicker.datePickerMode = .date
//        self.worstProfitDateDatePicker.preferredDatePickerStyle = .inline
//        //for에는 어떤 event가 일어났을 때 action에 정의한 메서드를 호출할 것인지
//        // 첫 번째 parameter에는 target
//        self.worstProfitDateDatePicker.addTarget(
//            self,
//            action: #selector(worstProfitDateDatePickerValueDidChange(_:) ),
//            for: .valueChanged
//        )
//        //연-월-일 순으로 + 한글
//        self.worstProfitDateDatePicker.locale = Locale(identifier: "ko-KR")
//        //dateTextField를 눌렀을 때, keyboard가 아닌 datePicker가 나오게 된다!
////        self.endDateTextField.inputView = self.endDateDatePicker
////        self.endDateTextField.inputView = self.startDateDatePicker
//        self.worstProfitDateTextField.inputView = self.worstProfitDateDatePicker
////        self.sellDateTextField.inputView = self.startDateDatePicker
////        self.topProfitTextField.inputView = self.startDateDatePicker
////        self.worstProfitTextField.inputView = self.startDateDatePicker
//    }
//    @objc func worstProfitDateDatePickerValueDidChange(_ datePicker: UIDatePicker){
//        //날짜, text를 반환해주는 역할
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy 년 MM월 dd일(EEEEE)"
//        formatter.locale = Locale(identifier: "ko_KR")
//
//        self.worstProfitDate = datePicker.date
//        self.worstProfitDateTextField.text = formatter.string(from: datePicker.date)
//        // 다른 날짜를 선택해도,키보드로 텍스트를 입력받은 것이 아니기 때문에 dateTextFieldDidChange가 #selector에서 정상적으로 호출되지 않는다. 따라서 pick한 날짜가 변하면, .editingChanged 이벤트를 인위적으로 발생시켜준다.
//        self.worstProfitDateTextField.sendActions(for: .editingChanged)
//    }
}

extension ChartViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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

extension ChartViewController{
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
        
        let newnewurl = "http://apis.data.go.kr/1160100/service/GetStockSecuritiesInfoService/getStockPriceInfo" + "?numOfRows=365&resultType=json&serviceKey=58gH4iQz85Z0SMkhvh%2Fc7ZdxJ874fTSCDdyGoEI61Wzs9DiSzrhtZTWxEhKxwQjwsdF%2BUvPnWc6ZUKwgLc56xA%3D%3D&itmsNm=" + nowName + "&beginBasDt=" + sDateText + "&endBasDt=" + eDateText
        
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
                print("받아온 배열 (최종)")
                
                print(self.securityDataArr)
                //테이블 뷰 다시 그려줌
//                self.tableView.reloadData()
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
        
        let newnewurl = "http://apis.data.go.kr/1160100/service/GetStockSecuritiesInfoService/getStockPriceInfo" + "?numOfRows=365&resultType=json&serviceKey=58gH4iQz85Z0SMkhvh%2Fc7ZdxJ874fTSCDdyGoEI61Wzs9DiSzrhtZTWxEhKxwQjwsdF%2BUvPnWc6ZUKwgLc56xA%3D%3D&itmsNm=" + nowName + "&beginBasDt=" + sDateText + "&endBasDt=" + eDateText
        
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
}
    
    
    
