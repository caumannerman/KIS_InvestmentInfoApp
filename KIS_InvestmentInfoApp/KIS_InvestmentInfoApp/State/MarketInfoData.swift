//
//  MarketInfoData.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/22.
//

import Foundation

//1. 금융위원회_주식시세정보
// 
//apis.data.go.kr/1160100/service/GetStockSecuritiesInfoService
//
//    (1) 주식시세  /getStockPriceInfo
//
//    (2) 신주인수권증서시세 /getPreemptiveRightCertificatePriceInfo
//
//    (3) 수익증권시세 /getSecuritiesPriceInfo
//
//    (4) 신주인수권증권시세 /getPreemptiveRightSecuritiesPriceInfo
//
//
//
//2. 금융위원회_지수시세정보
//
//apis.data.go.kr/1160100/service/GetMarketIndexInfoService
//
//    (1) 주가지수시세 /getStockMarketIndex
//
//    (2) 채권지수시세 /getBondMarketIndex
//
//    (3) 파생상품지수시세 /getDerivationProductMarketIndex
//
//
//
//
//3. 금융위원회_일반상품시세정보
//
//apis.data.go.kr/1160100/service/GetGeneralProductInfoService
//
//    (1) 석유시세 /getOilPriceInfo
//
//    (2) 금시세 / /getGoldPriceInfo
//
//    (3) 배출권시세 /getCertifiedEmissionReductionPriceInfo
//
//
//
//4. 금융위원회_증권상품시세정보
//
//apis.data.go.kr/1160100/service/GetSecuritiesProductInfoService
//
//    (1) ETF시세 /getETFPriceInfo
//
//    (2) ETN시세 /getETNPriceInfo
//
//    (3) ELW시세 /getELWPriceInfo
//
//
//5. 금융위원회_채권시세정보
//
//apis.data.go.kr/1160100/service/GetBondSecuritiesInfoService
//
//    (1) 채권시세 /getBondPriceInfo
//
//
//6. 금융위원회_파생상품시세정보
//
//apis.data.go.kr/1160100/service/GetDerivativeProductInfoService
//
//    (1) 선물시세 /getStockFuturesPriceInfo
//
//    (2) 옵션시세 /getOptionsPriceInfo
class MarketInfoData {
    
    private static let baseDate: String = "&basDt=20230525"
    // 앱 실행중에 동적으로 변하지 않는 값이다.
    private static let marketSections: [String] =  ["주식", "지수", "금/석유/배출권", "ETF/ETN/ELW", "채권", "파생상품"]
    private static let marketSubSections: [[String]] = [
    [ "주식시세", "신주인수권증서시세", "수익증권시세", "신주인수권증권시세" ],
    [ "주가지수시세", "채권지수시세", "파생상품지수시세" ],
    [ "석유시세", "금시세", "배출권시세" ],
    [ "ETF시세", "ETN시세", "ELW시세" ],
    [ "채권시세" ],
    [ "선물시세", "옵션시세" ]
    ]
    
    private static let marketSubSectionsUrls: [[String]] = [
        [
            "http://apis.data.go.kr/1160100/service/GetStockSecuritiesInfoService/getStockPriceInfo" + "?numOfRows=100&resultType=json&serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D",
            
            "http://apis.data.go.kr/1160100/service/GetStockSecuritiesInfoService/getPreemptiveRightCertificatePriceInfo" + "?numOfRows=100&resultType=json&serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D",
            
            "http://apis.data.go.kr/1160100/service/GetStockSecuritiesInfoService/getSecuritiesPriceInfo" + "?numOfRows=100&resultType=json&serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D" ,
            
            "http://apis.data.go.kr/1160100/service/GetStockSecuritiesInfoService/getPreemptiveRightSecuritiesPriceInfo" + "?numOfRows=100&resultType=json&serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D",
            ],

        [
            "http://apis.data.go.kr/1160100/service/GetMarketIndexInfoService/getStockMarketIndex" + "?numOfRows=100&resultType=json&serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D",
            
            "http://apis.data.go.kr/1160100/service/GetMarketIndexInfoService/getBondMarketIndex" + "?numOfRows=100&resultType=json&serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D",
            
            "http://apis.data.go.kr/1160100/service/GetMarketIndexInfoService/getDerivationProductMarketIndex" + "?numOfRows=100&resultType=json&serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D",
       ],
            [
            "http://apis.data.go.kr/1160100/service/GetGeneralProductInfoService/getOilPriceInfo" + "?numOfRows=100&resultType=json&serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D",
            
            "http://apis.data.go.kr/1160100/service/GetGeneralProductInfoService/getGoldPriceInfo" + "?numOfRows=100&resultType=json&serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D",
            
            "http://apis.data.go.kr/1160100/service/GetGeneralProductInfoService/getCertifiedEmissionReductionPriceInfo" + "?numOfRows=100&resultType=json&serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D",
        ],
        [
            "http://apis.data.go.kr/1160100/service/GetSecuritiesProductInfoService/getETFPriceInfo" + "?numOfRows=100&resultType=json&serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D",
            
            "http://apis.data.go.kr/1160100/service/GetSecuritiesProductInfoService/getETNPriceInfo" + "?numOfRows=100&resultType=json&serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D",
            
            "http://apis.data.go.kr/1160100/service/GetSecuritiesProductInfoService/getELWPriceInfo" + "?numOfRows=100&resultType=json&serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D" ,
            
        ],
        [
            "http://apis.data.go.kr/1160100/service/GetBondSecuritiesInfoService/getBondPriceInfo" + "?numOfRows=100&resultType=json&serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D",
            
        ],
        [
            "http://apis.data.go.kr/1160100/service/GetDerivativeProductInfoService/getStockFuturesPriceInfo" + "?numOfRows=100&resultType=json&serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D",
            
            "http://apis.data.go.kr/1160100/service/GetDerivativeProductInfoService/getOptionsPriceInfo" + "?numOfRows=100&resultType=json&serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D"
        ]
    ]
    
    static func getBaseDate() -> String {
        return self.baseDate
    }
    
    static func getMarketSections() -> [String] {
        return self.marketSections
    }
    
    static func getMarketSectionsCount() -> Int {
        return self.marketSections.count
    }
    
    static func getMarketSubSections(idx: Int) -> [String] {
        return self.marketSubSections[idx]
    }
    
    static func getMarketSubSectionsUrls(idx: Int) -> [String] {
        return self.marketSubSectionsUrls[idx]
    }
    static func getMarketSubSectionsUrl(row: Int, col: Int) -> String {
        return self.marketSubSectionsUrls[row][col]
    }
    
    static func getMarketSubSectionsCount(idx: Int) -> Int {
        return self.marketSubSections[idx].count
    }
    
}
