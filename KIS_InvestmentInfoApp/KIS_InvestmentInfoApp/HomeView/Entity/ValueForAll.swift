//
//  ValueForAll.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/31.
//

import Foundation


struct ValueForAll: Decodable {
    let response: ValueForAll_response
    enum CodingKeys: String, CodingKey{
        case response = "response"
    }
}

struct ValueForAll_response: Decodable {
    let body: ValueForAll_body
    enum CodingKeys: String, CodingKey{
        case body = "body"
    }
}


struct ValueForAll_body: Decodable {
    let items: ValueForAll_items
    enum CodingKeys: String, CodingKey{
        case items = "items"
    }
    
}

struct ValueForAll_items: Decodable {
    let item: [ValueForAll_item]
    enum CodingKeys: String, CodingKey{
        case item = "item"
    }
}


//여기에는 LineChart로 나타낼만한 것들만 넣어주면됨.
// nil인 것은 나중에 뿌려줄 때 걸러주면 됨.
struct ValueForAll_item: Decodable {
    
    //시가
    let mkp: String?
    let clpr: String? // 종가
    let hipr: String? // 고가
    let lopr: String? // 저가
    let vs: String? // 전일대비등락
    let fltRt: String? // 전일대비등락비
    let trqu: String? //체결량누적
    let trPrc: String? // 포함종목 거래대금 총합
    let purRgtScrtItmsClpr: String? //목적주권 종가

    let exertPric: String? // 권리행사가격
    let basIdx: String? // 기준시점 지수값
    
    let yrWRcrdHgst: String? // 연중최고치
    
    let yrWRcrdLwst: String? // 연중최저치
    
    let totBnfIdxClpr: String? // 총수익지수
    let totBnfIdxVs: String? // 총수익지수 전일 대비 증감
    let nPrcIdxClpr: String? // 순가격지수 종가
    let nPrcIdxVs: String? // 순가격지수 전일 대비 증감
    let zrRinvIdxClpr: String? // 제로재투자지수 종가
    let zrRinvIdxVs: String? // 제로재투자지수 전일 대비 증감
    let clRinvIdxClpr: String? // 콜재투자지수 종가
    let clRinvIdxVs: String? // 콜재투자지수 전일 대비 증감
    let mrktPrcIdxClpr: String? // 시장가격지수 종가
    let mrktPrcIdxVs: String? // 시장가격지수 전일 대비 증감
    let cnvt: String? // 채권지수 볼록성
    
    let nav: String? // 순자산총액 / 상장좌수
    let nPptTotAmt: String? // 순자산총액
    let bssIdxClpr: String? // 기초지수 종가
    let hiprPrc: String? // 최고가
    let loprPrc: String? // 최저가
    let clprPrc: String? // 종가
    let clprVs: String? // 종가 전일대비등락
    
    let clprBnfRt: String? // 종가체결 수익률
    let sptPrc: String? // 기초자산가격
    let stmPrc: String? // 당일 정산가
    let opnint: String? // 미결제 약정수량
    let iptVlty: String? // 변동성 수치
    
    
    
//    enum CodingKeys: String, CodingKey{
//
//        case idxNm = "idxNm"
//        case itmsNm = "itmsNm"
//        case oilCtg = "oilCtg"
//
//        case idxCsf = "idxCsf"
//        case epyItmsCnt = "epyItmsCnt"
//        case ytm = "ytm"
//        case cnvt = "cnvt"
//        case trqu = "trqu"
//        case trPrc = "trPrc"
//
//
//        case bssIdxIdxNm = "bssIdxIdxNm"
//        case udasAstNm = "udasAstNm"
//        case prdCtg = "prdCtg"
//        case mrktCtg = "mrktCtg"
//        case strnCd = "strnCd"
//        case isinCd = "isinCd"
//    }
}

