//
//  ChartViewController.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/02.
//

import UIKit
import Charts

class ChartViewController: UIViewController {

    private let myBarChartView = BarChartView()
    
    var dayData: [String] = ["11/2", "11/3", "11/4", "11/5", "11/6", "11/7", "11/8", "11/9", "11/10"]
    var priceData: [Double] = [100, 345, 20, 120, 90, 300, 450, 220, 120]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        self.myBarChartView.noDataText = "출력 데이터가 없습니다."
        self.myBarChartView.noDataTextColor = .lightGray
        self.myBarChartView.backgroundColor = .white
        
        self.myBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dayData)
        self.myBarChartView.xAxis.setLabelCount(priceData.count, force: false)
        
    }


}

