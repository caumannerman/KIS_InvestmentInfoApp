//
//  ValueForLineChart.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/30.
//

import Foundation


struct ValueForLineChart: Decodable {
    let response: ValueForLineChart_response
    enum CodingKeys: String, CodingKey{
        case response = "response"
    }
}

struct ValueForLineChart_response: Decodable {
    let body: ValueForLineChart_body
    enum CodingKeys: String, CodingKey{
        case body = "body"
    }
}


struct ValueForLineChart_body: Decodable {
    let items: ValueForLineChart_items
    enum CodingKeys: String, CodingKey{
        case items = "items"
    }
}

struct ValueForLineChart_items: Decodable {
    let item: [ValueForLineChart_item]
    enum CodingKeys: String, CodingKey{
        case item = "item"
    }
}


//여기에는 LineChart로 나타낼만한 것들만 넣어주면됨.
// nil인 것은 나중에 뿌려줄 때 걸러주면 됨.
struct ValueForLineChart_item: Decodable {
    
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

    let bssIdxIdxNm: String? // 기초지수명칭
    let udasAstNm: String? // 기초자산 명칭
    
    let prdCtg: String? // 상품분류
    
    let mrktCtg: String?
    
    let strnCd: String? // 코드
    let isinCd: String? // 국제채권식별번호
    
    
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
        
       
        case bssIdxIdxNm = "bssIdxIdxNm"
        case udasAstNm = "udasAstNm"
        case prdCtg = "prdCtg"
        case mrktCtg = "mrktCtg"
        case strnCd = "strnCd"
        case isinCd = "isinCd"
    }
}

