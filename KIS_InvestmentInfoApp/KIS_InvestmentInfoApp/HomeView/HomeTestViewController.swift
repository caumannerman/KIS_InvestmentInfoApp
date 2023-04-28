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

    
//    private lazy var headerView: UIView = {
//        let hdv: UIView = UIView()
//        hdv.backgroundColor = .yellow
//        return hdv
//    }()
    
    private lazy var bannerView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        return view
    }()
    
    
    private lazy var hostingControllerUIView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var marketInfoHostingController: UIHostingController = {
        let swiftUIView = UIHostingController(rootView: MarketInfoView())
        
        if #available(iOS 16.0, *){
            swiftUIView.sizingOptions = .preferredContentSize
        } else {
            
        }
        addChild(swiftUIView)
        swiftUIView.view.translatesAutoresizingMaskIntoConstraints = false
        return swiftUIView
    }()

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setNavigationItems()
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
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(didTapRightBarButtonItem))
        rightBarButton.tintColor = .red
        navigationItem.rightBarButtonItem = rightBarButton

    }
    @objc func didTapRightBarButtonItem(){
        print("ll")
        let vc = HomeViewController()
        self.present(vc, animated: true){
            print("URL페이지 present")
        }
    }
    
    private func bind(){
        
    }
    private func attribute(){
        self.hostingControllerUIView.addSubview(self.marketInfoHostingController.view)
    }
    private func layout(){
        [ bannerView, hostingControllerUIView].forEach{
            view.addSubview($0)
        }
        
        bannerView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
//        headerView.snp.makeConstraints{
//            $0.top.equalTo(view.safeAreaLayoutGuide)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(60)
//        }
//
        hostingControllerUIView.snp.makeConstraints{
            $0.top.equalTo(bannerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            
        }
    }
    
    
}
