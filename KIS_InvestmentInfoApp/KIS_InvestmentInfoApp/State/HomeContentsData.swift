//
//  HomeContentsData.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/23.
//

import Foundation

class HomeContentsData {
    
    private static var instance: HomeContentsData?
    
    var contentsTitle: [String] =  ["+ 버튼을 눌러 항목추가" ]
    var contentsSubtitle: [String] = ["+ 버튼을 눌러 항목을 추가해주세요"]
    var contentsUrl: [String] = [""]
    
    
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
        contentsTitle = UserDefaults.standard.array(forKey: "homeContentsTitle") as? [String] ?? ["정보가 없습니다"]
        contentsSubtitle = UserDefaults.standard.array(forKey: "homeContentsSubTitle") as? [String] ?? ["정보가 없습니다"]
        contentsUrl = UserDefaults.standard.array(forKey: "homeContentsUrl") as? [String] ?? ["No Url"]
        print("UserDefaults에서 정보 갖고오기 끝")
    }
    
    func saveDataOnUserDafaults(){
        print("Background로 넘어가며 Url정보 UserDefaults에 저장하기")
        UserDefaults.standard.set(contentsTitle, forKey: "homeContentsTitle")
        UserDefaults.standard.set(contentsSubtitle, forKey: "homeContentsSubTitle")
        UserDefaults.standard.set(contentsUrl, forKey: "homeContentsUrl")
    }
    
    func getContentsCount() -> Int {
        return contentsTitle.count
    }
    
    func getContentsTitle() -> [String] {
        return contentsTitle
    }
    
    func getContentsSubtitle() -> [String] {
        return contentsSubtitle
    }
    
    func getContentsUrl() -> [String] {
        return contentsUrl
    }
    
    func setContentsTitle(arr: [String]){
        self.contentsTitle = arr
    }
    
    func setContentsSubtitle(arr: [String]){
        self.contentsSubtitle = arr
    }
    
    func setContentsUrl(arr: [String]) {
        self.contentsUrl = arr
    }
    
    func addNewItem(item: (String, String, String)) {
        contentsTitle.append(item.0)
        contentsSubtitle.append(item.1)
        contentsUrl.append(item.2)
        print(contentsTitle)
        print(contentsSubtitle)
        print(contentsUrl)
    }
    
}
