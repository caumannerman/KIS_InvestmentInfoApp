//
//  ChartViewController.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/02.
//

import UIKit
import Charts
import SnapKit


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
    let tickerTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
        tf.layer.cornerRadius = 12.0
        tf.backgroundColor = .systemBackground
        return tf
    }()
    
    // 그래프 이외의 Component들
    let tickerLabel2: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.text = "차트조회 시작일"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    let tickerTextField2: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
        tf.layer.cornerRadius = 12.0
        tf.backgroundColor = .systemBackground
        return tf
    }()
    
    // 그래프 이외의 Component들
    let tickerLabel3: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.text = "차트조회 종료일"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    let tickerTextField3: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
        tf.layer.cornerRadius = 12.0
        tf.backgroundColor = .systemBackground
        return tf
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
        return tf
    }()
    
    let topProfitLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.text = "최고 수익일"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    let topProfitTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
        tf.layer.cornerRadius = 12.0
        tf.backgroundColor = .systemBackground
        return tf
    }()
    
    let worstProfitLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.text = "최저 수익일"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    let worstProfitTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
        tf.layer.cornerRadius = 12.0
        tf.backgroundColor = .systemBackground
        return tf
    }()
    
    
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
        
        [ barGraphView, itemNmLabel, tickerTextField, tickerLabel2, tickerTextField2, tickerLabel3, tickerTextField3, purchaseDateLabel, purchaseDateTextField, sellDateLabel, sellDateTextField, profitLabel, profitTextField, topProfitLabel, topProfitTextField, worstProfitLabel, worstProfitTextField].forEach{
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
        
        tickerTextField.snp.makeConstraints{
//            $0.top.equalTo(itemNmLabel.snp.bottom).offset(30)
            $0.leading.equalTo(itemNmLabel.snp.trailing).offset(10)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        tickerLabel2.snp.makeConstraints{
//            $0.top.equalTo(tickerTextField.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(34)
            $0.width.equalTo(80)
        }
        
        tickerTextField2.snp.makeConstraints{
//            $0.top.equalTo(tickerLabel2.snp.bottom).offset(30)
            $0.leading.equalTo(itemNmLabel.snp.trailing).offset(10)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        tickerLabel3.snp.makeConstraints{
//            $0.top.equalTo(tickerTextField2.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(34)
            $0.width.equalTo(80)
        }
        
        tickerTextField3.snp.makeConstraints{
//            $0.top.equalTo(tickerLabel3.snp.bottom).offset(30)
            $0.leading.equalTo(itemNmLabel.snp.trailing).offset(10)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(20)
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
        
        topProfitLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(34)
            $0.width.equalTo(80)
        }
        
        topProfitTextField.snp.makeConstraints{
            $0.leading.equalTo(itemNmLabel.snp.trailing).offset(10)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        worstProfitLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(34)
            $0.width.equalTo(80)
        }
        
        worstProfitTextField.snp.makeConstraints{
            $0.leading.equalTo(itemNmLabel.snp.trailing).offset(10)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
