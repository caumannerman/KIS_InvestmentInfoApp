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


class ChartViewController: UIViewController {
    
    private var barGraphView = BarChartView()
    
    var dataPoints: [String] = ["일","월", "화","수","목", "금","토"]
    var dataEntries: [BarChartDataEntry] = []
    var dataArray: [Int] = [10, 5, 6, 13, 15, 8, 2]
    
    let valFormatter = NumberFormatter()
    
    var formatter = DefaultValueFormatter()
    
    var chartDataSet = BarChartDataSet()
    var chartData = BarChartData()
    
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
        
        for i in 0...6 {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(dataArray[i]))
            dataEntries.append(dataEntry)
        }
        
        
        valFormatter.numberStyle = .currency
        valFormatter.maximumFractionDigits = 2
        valFormatter.currencySymbol = "$"
                
        let format = NumberFormatter()
        format.numberStyle = .none
        formatter = DefaultValueFormatter(formatter: format)
        
        chartDataSet = BarChartDataSet(entries:dataEntries, label: "그래프 값 명칭")
        chartData = BarChartData(dataSet: chartDataSet)
        chartData.setValueFormatter(formatter)
        barGraphView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: valFormatter)
                
                
        barGraphView.data = chartData
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
        requestAPI(itemName: itemNmTextField.text ?? "nil", startDate: startDateTextField.text ?? "nil", endDate: endDateTextField.text ?? "nil" )
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
        
        [ barGraphView, itemNmLabel, itemNmTextField, startDateLabel, startDateTextField, endDateLabel, endDateTextField, requestButton, purchaseDateLabel, purchaseDateTextField, sellDateLabel, sellDateTextField, profitLabel, profitTextField, topProfitDateLabel, topProfitDateTextField, worstProfitDateLabel, worstProfitDateTextField].forEach{
//            view.addSubview($0)
            stackView.addArrangedSubview($0)
        }
        barGraphView.snp.makeConstraints{
//            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(300)
        }
        
        
        
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
    private func requestAPI(itemName: String, startDate: String, endDate: String){
        let url = "apis.data.go.kr/1160100/service/GetStockSecuritiesInfoService/getStockPriceInfo?resultType=json&serviceKey=58gH4iQz85Z0SMkhvh%2Fc7ZdxJ874fTSCDdyGoEI61Wzs9DiSzrhtZTWxEhKxwQjwsdF%2BUvPnWc6ZUKwgLc56xA%3D%3D&itmsNm=" + itemName.trimmingCharacters(in: .whitespaces) + "&beginBasDt=" + startDate + "&endBasDt=" + endDate
        print(url)
        return
        //addingPercentEncoding은 한글(영어 이외의 값) 이 url에 포함되었을 때 오류나는 것을 막아준다.
        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: [ExchangeRate].self){ [weak self] response in
                // success 이외의 응답을 받으면, else문에 걸려 함수 종료
                guard
                    let self = self,
                    case .success(let data) = response.result else { return }
                //데이터 받아옴
                self.erData = data.map{ er -> ExchangeRateCellData in
                    let temp = ExchangeRateCellData(cur_unit: er.cur_unit, ttb: er.ttb, tts: er.tts, deal_bas_r: er.deal_bas_r, bkpr: er.bkpr, yy_efee_r: er.yy_efee_r, ten_dd_efee_r: er.ten_dd_efee_r, kftc_bkpr: er.kftc_bkpr, kftc_deal_bas_r: er.kftc_deal_bas_r, cur_nm: er.cur_nm)
                    return temp
                }
                //테이블 뷰 다시 그려줌
                self.tableView.reloadData()
            }
            .resume()
    }
}


//class CandleStickChartViewController: DemoBaseViewController {
//
//    @IBOutlet var chartView: CandleStickChartView!
//    @IBOutlet var sliderX: UISlider!
//    @IBOutlet var sliderY: UISlider!
//    @IBOutlet var sliderTextX: UITextField!
//    @IBOutlet var sliderTextY: UITextField!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        self.title = "Candle Stick Chart"
//        self.options = [.toggleValues,
//                        .toggleIcons,
//                        .toggleHighlight,
//                        .animateX,
//                        .animateY,
//                        .animateXY,
//                        .saveToGallery,
//                        .togglePinchZoom,
//                        .toggleAutoScaleMinMax,
//                        .toggleShadowColorSameAsCandle,
//                        .toggleShowCandleBar,
//                        .toggleData]
//
//        chartView.delegate = self
//
//        chartView.chartDescription.enabled = false
//
//        chartView.dragEnabled = false
//        chartView.setScaleEnabled(true)
//        chartView.maxVisibleCount = 200
//        chartView.pinchZoomEnabled = true
//
//        chartView.legend.horizontalAlignment = .right
//        chartView.legend.verticalAlignment = .top
//        chartView.legend.orientation = .vertical
//        chartView.legend.drawInside = false
//        chartView.legend.font = UIFont(name: "HelveticaNeue-Light", size: 10)!
//
//        chartView.leftAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!
//        chartView.leftAxis.spaceTop = 0.3
//        chartView.leftAxis.spaceBottom = 0.3
//        chartView.leftAxis.axisMinimum = 0
//
//        chartView.rightAxis.enabled = false
//
//        chartView.xAxis.labelPosition = .bottom
//        chartView.xAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!
//
//        sliderX.value = 10
//        sliderY.value = 50
//        slidersValueChanged(nil)
//    }
//
//    override func updateChartData() {
//        if self.shouldHideData {
//            chartView.data = nil
//            return
//        }
//
//        self.setDataCount(Int(sliderX.value), range: UInt32(sliderY.value))
//    }
//
//    func setDataCount(_ count: Int, range: UInt32) {
//        let yVals1 = (0..<count).map { (i) -> CandleChartDataEntry in
//            let mult = range + 1
//            let val = Double(arc4random_uniform(40) + mult)
//            let high = Double(arc4random_uniform(9) + 8)
//            let low = Double(arc4random_uniform(9) + 8)
//            let open = Double(arc4random_uniform(6) + 1)
//            let close = Double(arc4random_uniform(6) + 1)
//            let even = i % 2 == 0
//
//            return CandleChartDataEntry(x: Double(i), shadowH: val + high, shadowL: val - low, open: even ? val + open : val - open, close: even ? val - close : val + close, icon: UIImage(named: "icon")!)
//        }
//
//        let set1 = CandleChartDataSet(entries: yVals1, label: "Data Set")
//        set1.axisDependency = .left
//        set1.setColor(UIColor(white: 80/255, alpha: 1))
//        set1.drawIconsEnabled = false
//        set1.shadowColor = .darkGray
//        set1.shadowWidth = 0.7
//        set1.decreasingColor = .red
//        set1.decreasingFilled = true
//        set1.increasingColor = UIColor(red: 122/255, green: 242/255, blue: 84/255, alpha: 1)
//        set1.increasingFilled = false
//        set1.neutralColor = .blue
//
//        let data = CandleChartData(dataSet: set1)
//        chartView.data = data
//    }
//
//    override func optionTapped(_ option: Option) {
//        switch option {
//        case .toggleShadowColorSameAsCandle:
//            for case let set as CandleChartDataSet in chartView.data! {
//                set.shadowColorSameAsCandle = !set.shadowColorSameAsCandle
//            }
//            chartView.notifyDataSetChanged()
//        case .toggleShowCandleBar:
//            for set in chartView.data!.dataSets as! [CandleChartDataSet] {
//                set.showCandleBar = !set.showCandleBar
//            }
//            chartView.notifyDataSetChanged()
//        default:
//            super.handleOption(option, forChartView: chartView)
//        }
//    }
//
//    // MARK: - Actions
//    @IBAction func slidersValueChanged(_ sender: Any?) {
//        sliderTextX.text = "\(Int(sliderX.value))"
//        sliderTextY.text = "\(Int(sliderY.value))"
//
//        self.updateChartData()
//    }}
