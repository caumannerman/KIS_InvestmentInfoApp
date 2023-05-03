//
//  UrlSearchTextFieldView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/03.
//

import UIKit
import SnapKit

// Url검색을 위해 커스텀 검색창 생성
class UrlSearchTextFieldView: UIView {
    
    private let urlSearchTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func attribute(){
        urlSearchTextField.backgroundColor = .magenta
        urlSearchTextField.layer.borderColor = UIColor.black.cgColor
        urlSearchTextField.layer.cornerRadius = 10.0
        urlSearchTextField.font = .systemFont(ofSize: 36.0, weight: .regular)
        urlSearchTextField.textColor = .white
    }
    
    private func layout(){
        [urlSearchTextField].forEach{
            addSubview($0)
        }
        
        urlSearchTextField.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
        }
    }
    
    
}
