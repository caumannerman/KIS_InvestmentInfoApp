//
//  HomeContentsData.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/23.
//

import Foundation

class HomeContentsData {
    private static var contentsTitle: [String] =  ["항목1", "항목2", "항목3", "항목4", "항목5", "항목6", "항목7", "항목8"]
    private static var contentsSubtitle: [String] = ["Detail111111111", "Detail11111111122222", "Detail11111111133333", "Detail1111111114444", "Detail11111111155555", "Detail1111111116666", "Detail111111111777", "Detail1111111118888"]
    private static var contentsUrl: [String] = []
    
    static func getContentsTitle() -> [String] {
        return contentsTitle
    }
    
    static func getContentsSubtitle() -> [String] {
        return contentsSubtitle
    }
    
    static func addNewItem(item: (String, String)) {
        contentsTitle.append(item.0)
        contentsSubtitle.append(item.1)
    }
    
}
