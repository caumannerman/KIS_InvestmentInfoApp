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
    
    
    // State들의 변화는 이곳에 getter, setter 등의 api를 만들어 관리해주면 된다.( Redux스타일 )
    // 복잡하게 얽히는 state들을 한 곳에 모아 효율적으로 관리할 수 있다.
    
    // 값을 전달하여 직접 State를 수정할 수 없는 것 ( 예를 들어, 신호만 받아 이 싱글턴 자체에서 데이터를 가공해야하는 것은, NotificationCenter를 사용해도 괜찮다 )
    
    
    
  

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
