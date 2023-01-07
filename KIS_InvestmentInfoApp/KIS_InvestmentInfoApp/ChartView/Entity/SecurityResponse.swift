//
//  SecurityResponse.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/06.
//

import Foundation

struct SecurityResponse: Decodable {
    let response: SecurityBody
    enum CodingKeys: String, CodingKey{
        case response = "response"
    }
}

struct SecurityBody: Decodable {
    let body: SecurityItems
    enum CodingKeys: String, CodingKey{
        case body = "body"
    }
}

struct SecurityItems: Decodable {
    let items: SecurityItem
    enum CodingKeys: String, CodingKey{
        case items = "items"
    }
}

struct SecurityItem: Decodable {
    let item: [SecurityData]
    enum CodingKeys: String, CodingKey{
        case item = "item"
    }
}


struct SecurityData: Decodable {
    // 날짜정보 ex) 20221228
    let basDt: String?
    // 종목코드
    let srtnCd: String?
    // 종목명 ex) 삼성전자
    let itmsNm: String?
    // 상장된 시장명 KOSPI, KOSDAQ, KONEX 중 하나mrktCtg
    let mrktCtg: String?
    
    //시가 ( 9시 )
    let mkp: String?
    //종가
    let clpr: String?
    //하루 중 최고가
    let hipr: String?
    //하루 중 최저가
    let lopr: String?
    enum CodingKeys: String, CodingKey{
        case basDt = "basDt"
        case srtnCd = "srtnCd"
        case itmsNm = "itmsNm"
        case mrktCtg = "mrktCtg"
        case mkp = "mkp"
        case clpr = "clpr"
        case hipr = "hipr"
        case lopr = "lopr"
    }
}
