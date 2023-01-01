//
//  ExchangeRate.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/02.
//


import Foundation

struct ExchangeRate: Decodable {
    let cur_unit: String?
    let ttb: String?
    let tts: String?
    let deal_bas_r: String?
    let bkpr: String?
    let yy_efee_r: String?
    let ten_dd_efee_r: String?
    let kftc_bkpr: String?
    let kftc_deal_bas_r: String?
    let cur_nm: String?
   
}
