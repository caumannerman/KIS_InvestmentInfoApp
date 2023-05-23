//
//  IS_StockPriceInfo.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/22.
//

import Foundation


struct IS_StockPriceInfo: Decodable {
    let response: IS_StockPriceInfo_response
    enum CodingKeys: String, CodingKey{
        case response = "response"
    }
}

struct IS_StockPriceInfo_response: Decodable {
    let body: IS_StockPriceInfo_body
    enum CodingKeys: String, CodingKey{
        case body = "body"
    }
}


struct IS_StockPriceInfo_body: Decodable {
    let items: IS_StockPriceInfo_items
    enum CodingKeys: String, CodingKey{
        case items = "items"
    }
}

struct IS_StockPriceInfo_items: Decodable {
    let item: [IS_StockPriceInfo_item]
    enum CodingKeys: String, CodingKey{
        case item = "item"
    }
}


struct IS_StockPriceInfo_item: Decodable {
    
    //이름
    let idxNm: String?
    let itmsNm: String?
    let oilCtg: String?
    
    // 추가 정보들
    let idxCsf: String?
    let epyItmsCnt: String? //채용종목수
    let ytm: String? // 만기수익률
    let cnvt: String? //채권지수볼록성
    let trqu: String? // 포함종목 거래량 총합
    let trPrc: String? // 포함종목 거래대금 총합
    let strnCd: String? // 코드
    let isinCd: String? // 국제채권식별번호
    
    let bssIdxIdxNm: String? // 기초지수명칭
    let udasAstNm: String? // 기초자산 명칭
    
    let prdCtg: String? // 상품분류
    
    let mrktCtg: String?
    
    
    enum CodingKeys: String, CodingKey{
       
        case idxNm = "idxNm"
        case itmsNm = "itmsNm"
        case oilCtg = "oilCtg"
        
        case idxCsf = "idxCsf"
        case epyItmsCnt = "epyItmsCnt"
        case ytm = "ytm"
        case cnvt = "cnvt"
        case trqu = "trqu"
        case trPrc = "trPrc"
        
        case strnCd = "strnCd"
        case isinCd = "isinCd"
        case bssIdxIdxNm = "bssIdxIdxNm"
        case udasAstNm = "udasAstNm"
        case prdCtg = "prdCtg"
        case mrktCtg = "mrktCtg"
    }
}

