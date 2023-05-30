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
    
    let basDt: String?
    let srtnCd: String?
    let itmsNm: String?
    let mrktCtg: String?
    let mkp: String?
    let clpr: String?
    let hipr: String?
    let lopr: String?
    let vs: String?
    let fltRt: String?
    let trqu: String?
    let trPrc: String?
    let lstgStCnt: String?
    let isinCd: String?
    let mrktTotAmt: String?
    let nstIssPrc: String?
    let dltDt: String?
    let purRgtScrtItmsCd: String?
    let purRgtScrtItmsNm: String?
    let purRgtScrtItmsClpr: String?
    let stLstgCnt: String?
    let exertPric: String?
    let subtPdSttgDt: String?
    let subtPdEdDt: String?
    let lstgScrtCnt: String?
    let lsYrEdVsFltRt: String?
    let basPntm: String?
    let basIdx: String?
    let idxCsf: String?
    let idxNm: String?
    let epyItmsCnt: String?
    let lstgMrktTotAmt: String?
    let lsYrEdVsFltRg: String?
    let yrWRcrdHgst: String?
    let yrWRcrdHgstDt: String?
    let yrWRcrdLwst: String?
    let yrWRcrdLwstDt: String?
    let totBnfIdxClpr: String?
    let totBnfIdxVs: String?
    let nPrcIdxClpr: String?
    let nPrcIdxVs: String?
    let zrRinvIdxClpr: String?
    let zrRinvIdxVs: String?
    let clRinvIdxClpr: String?
    let clRinvIdxVs: String?
    let mrktPrcIdxClpr: String?
    let mrktPrcIdxVs: String?
    let durt: String?
    let cnvt: String?
    let ytm: String?
    let wtAvgPrcCptn: String?
    let wtAvgPrcDisc: String?
    let oilCtg: String?
    let nav: String?
    let nPptTotAmt: String?
    let bssIdxIdxNm: String?
    let bssIdxClpr: String?
    let indcValTotAmt: String?
    let indcVal: String?
    let udasAstNm: String?
    let udasAstClpr: String?
    let mkpBnfRt: String?
    let hiprPrc: String?
    let hiprBnfRt: String?
    let loprPrc: String?
    let loprBnfRt: String?
    let xpYrCnt: String?
    let itmsCtg: String?
    let clprPrc: String?
    let clprVs: String?
    let clprBnfRt: String?
    let prdCtg: String?
    let sptPrc: String?
    let stmPrc: String?
    let opnint: String?
    let nxtDdBsPrc: String?
    let iptVlty: String?
    
    
    
}

