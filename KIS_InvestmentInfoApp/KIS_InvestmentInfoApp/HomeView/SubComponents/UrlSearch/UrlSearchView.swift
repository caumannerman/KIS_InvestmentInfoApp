//
//  UrlSearchView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/04/28.
//

import UIKit
import SnapKit


class UrlSearchView: UIView {


    private let alert = UIAlertController(title: "api별칭 입력", message: "별칭을 입력해주세요", preferredStyle: .alert)
    private var ok = UIAlertAction()
    
    private let urlSearchTextFieldView = UrlSearchTextFieldView()
    private let urlSearchTableView = UrlSearchTableView()

  
    override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(DidChangeUrlStarInSettings(_:)), name: .DidChangeUrlStarInSettings, object: nil)
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func DidChangeUrlStarInSettings(_ notification: Notification){
        print("UrlSearchView reload됨")
        urlSearchTableView.reloadData()
    }
    
    private func attribute(){
        self.backgroundColor = .white
        urlSearchTableView.backgroundColor = UIColor(red: 200/255, green: 220/255, blue: 250/255, alpha: 1.0)
    }
    
    
    private func layout(){
        [urlSearchTextFieldView, urlSearchTableView].forEach{
            addSubview($0)
        }
        
        urlSearchTextFieldView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        urlSearchTableView.snp.makeConstraints{
            $0.top.equalTo(urlSearchTextFieldView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
   



}
