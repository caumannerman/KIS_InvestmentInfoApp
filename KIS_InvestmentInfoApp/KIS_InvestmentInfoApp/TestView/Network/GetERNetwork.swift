//
//  GetERNetwork.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/02.
//

import Foundation


enum GetERNetworkError: Error {
    case invalidURL
    case invalidJSON
    case networkError
}

class GetERNetwork {
    private let session: URLSession
    let api = GetERAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
//    func getErData() -> Single<Result<[ExchangeRate], GetERNetworkError>> {
//        print(api.getERurl())
//        print("여기")
//        //URLComponents로부터 url을 얻어낸다.
//        guard let url = URL(string: api.getERurl()) else {
//            return .just(.failure(.invalidURL))
//        }
//        print("URL = ", url)
////        let ud = UserDefaults.standard
////        let acstoken = ud.value(forKey: "userToken")!
//
//        //Request생성
//        let request = NSMutableURLRequest(url: url)
//        request.httpMethod = "GET"
////        request.setValue(acstoken as? String, forHTTPHeaderField: "Authorization")
//
//        return  session.rx.data(request: request as URLRequest)
//            .map { data in
//                do {
//                    //요청으로 받아온 응답ㅇ르 우리가 만들어놓은 DKBlog entity형태에 맞게 decode함
//                    let erData = try JSONDecoder().decode([ExchangeRate].self, from: data)
//                    print("받아온 데이터")
//                    print(erData)
//                    print("받아온 데이터")
//                    return .success(erData)
//                } catch {
//                    return .failure(.invalidJSON)
//                }
//            }
//            .catch{ _ in
//                    .just(.failure(.networkError))
//            }
//            .asSingle()
//    }
}
