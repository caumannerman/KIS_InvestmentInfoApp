//
//  HomeViewController.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/04/28.
//

import UIKit
import SwiftUI
import SnapKit

class HomeViewController: UIViewController {
     
    private var isMarket: Bool = true
    // ---------------------================= UI Components =================--------------------- //
    
 
    
    private lazy var market_url_view = UIView()
    private lazy var marketButton = UIButton()
    private lazy var urlSearchButton = UIButton()
    
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
    
    private lazy var marketView = MarketCollectionView(frame: .zero, collectionViewLayout: MarketCollectionViewLayout())
    
    private lazy var urlSearchView = UrlSearchView()
    // ---------------------===================================================--------------------- //
    
    @objc func didTapMarketButton(){
        print("didTap MarketButton")
        isMarket = true
        changeCategory(isMarket)
        changeUI_byCategory(isMarket)
        
        NotificationCenter.default.post(name:.market_url_changed, object: .none, userInfo: ["marketOrUrl": 0])
    }
    
    
    @objc func didTapUrlSearchButton(){
        print("didTap UrlSearchButton")
        isMarket = false
        changeCategory(isMarket)
        changeUI_byCategory(isMarket)
        NotificationCenter.default.post(name:.market_url_changed, object: .none, userInfo: ["marketOrUrl": 1])
        
    }
    
    private func changeCategory(_ isMarket: Bool){
        if isMarket{
            urlSearchButton.layer.borderWidth = 0
            marketButton.layer.borderWidth = 5
//            marketButton.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0)
            urlSearchButton.backgroundColor = .white
        }else {
            marketButton.layer.borderWidth = 0
            urlSearchButton.layer.borderWidth = 5
            marketButton.backgroundColor = .white
//            urlSearchButton.backgroundColor = UIColor(red: 214/255.0, green: 214/255.0, blue: 214/255.0, alpha: 1.0)
        }
    }
    private func changeUI_byCategory(_ isMarket: Bool){
        if isMarket{
            
            urlSearchView.snp.removeConstraints()
            
            self.view.addSubview(marketView)
            marketView.snp.makeConstraints{
                $0.top.equalTo(market_url_view.snp.bottom)
                $0.leading.trailing.equalToSuperview()
                $0.bottom.equalTo(view.safeAreaLayoutGuide)
            }
            
            
//            self.view.addSubview(hostingControllerUIView)
//            hostingControllerUIView.snp.makeConstraints{
//                $0.top.equalTo(market_url_view.snp.bottom)
//                $0.leading.trailing.equalToSuperview()
//                $0.bottom.equalTo(view.safeAreaLayoutGuide)
//            }
//            self.hostingControllerUIView.addSubview(self.marketInfoHostingController.view)
        }
        else {
      
//            hostingControllerUIView.snp.removeConstraints()
            
            marketView.snp.removeConstraints()
            
            self.view.addSubview(urlSearchView)
            urlSearchView.snp.makeConstraints{
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
       
        
        let isFT = isFirstTime()
        print(isFT)
        // 앱 실행이 처음이라면
        // Url관련 데이터들과 Home에 item을 추가하라는 cell을 추가해줘야한다.
        if isFT{
            UserDefaults.standard.set(DummyClass.getFirstUrl(), forKey: "urls")
            
            UserDefaults.standard.set(DummyClass.getFirstUrlAlias(), forKey: "urlAlias")
            
            UserDefaults.standard.set(DummyClass.getFirstUrlStarred(), forKey: "urlStarred")
            
            UserDefaults.standard.set(DummyClass.getFirstHomeItemTitle(), forKey: "homeItemTitle")

            UserDefaults.standard.set(DummyClass.getFirstHomeItemSubTitle(), forKey: "homeItemSubTitle")
            
            UserDefaults.standard.set(DummyClass.getFirstHomeItemSection(), forKey: "homeItemSection")
            
            UserDefaults.standard.set(DummyClass.getFirstHomeItemSubSection(), forKey: "homeItemSubSection")

           // isValid는 저장해둘 것이 아니라 그때그떄 네트워크로 정보를 받아 판단해야함
        }
        
        let scoms = UrlCommonState.getInstance()
        scoms.getDataFromUserDefaults()
        let hcoms = HomeContentsData.getInstance()
        hcoms.getDataFromUserDefaults()
        
        setNavigationItems()
        
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func isFirstTime() -> Bool {
        let defaults = UserDefaults.standard

        if defaults.object(forKey: "isFirstTime") == nil {
            defaults.set(false, forKey: "isFirstTime")
            return true
        } else {
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeCategory(isMarket)
        NotificationCenter.default.addObserver(self, selector: #selector(didTapUrlTVCell(_:)), name: .DidTapUrlTVCell, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didTapMarketInfoCell(_:)), name: .DidTapMarketInfoCell, object: nil)
        
    }
    
    @objc func didTapMarketInfoCell(_ notification: Notification){
        print("Notification DidTapMarketInfoCell")
        guard let now_dict = notification.userInfo as? Dictionary<String, Any> else { return }
        guard let now_title = now_dict["title"] as? String else {return}
        guard let now_subTitle = now_dict["subTitle"] as? String else {return}
        guard let now_section = now_dict["section"] as? Int else {return}
        guard let now_subSection = now_dict["subSection"] as? Int else {return}
        print(now_title, now_subTitle, now_section, now_subSection)
        
        
        let detail_vc = MarketInfoDetailViewController(title: now_title, subTitle: now_subTitle, section: now_section, subSection: now_subSection)
        self.navigationController?.isNavigationBarHidden = false
        detail_vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
  
        self.present(detail_vc, animated: true, completion: {print("새글!")})
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("HomeVC reload", terminator: " ")
        
    }
    @objc func didTapUrlTVCell(_ notification: Notification) {
        print("Notification DidTapUrlTVCell")
        guard let now_dict = notification.userInfo as? Dictionary<String, Any> else { return }
        guard let now_url = now_dict["url"] as? String else {return}
        print("지금 받아온 url", terminator: " ")
        print(now_url)        
        
        let vc = ShowDataViewController()
        vc.setup(apiUrl: now_url)
        vc.modalPresentationStyle = UIModalPresentationStyle.pageSheet
        
        self.present(vc, animated: true){
            print("present로 URL 검색결과 화면 띄움")
        }
    }
    
    private func setNavigationItems(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "KISFI"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTapRightBarButtonItem))
        rightBarButton.tintColor = .red
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func didTapRightBarButtonItem(){
        print("ll")
        let vc = ItemSelectionViewController()
//        now_navi.present(vc, animated: true, completion: {print("새글!")})
//        self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true){
            print("추가item 검색페이지 present")
        }
    }
    
    private func bind(){
        
    }
    private func attribute(){
        self.hostingControllerUIView.addSubview(self.marketInfoHostingController.view)
        
        market_url_view.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
        
        marketButton.backgroundColor = .white
        marketButton.setTitle("시장정보", for: .normal)
        marketButton.titleLabel?.font = .systemFont(ofSize: 34, weight: .bold)
        marketButton.setTitleColor(.black, for: .normal)
        marketButton.addTarget(self, action: #selector(didTapMarketButton), for: .touchUpInside)
        marketButton.layer.cornerRadius = 12.0
        marketButton.layer.borderWidth = 3.0
        marketButton.layer.borderColor = UIColor(red: 200/255, green: 220/255, blue: 250/255, alpha: 1.0).cgColor
        
        urlSearchButton.backgroundColor = .white
        urlSearchButton.setTitle("URL검색", for: .normal)
        urlSearchButton.titleLabel?.font = .systemFont(ofSize: 34, weight: .bold)
        urlSearchButton.setTitleColor(.black, for: .normal)
        urlSearchButton.addTarget(self, action: #selector(didTapUrlSearchButton), for: .touchUpInside)
        urlSearchButton.layer.cornerRadius = 12.0
        urlSearchButton.layer.borderWidth = 3.0
        urlSearchButton.layer.borderColor = UIColor(red: 200/255, green: 220/255, blue: 250/255, alpha: 1.0).cgColor
        
    }
    private func layout(){
        [ market_url_view, marketView].forEach{
            view.addSubview($0)
        }
        
        market_url_view.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        [marketButton, urlSearchButton].forEach{
            market_url_view.addSubview($0)
        }
        
        marketButton.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(10)
            $0.width.equalTo((UIScreen.main.bounds.width - 40) / 2 )
        }
        
        urlSearchButton.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(14)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.equalTo((UIScreen.main.bounds.width - 40) / 2 )
        }
        
        marketView.snp.makeConstraints{
            $0.top.equalTo(market_url_view.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("keyboard end")
        self.view.endEditing(true)
    }
    
    
}
