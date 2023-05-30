//
//  DummyClass.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/04.
//

import Foundation


class DummyClass {
    private static let jsonResultArr: [[String]] = Array(repeating: Array(repeating: "", count: 12), count: 21) 
    static func getJsonResultArr() -> [[String]]{
        return jsonResultArr
    }
    
    private static let firstUrl: [String] = ["", "https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=BlCJAvGJ4IuXS30CPGMFIjQpiCuDTbjb&searchdate=20221227&data=AP01", "https://www.koreaexim.go.kr/site/program/financial/interestJSON?authkey=4qVtBPk7TdjRIHVUfFXJWXg6rrbt80zj&searchdata=20221227&data=AP02","https://fisis.fss.or.kr/openapi/companySearch.json?lang=kr&auth=0020bd45bec7194822ea8a7164c705e0&partDiv=A","https://fisis.fss.or.kr/openapi/statisticsInfoSearch.json?lang=kr&auth=0020bd45bec7194822ea8a7164c705e0&financeCd=0010927&listNo=SA001&term=Q&startBaseMm=202206&endBaseMm=202306",
                                         "https://opendart.fss.or.kr/api/fnlttSinglAcnt.json?crtfc_key=4f00bd74671058d76697c90e95c123d088e36610&corp_code=00126380&bsns_year=2018&reprt_code=11011"]
    static func getFirstUrl() -> [String]{
        return firstUrl
    }
    
    
    
    private static let firstUrlAlias: [String] = ["검색", "현재환율_수출입은행", "대출금리_수출입은행","금융통계정보시스템-금융회사API","금융통계정보시스템-통계정보API","OpenDART-상장기업 재무정보"]
    
    static func getFirstUrlAlias() -> [String]{
        return firstUrlAlias
    }
    
    private static let firstUrlStarred: [Bool] = [true, true, true, false, false, false]
    
    static func getFirstUrlStarred() -> [Bool] {
        return firstUrlStarred
    }
    
    // ------------ Home Item 초기화를 위한 변수들 -----------//
    private static let firstHomeItemTitle: [String] = ["항목추가 방법"]
    static func getFirstHomeItemTitle() -> [String]  {
        return firstHomeItemTitle
    }

    private static let firstHomeItemSubTitle: [String] = ["+ 버튼을 눌러 항목을 추가해주세요"]
    static func getFirstHomeItemSubTitle() -> [String] {
        return firstHomeItemSubTitle
    }

    private static let firstHomeItemSection: [Int] = [0]
    static func getFirstHomeItemSection() -> [Int] {
        return firstHomeItemSection
    }
    
    private static let firstHomeItemSubSection: [Int] = [0]
    static func getFirstHomeItemSubSection() -> [Int] {
        return firstHomeItemSubSection
    }
    
   
    
}
