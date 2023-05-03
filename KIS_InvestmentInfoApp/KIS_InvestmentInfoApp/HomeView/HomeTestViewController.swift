//
//  HomeTestViewController.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/04/28.
//

import UIKit
import SwiftUI
import SnapKit

class HomeTestViewController: UIViewController {
     
    private var isMarket: Bool = true
//    private lazy var headerView: UIView = {
//        let hdv: UIView = UIView()
//        hdv.backgroundColor = .yellow
//        return hdv
//    }()
    
    private let urltestView = UrlTestView()
    
    // ---------------------================= UI Components =================--------------------- //
    
    
    private lazy var bannerView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30.0, weight: .bold)
        label.text = "이벤트 배너"
        
        view.addSubview(label)
        label.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        return view
    }()
    
    private lazy var market_url_view: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    private lazy var marketButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("시장정보", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 28, weight: .bold)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(didTapMarketButton), for: .touchUpInside)
        btn.layer.cornerRadius = 12.0
        btn.layer.borderWidth = 3.0
        btn.layer.borderColor = UIColor(red: 180/255.0, green: 120/255.0, blue: 184/255.0, alpha: 1.0).cgColor
        return btn
    }()
    
    private lazy var urlSearchButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("URL검색", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 28, weight: .bold)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(didTapUrlSearchButton), for: .touchUpInside)
        btn.layer.cornerRadius = 12.0
        btn.layer.borderWidth = 3.0
        btn.layer.borderColor = UIColor(red: 180/255.0, green: 120/255.0, blue: 184/255.0, alpha: 1.0).cgColor
        return btn
    }()
    
    
    private lazy var hostingControllerUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemMint
        return view
    }()
    
    private lazy var marketInfoHostingController: UIHostingController = {
        let swiftUIView = UIHostingController(rootView: MarketInfoView())
        
        if #available(iOS 16.0, *){
            swiftUIView.sizingOptions = .preferredContentSize
        } else {
            
        }
//        addChild(swiftUIView)
//        swiftUIView.view.translatesAutoresizingMaskIntoConstraints = false
        return swiftUIView
    }()
    // ---------------------===================================================--------------------- //
    
    @objc func didTapMarketButton(){
        print("didTap MarketButton")
        isMarket = true
        changeCategory(isMarket)
        changeUI_byCategory(isMarket)
    }
    
    @objc func didTapUrlSearchButton(){
        print("didTap UrlSearchButton")
        isMarket = false
        changeCategory(isMarket)
        changeUI_byCategory(isMarket)
    }
    
    private func changeCategory(_ isMarket: Bool){
        if isMarket{
            marketButton.backgroundColor = UIColor(red: 214/255.0, green: 150/255.0, blue: 136/255.0, alpha: 1.0)
            urlSearchButton.backgroundColor = .white
        }else {
            marketButton.backgroundColor = .white
            urlSearchButton.backgroundColor = UIColor(red: 214/255.0, green: 150/255.0, blue: 136/255.0, alpha: 1.0)
        }
    }
    private func changeUI_byCategory(_ isMarket: Bool){
        if isMarket{
            urltestView.snp.removeConstraints()
            self.view.addSubview(hostingControllerUIView)
            hostingControllerUIView.snp.makeConstraints{
                $0.top.equalTo(market_url_view.snp.bottom)
                $0.leading.trailing.equalToSuperview()
                $0.bottom.equalTo(view.safeAreaLayoutGuide)
            }
            self.hostingControllerUIView.addSubview(self.marketInfoHostingController.view)
        }
        else {
      
            hostingControllerUIView.snp.removeConstraints()
            self.view.addSubview(urltestView)
            urltestView.snp.makeConstraints{
                $0.top.equalTo(market_url_view.snp.bottom)
                $0.leading.trailing.equalToSuperview()
                $0.bottom.equalTo(view.safeAreaLayoutGuide)
            }
        }
    }
    // ---------------------==================== Rx Traits ====================--------------------- //

    
    
    // ---------------------===================================================--------------------- //
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setNavigationItems()
        changeCategory(isMarket)
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func setNavigationItems(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "KISFI"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(didTapRightBarButtonItem))
        rightBarButton.tintColor = .red
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func didTapRightBarButtonItem(){
        print("ll")
        let vc = HomeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
//        self.present(vc, animated: true){
//            print("URL페이지 present")
//        }
    }
    
    private func bind(){
        
    }
    private func attribute(){
        self.hostingControllerUIView.addSubview(self.marketInfoHostingController.view)
    }
    private func layout(){
        [ bannerView, market_url_view, hostingControllerUIView].forEach{
            view.addSubview($0)
        }
        
        bannerView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(90)
        }
        
        market_url_view.snp.makeConstraints{
            $0.top.equalTo(bannerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        [marketButton, urlSearchButton].forEach{
            market_url_view.addSubview($0)
        }
        
        marketButton.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(6)
            $0.leading.equalToSuperview().inset(10)
            $0.width.equalTo((UIScreen.main.bounds.width - 40) / 2 )
        }
        
        urlSearchButton.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(6)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.equalTo((UIScreen.main.bounds.width - 40) / 2 )
        }
//        headerView.snp.makeConstraints{
//            $0.top.equalTo(view.safeAreaLayoutGuide)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(60)
//        }
//
        
        hostingControllerUIView.snp.makeConstraints{
            $0.top.equalTo(market_url_view.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
}
