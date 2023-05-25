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
        
        NotificationCenter.default.addObserver(self, selector: #selector(market_url_changed(_:)), name: .market_url_changed, object: nil)
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
    
    @objc func market_url_changed(_ notification: Notification){
        guard let now_dict = notification.userInfo as? Dictionary<String, Any> else { return }
        guard let now_idx = now_dict["marketOrUrl"] as? Int else { return }
       
        //시장정보를 클릭한 경우
        if now_idx == 0 {
            urlSearchTextFieldView.snp.updateConstraints{
                $0.height.equalTo(0)
            }
//            urlSearchTextFieldView.endEditing(true)
        }
        //URL검색을 클릭한 경우
        else {
            urlSearchTextFieldView.snp.updateConstraints{
                $0.height.equalTo(80)
            }
        }
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
   



}
