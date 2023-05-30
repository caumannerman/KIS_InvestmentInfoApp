//
//  MarketInfoDetailViewController.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/15.
//

import UIKit
import SnapKit
import SwiftUI
import Charts

class MarketInfoDetailViewController: UIViewController {
    
    private let alphaView: UIButton = UIButton()
    
    private let restView: UIView = UIView()
    
    
    private lazy var marketInfoHostingController1: UIHostingController = {
        
        let hostingController = UIHostingController( rootView: TradingChartView(dailyData: [100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2], weeklyData: [100.0, 105.2,101.0, 105.2,100.0, 105.2,100.0, 105.2,100.0, 105.2, 0, 0, 0], monthlyData: [110.0, 115.2,111.0, 115.2,110.0, 125.2,120.0, 125.2,120.0, 125.2], startDate: Date(), endDate: Date() ) )
        
        if #available(iOS 16.0, *) {
            hostingController.sizingOptions = .preferredContentSize
        } else {
            // Fallback on earlier versions
        }
//        hostingController.modalPresentationStyle = .popover
//        self.present(hostingController, animated: true)
//        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        return hostingController
    }()
    
    private let marketInfoHostingController2 = UIHostingController(rootView: MarketInfoView())
    private let marketInfoHostingController3 = UIHostingController(rootView: MarketInfoView())
    private let marketInfoHostingController4 = UIHostingController(rootView: MarketInfoView())
    private let marketInfoHostingController5 = UIHostingController(rootView: MarketInfoView())
    private let marketInfoHostingController6 = UIHostingController(rootView: MarketInfoView())
    
    init(title: String, subTitle: String, section: Int, subSection: Int){
        super.init(nibName: nil, bundle: nil)
        attribute()
        layout()
        print(title, subTitle, section, subSection)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("원래 생성자")
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.0)
    }
    
    func attribute(){
        
        alphaView.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.1)
        alphaView.addTarget(self, action: #selector(backTo), for: .touchUpInside)
        
        restView.backgroundColor = UIColor(red: 200/255, green: 220/255, blue: 250/255, alpha: 0.7)
        
        [ marketInfoHostingController1, marketInfoHostingController2, marketInfoHostingController3, marketInfoHostingController4, marketInfoHostingController5, marketInfoHostingController6].forEach{
//            $0.sizingOptions = .preferredContentSize
            $0.view.layer.borderWidth = 2.0
            $0.view.layer.borderColor = UIColor.black.cgColor
            $0.view.layer.cornerRadius = 10
        }
       
        
    }
    
    @objc func backTo(){
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func layout(){
        [alphaView, restView].forEach{
            view.addSubview($0)
        }
        
        alphaView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.height / 6)
            
        }
        restView.snp.makeConstraints{
            $0.top.equalTo(alphaView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        [marketInfoHostingController1, marketInfoHostingController2, marketInfoHostingController3, marketInfoHostingController4, marketInfoHostingController5, marketInfoHostingController6].forEach{
            restView.addSubview($0.view)
        }
       
        marketInfoHostingController1.view.snp.makeConstraints{
            $0.top.leading.equalToSuperview().inset(10)
            $0.width.equalTo((UIScreen.main.bounds.width - 30 ) / 2)
            $0.height.equalTo(UIScreen.main.bounds.height / 4)
        }
        
        marketInfoHostingController2.view.snp.makeConstraints{
            $0.top.trailing.equalToSuperview().inset(10)
            $0.width.equalTo((UIScreen.main.bounds.width - 30 ) / 2)
            $0.height.equalTo(UIScreen.main.bounds.height / 4)
        }
        
        marketInfoHostingController3.view.snp.makeConstraints{
            $0.top.equalTo(marketInfoHostingController1.view.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.width.equalTo((UIScreen.main.bounds.width - 30 ) / 2)
            $0.height.equalTo(UIScreen.main.bounds.height / 4)
        }
        
        marketInfoHostingController4.view.snp.makeConstraints{
            $0.top.equalTo(marketInfoHostingController2.view.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(10)
            
            $0.width.equalTo((UIScreen.main.bounds.width - 30 ) / 2)
            $0.height.equalTo(UIScreen.main.bounds.height / 4)
        }
        
        marketInfoHostingController5.view.snp.makeConstraints{
            $0.top.equalTo(marketInfoHostingController3.view.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.width.equalTo((UIScreen.main.bounds.width - 30 ) / 2)
            $0.height.equalTo(UIScreen.main.bounds.height / 4)
        }
        
        marketInfoHostingController6.view.snp.makeConstraints{
            $0.top.equalTo(marketInfoHostingController4.view.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.equalTo((UIScreen.main.bounds.width - 30 ) / 2)
            $0.height.equalTo(UIScreen.main.bounds.height / 4)
        }

    }
}
