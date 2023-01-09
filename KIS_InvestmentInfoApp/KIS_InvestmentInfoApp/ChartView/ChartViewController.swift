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

class ChartViewController: UIViewController {
    
    var api_result: String = ""
    private var erData: [ExchangeRateCellData] = []
    
    
    // 원하는 기간의 주가정보를 받아와 저장할 배열
    private var securityDataArr: [SecurityDataCellData] = []
    
    var dataPoints: [String] = ["일","월", "화","수","목", "금","토"]
//    var dataEntries: [BarChartDataEntry] = []
    var dataArray: [Int] = [10, 5, 6, 13, 15, 8, 2]
    
  
    
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
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
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
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    let requestButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 3.0
        btn.layer.borderWidth = 2.0
        btn.layer.borderColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0).cgColor
        btn.backgroundColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0)
        btn.setTitle("조회", for: .normal)
//        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .semibold)
        btn.addTarget(self, action: #selector(reqButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    let showChartButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 3.0
        btn.layer.borderWidth = 2.0
        btn.layer.borderColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0).cgColor
        btn.backgroundColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0)
        btn.setTitle("Show Chart", for: .normal)
//        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .bold)
        btn.addTarget(self, action: #selector(showChartButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    let purchaseDateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.text = "매수 시점"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let purchaseDateTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
        tf.layer.cornerRadius = 12.0
        tf.backgroundColor = .systemBackground
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    let sellDateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.text = "매도 시점"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    let sellDateTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
        tf.layer.cornerRadius = 12.0
        tf.backgroundColor = .systemBackground
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    let profitLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.text = "이익 (원)"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    let profitTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
        tf.layer.cornerRadius = 12.0
        tf.backgroundColor = .systemBackground
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    let topProfitDateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.text = "최고 수익일"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    let topProfitDateTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
        tf.layer.cornerRadius = 12.0
        tf.backgroundColor = .systemBackground
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    let worstProfitDateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.text = "최저 수익일"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    let worstProfitDateTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
        tf.layer.cornerRadius = 12.0
        tf.backgroundColor = .systemBackground
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
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
    
    private var startDate: Date?
    private var endDate: Date?
    private var purchaseDate: Date?
    private var sellDate: Date?
    private var topProfitDate: Date?
    private var worstProfitDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
      
        setNavigationItems()
        //DatePicker 초기화
        setupStartDateDatePicker()
        setupEndDateDatePicker()
        setupPurchaseDateDatePicker()
        setupSellDateDatePicker()
        setupTopProfitDateDatePicker()
        setupWorstProfitDateDatePicker()
        
        attribute()
        layout()
    }
    
    private func setNavigationItems(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "투자전략 시뮬레이션"
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

//        requestAPI()
        requestAPI(itemName: itemNmTextField.text, startDate: startDate, endDate: endDate )
    }
    // 차트 SwiftUI ViewController present
    @objc func showChartButtonClicked(){
        print("차트 조회 버튼 클릭")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // SwiftUI View를 출력하려면 UIHostingController로 감싸서 띄워야한다.
            let hostingController = UIHostingController(rootView: SwiftUIChartView())
            if #available(iOS 16.0, *) {
                hostingController.sizingOptions = .preferredContentSize
            } else {
                // Fallback on earlier versions
            }
            hostingController.modalPresentationStyle = .popover
            self.present(hostingController, animated: true)
        }
//        requestAPI(itemCode: itemNmTextField.text ?? "nil", startDate: startDate, endDate: endDate )
    }
    
    private func attribute(){
        
    }
    
    private func layout(){
        [ scrollView].forEach {
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
        
        [ itemNmLabel, itemNmTextField, startDateLabel, startDateTextField, endDateLabel, endDateTextField, requestButton, showChartButton, purchaseDateLabel, purchaseDateTextField, sellDateLabel, sellDateTextField, profitLabel, profitTextField, topProfitDateLabel, topProfitDateTextField, worstProfitDateLabel, worstProfitDateTextField].forEach{
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
            $0.trailing.equalToSuperview().inset(40)
        }
        
        showChartButton.snp.makeConstraints{
//            $0.top.equalTo(endDateTextField.snp.bottom).offset(20)
            $0.leading.equalTo(itemNmLabel.snp.trailing).inset(40)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(40)
        }
        
        purchaseDateLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(34)
            $0.width.equalTo(80)
        }
        
        purchaseDateTextField.snp.makeConstraints{
            $0.leading.equalTo(itemNmLabel.snp.trailing).offset(10)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(20)
        }
        sellDateLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(34)
            $0.width.equalTo(80)
        }
        
        sellDateTextField.snp.makeConstraints{
            $0.leading.equalTo(itemNmLabel.snp.trailing).offset(10)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        profitLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(34)
            $0.width.equalTo(80)
        }
        
        profitTextField.snp.makeConstraints{
            $0.leading.equalTo(itemNmLabel.snp.trailing).offset(10)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        topProfitDateLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(34)
            $0.width.equalTo(80)
        }
        
        topProfitDateTextField.snp.makeConstraints{
            $0.leading.equalTo(itemNmLabel.snp.trailing).offset(10)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        worstProfitDateLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(34)
            $0.width.equalTo(80)
        }
        
        worstProfitDateTextField.snp.makeConstraints{
            $0.leading.equalTo(itemNmLabel.snp.trailing).offset(10)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}

extension ChartViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(textField.text ?? "lll")
    }
}


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
    
    private func setupPurchaseDateDatePicker(){
        //날짜만 나오게 ( 시간 제외 )
        self.purchaseDateDatePicker.datePickerMode = .date
        self.purchaseDateDatePicker.preferredDatePickerStyle = .inline
        //for에는 어떤 event가 일어났을 때 action에 정의한 메서드를 호출할 것인지
        // 첫 번째 parameter에는 target
        self.purchaseDateDatePicker.addTarget(
            self,
            action: #selector(purchaseDateDatePickerValueDidChange(_:) ),
            for: .valueChanged
        )
        //연-월-일 순으로 + 한글
        self.purchaseDateDatePicker.locale = Locale(identifier: "ko-KR")
        //dateTextField를 눌렀을 때, keyboard가 아닌 datePicker가 나오게 된다!
//        self.endDateTextField.inputView = self.endDateDatePicker
//        self.endDateTextField.inputView = self.startDateDatePicker
        self.purchaseDateTextField.inputView = self.purchaseDateDatePicker
//        self.sellDateTextField.inputView = self.startDateDatePicker
//        self.topProfitTextField.inputView = self.startDateDatePicker
//        self.worstProfitTextField.inputView = self.startDateDatePicker
    }
    @objc func purchaseDateDatePickerValueDidChange(_ datePicker: UIDatePicker){
        //날짜, text를 반환해주는 역할
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy 년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")

        self.purchaseDate = datePicker.date
        self.purchaseDateTextField.text = formatter.string(from: datePicker.date)
        // 다른 날짜를 선택해도,키보드로 텍스트를 입력받은 것이 아니기 때문에 dateTextFieldDidChange가 #selector에서 정상적으로 호출되지 않는다. 따라서 pick한 날짜가 변하면, .editingChanged 이벤트를 인위적으로 발생시켜준다.
        self.purchaseDateTextField.sendActions(for: .editingChanged)
    }
    private func setupSellDateDatePicker(){
        //날짜만 나오게 ( 시간 제외 )
        self.sellDateDatePicker.datePickerMode = .date
        self.sellDateDatePicker.preferredDatePickerStyle = .inline
        //for에는 어떤 event가 일어났을 때 action에 정의한 메서드를 호출할 것인지
        // 첫 번째 parameter에는 target
        self.sellDateDatePicker.addTarget(
            self,
            action: #selector(sellDateDatePickerValueDidChange(_:) ),
            for: .valueChanged
        )
        //연-월-일 순으로 + 한글
        self.sellDateDatePicker.locale = Locale(identifier: "ko-KR")
        //dateTextField를 눌렀을 때, keyboard가 아닌 datePicker가 나오게 된다!
//        self.endDateTextField.inputView = self.endDateDatePicker
//        self.endDateTextField.inputView = self.startDateDatePicker
//        self.purchaseDateTextField.inputView = self.purchaseDateDatePicker
        self.sellDateTextField.inputView = self.startDateDatePicker
//        self.topProfitTextField.inputView = self.startDateDatePicker
//        self.worstProfitTextField.inputView = self.startDateDatePicker
    }
    @objc func sellDateDatePickerValueDidChange(_ datePicker: UIDatePicker){
        //날짜, text를 반환해주는 역할
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy 년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")

        self.sellDate = datePicker.date
        self.sellDateTextField.text = formatter.string(from: datePicker.date)
        // 다른 날짜를 선택해도,키보드로 텍스트를 입력받은 것이 아니기 때문에 dateTextFieldDidChange가 #selector에서 정상적으로 호출되지 않는다. 따라서 pick한 날짜가 변하면, .editingChanged 이벤트를 인위적으로 발생시켜준다.
        self.sellDateTextField.sendActions(for: .editingChanged)
    }
    private func setupTopProfitDateDatePicker(){
        //날짜만 나오게 ( 시간 제외 )
        self.topProfitDateDatePicker.datePickerMode = .date
        self.topProfitDateDatePicker.preferredDatePickerStyle = .inline
        //for에는 어떤 event가 일어났을 때 action에 정의한 메서드를 호출할 것인지
        // 첫 번째 parameter에는 target
        self.topProfitDateDatePicker.addTarget(
            self,
            action: #selector(topProfitDateDatePickerValueDidChange(_:) ),
            for: .valueChanged
        )
        //연-월-일 순으로 + 한글
        self.topProfitDateDatePicker.locale = Locale(identifier: "ko-KR")
        //dateTextField를 눌렀을 때, keyboard가 아닌 datePicker가 나오게 된다!
//        self.endDateTextField.inputView = self.endDateDatePicker
//        self.endDateTextField.inputView = self.startDateDatePicker
        self.topProfitDateTextField.inputView = self.topProfitDateDatePicker
//        self.sellDateTextField.inputView = self.startDateDatePicker
//        self.topProfitTextField.inputView = self.startDateDatePicker
//        self.worstProfitTextField.inputView = self.startDateDatePicker
    }
    @objc func topProfitDateDatePickerValueDidChange(_ datePicker: UIDatePicker){
        //날짜, text를 반환해주는 역할
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy 년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")

        self.topProfitDate = datePicker.date
        self.topProfitDateTextField.text = formatter.string(from: datePicker.date)
        // 다른 날짜를 선택해도,키보드로 텍스트를 입력받은 것이 아니기 때문에 dateTextFieldDidChange가 #selector에서 정상적으로 호출되지 않는다. 따라서 pick한 날짜가 변하면, .editingChanged 이벤트를 인위적으로 발생시켜준다.
        self.topProfitDateTextField.sendActions(for: .editingChanged)
    }
    private func setupWorstProfitDateDatePicker(){
        //날짜만 나오게 ( 시간 제외 )
        self.worstProfitDateDatePicker.datePickerMode = .date
        self.worstProfitDateDatePicker.preferredDatePickerStyle = .inline
        //for에는 어떤 event가 일어났을 때 action에 정의한 메서드를 호출할 것인지
        // 첫 번째 parameter에는 target
        self.worstProfitDateDatePicker.addTarget(
            self,
            action: #selector(worstProfitDateDatePickerValueDidChange(_:) ),
            for: .valueChanged
        )
        //연-월-일 순으로 + 한글
        self.worstProfitDateDatePicker.locale = Locale(identifier: "ko-KR")
        //dateTextField를 눌렀을 때, keyboard가 아닌 datePicker가 나오게 된다!
//        self.endDateTextField.inputView = self.endDateDatePicker
//        self.endDateTextField.inputView = self.startDateDatePicker
        self.worstProfitDateTextField.inputView = self.worstProfitDateDatePicker
//        self.sellDateTextField.inputView = self.startDateDatePicker
//        self.topProfitTextField.inputView = self.startDateDatePicker
//        self.worstProfitTextField.inputView = self.startDateDatePicker
    }
    @objc func worstProfitDateDatePickerValueDidChange(_ datePicker: UIDatePicker){
        //날짜, text를 반환해주는 역할
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy 년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")

        self.worstProfitDate = datePicker.date
        self.worstProfitDateTextField.text = formatter.string(from: datePicker.date)
        // 다른 날짜를 선택해도,키보드로 텍스트를 입력받은 것이 아니기 때문에 dateTextFieldDidChange가 #selector에서 정상적으로 호출되지 않는다. 따라서 pick한 날짜가 변하면, .editingChanged 이벤트를 인위적으로 발생시켜준다.
        self.worstProfitDateTextField.sendActions(for: .editingChanged)
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
        }else{
            sDateText = formatter.string(from: startDate!)
            eDateText = formatter.string(from: endDate!)
        }
        
        if itemName == nil || itemName == ""{
            nowName = "한국금융지주"
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
                
                print("받아온 배열 (최종)")
                
                print(self.securityDataArr)
                //테이블 뷰 다시 그려줌
//                self.tableView.reloadData()
            }
            .resume()
    }
    
}
    
    
    
