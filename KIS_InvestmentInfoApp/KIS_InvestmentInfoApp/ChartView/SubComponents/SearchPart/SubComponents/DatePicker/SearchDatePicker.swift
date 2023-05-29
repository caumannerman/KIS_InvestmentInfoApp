//
//  SearchDatePicker.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/25.
//

import UIKit

class SearchDatePicker: UIDatePicker {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        maximumContentSizeCategory = .extraLarge
        datePickerMode = .date
        preferredDatePickerStyle = .inline
        //연-월-일 순으로 + 한글
        locale = Locale(identifier: "ko-KR")
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
