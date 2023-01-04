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
        
        layout()
    }
    
    func layout(){
        [barGraphView].forEach{
            view.addSubview($0)
        }
        barGraphView.snp.makeConstraints{
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(100)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
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
