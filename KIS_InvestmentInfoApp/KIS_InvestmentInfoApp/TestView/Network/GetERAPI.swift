//
//  GetERAPI.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/02.
//

import Foundation


// query만 바뀌는 데 맞춰 새로원 URLComponents를 return해주면 되므로 아래와 같은 설계
struct GetERAPI {
    static let scheme = "https://"
    static let host = "www.koreaexim.go.kr"
    static let path = "/site/program/financial/exchangeJSON"
    
    func getERurl() -> String {
//        var components = URLComponents()
//        components.scheme = GetERAPI.scheme
//        components.host = GetERAPI.host
//        components.path = GetERAPI.path
        var urlStr = GetERAPI.scheme + GetERAPI.host + GetERAPI.path + "?authkey=BlCJAvGJ4IuXS30CPGMFIjQpiCuDTbjb&data=AP01"
//        components.queryItems = [
//            URLQueryItem(name: "authkey", value: "BlCJAvGJ4IuXS30CPGMFIjQpiCuDTbjb"),
//            URLQueryItem(name: "data", value: "AP01")
//        ]
        return urlStr

    }
}
