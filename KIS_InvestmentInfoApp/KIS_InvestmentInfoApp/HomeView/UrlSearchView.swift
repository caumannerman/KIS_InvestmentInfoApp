//
//  UrlSearchView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/04/28.
//

import UIKit

class UrlSearchView: UIView {

    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "URL 검색 창"
        label.font = .systemFont(ofSize: 48, weight: .bold)
        label
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .darkGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
