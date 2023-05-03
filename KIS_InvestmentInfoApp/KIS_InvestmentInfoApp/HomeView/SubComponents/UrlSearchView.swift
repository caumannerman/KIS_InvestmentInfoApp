//
//  UrlSearchView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/04/28.
//

import UIKit
import SnapKit


class UrlSearchView: UIView {

    // urlsAlias와 urlsArr은 갯수를 항상 동일하게맞추어야한다.
    private var urlsAlias: [String] = []
    //검색했던 URL들을 담을 배열
    private var urlsArr: [String] = []

    private let alert = UIAlertController(title: "api별칭 입력", message: "별칭을 입력해주세요", preferredStyle: .alert)
    private var ok = UIAlertAction()
    
    private let urlSearchTextFieldView = UrlSearchTextFieldView()
    private let urlSearchTableView = UrlSearchTableView()
    
    
    
    

//    private lazy var urlTableView: UITableView = {
//        let tableView = UITableView()
//        tableView.dataSource = self
//        tableView.delegate = self
////        tableView.backgroundColor = UIColor(red: 223/255.0, green: 156/255.0, blue: 50/255.0, alpha: 1.0)
//        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "splash")!)
//        return tableView
//
//    }()
  



    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
    
    private func attribute(){
        self.backgroundColor = .darkGray
        
        
        
        urlSearchTableView.backgroundColor = .green
    }
    
    private func layout(){
        [urlSearchTextFieldView, urlSearchTableView].forEach{
            addSubview($0)
        }
        
        urlSearchTextFieldView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        urlSearchTableView.snp.makeConstraints{
            $0.top.equalTo(urlSearchTextFieldView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
   



}
