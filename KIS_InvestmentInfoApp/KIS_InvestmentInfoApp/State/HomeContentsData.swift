//
//  HomeContentsData.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/23.
//

import Foundation

class HomeContentsData {
    
    private static var instance: HomeContentsData?
    
    var itemTitle: [String] =  ["+ 버튼을 눌러 항목추가" ]
    var itemSubTitle: [String] = ["+ 버튼을 눌러 항목을 추가해주세요"]
    var itemSection: [Int] = [-1]
    var itemSubSection: [Int] = [-1]
    
    private init(){
        print("HomeState Init")
    }
    
    public static func getInstance() -> HomeContentsData {
        if instance == nil {
            instance = HomeContentsData()
        }
        return instance!
    }
    func getDataFromUserDefaults(){
        print("UserDefaults에서 정보 갖고오기 시작")
//        contentsTitle = UserDefaults.standard.array(forKey: "homeContentsTitle") as? [String] ?? ["정보가 없습니다"]
//        contentsSubtitle = UserDefaults.standard.array(forKey: "homeContentsSubTitle") as? [String] ?? ["정보가 없습니다"]
//        contentsUrl = UserDefaults.standard.array(forKey: "homeContentsUrl") as? [String] ?? ["No Url"]
        itemTitle =  UserDefaults.standard.array(forKey: "homeItemTitle") as? [String] ?? ["no Item"]
        itemSubTitle = UserDefaults.standard.array(forKey: "homeItemSubTitle") as? [String] ?? ["no Item"]
        itemSection = UserDefaults.standard.array(forKey: "homeItemSection") as? [Int] ?? [-1]
        itemSubSection = UserDefaults.standard.array(forKey: "homeItemSubSection") as? [Int] ?? [-1]
        print("UserDefaults에서 정보 갖고오기 끝")
    }
    
    func saveDataOnUserDafaults(){
        print("Background로 넘어가며 Url정보 UserDefaults에 저장하기")
        UserDefaults.standard.set(itemTitle, forKey: "homeItemTitle")
        UserDefaults.standard.set(itemSubTitle, forKey: "homeItemSubTitle")
        UserDefaults.standard.set(itemSection, forKey: "homeItemSection")
        UserDefaults.standard.set(itemSubSection, forKey: "homeItemSubSection")
    }
    
    func getContentsCount() -> Int {
        return itemTitle.count
    }
//
//    func getContentsTitle() -> [String] {
//        return contentsTitle
//    }
//
//    func getContentsSubtitle() -> [String] {
//        return contentsSubtitle
//    }
//
//    func getContentsUrl() -> [String] {
//        return contentsUrl
//    }
//
//    func setContentsTitle(arr: [String]){
//        self.contentsTitle = arr
//    }
//
//    func setContentsSubtitle(arr: [String]){
//        self.contentsSubtitle = arr
//    }
//
//    func setContentsUrl(arr: [String]) {
//        self.contentsUrl = arr
//    }
//
    func addNewItem(item: (String, String, (Int, Int))) {
        itemTitle.append(item.0)
        itemSubTitle.append(item.1)
        itemSection.append(item.2.0)
        itemSubSection.append(item.2.1)
    }
    
}
