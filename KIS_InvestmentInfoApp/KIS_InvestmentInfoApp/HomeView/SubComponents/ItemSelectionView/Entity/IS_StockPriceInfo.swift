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
    let basDt: String?
    let itmsNm: String?
    enum CodingKeys: String, CodingKey{
        case basDt = "basDt"
        case itmsNm = "itmsNm"
    }
}

