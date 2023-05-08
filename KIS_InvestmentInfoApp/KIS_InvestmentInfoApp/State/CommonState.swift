//
//  CommonState.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/08.
//

import Foundation

//싱글턴으로 만들어야함
class CommonState {
    //Swift에서는 SINGLEton 구현이 좀 더 간결하다
    // 1. private 생성자만을 정의해 외부 클래스로부터 인스턴스 생성을 차단합니다.
    // 2. 싱글톤을 구현하고자 하는 클래스 내부에 멤버 변수로써 private static 객체 변수를 만듭니다.
    private static var instance: CommonState?
    
    private var urls: [String] = ["1"]
    private var urlAlias: [String] = []
    private var urlStarred: [Bool] = []
    
    
    private init(){
        print("CommonState Initiated")
    }
    
    public static func getInstance() -> CommonState {
        if instance == nil {
            instance = CommonState()
        }
        return instance!
        
    }
  

    //----------------------------------- Getter -----------------------------------//
//    func getUrls() -> [String] {
//        return urls
//    }
//
//    func getUrlAlias() -> [String] {
//        return urlAlias
//    }
//
//    func getUrlStarred() -> [Bool] {
//        return urlStarred
//    }
//
//    //----------------------------------- Setter -----------------------------------//
//    func setUrls(urls: [String]){
//        self.urls = urls
//    }
//
//    func setUrlAlias(urlAlias: [String]){
//        self.urlAlias = urlAlias
//    }
//
//    func setUrlStarred(urlStarred: [Bool]){
//        self.urlStarred = urlStarred
//    }

}
