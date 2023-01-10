//
//  SiteView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/09.
//

import SwiftUI

struct SiteView: Identifiable{
    var id = UUID().uuidString
    var hour: Date
    var views: Double
    var animate: Bool = false
}


extension Date{
    func updateHour(value: Int) -> Date{
        let calendar = Calendar.current
        return calendar.date(bySettingHour: value, minute: 0, second: 0, of: self) ?? .now
    }
}


var sample_analytics: [SiteView] = [
    SiteView(hour: Date().updateHour(value: 8), views: 1500),
    SiteView(hour: Date().updateHour(value: 9), views: 2625),
    SiteView(hour: Date().updateHour(value: 10), views: 7500),
    SiteView(hour: Date().updateHour(value: 11), views: 3688),
    SiteView(hour: Date().updateHour(value: 12), views: 2988),
    SiteView(hour: Date().updateHour(value: 13), views: 3289),
    SiteView(hour: Date().updateHour(value: 14), views: 4500),
    SiteView(hour: Date().updateHour(value: 15), views: 6788),
    SiteView(hour: Date().updateHour(value: 16), views: 9988),
    SiteView(hour: Date().updateHour(value: 17), views: 2200),
    SiteView(hour: Date().updateHour(value: 18), views: 4505),
    SiteView(hour: Date().updateHour(value: 19), views: 1500),
    SiteView(hour: Date().updateHour(value: 20), views: 3000),
    SiteView(hour: Date().updateHour(value: 21), views: 9988),
    SiteView(hour: Date().updateHour(value: 22), views: 2200),
    SiteView(hour: Date().updateHour(value: 23), views: 4505),
    SiteView(hour: Date().updateHour(value: 24), views: 1500),
    SiteView(hour: Date().updateHour(value: 25), views: 3000),
    SiteView(hour: Date().updateHour(value: 26), views: 9988),
    SiteView(hour: Date().updateHour(value: 27), views: 2200),
    SiteView(hour: Date().updateHour(value: 28), views: 4505),
    SiteView(hour: Date().updateHour(value: 29), views: 1500),
    SiteView(hour: Date().updateHour(value: 30), views: 3000),
]


struct SecurityInfo: Identifiable{
    var id = UUID().uuidString
    
    // 날짜정보 ex) 20221228
    var basDt: String
    // 종목코드
    var strnCd: String
    // 종목명 ex) 삼성전자
    var itmsNm: String
    // 상장된 시장명 KOSPI, KOSDAQ, KONEX 중 하나mrktCtg
    var mrktCtg: String
    
    //시가 ( 9시 )
    var mkp: String
    //종가
    var clpr: String
    //하루 중 최고가
    var hipr: String
    //하루 중 최저가
    var lopr: String
}
