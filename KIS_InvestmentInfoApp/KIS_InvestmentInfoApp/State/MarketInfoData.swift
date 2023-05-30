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
    
    private static let r_dict: [String : String] = ["basDt" : "날짜",
                                 "srtnCd" : "종목코드",
                                 "itmsNm" : "항목명", "mrktCtg" : "시장명", "mkp" : "시가", "clpr" : "종가", "hipr" : "최고가", "lopr" : "최저가",
                                 "vs" : "전일대비등락",
                                 "fltRt" : "전일대비등락비",
                                 "trqu" : "체결량누적",
                                 "trPrc" : "거래건 별 체결가 * 체결수량 누적합",
                                 "lstgStCnt" : "상장주수",
                                 "isinCd" : "국제식별번호",
                                 "mrktTotAmt" : "종가 * 상장주수",
                                 "nstIssPrc" : "신주발행가",
                                 "dltDt" : "상장폐지일",
                                 "purRgtScrtItmsCd" : "목적주권 종목코드",
                                 "purRgtScrtItmsNm" : "목적주권 종목명",
                                 "purRgtScrtItmsClpr" : "목적주권 종가",
                                 "stLstgCnt" : "상장좌수",
                                 "exertPric" : "권리행사가격",
                                 "subtPdSttgDt" : "존속기간 시작일",
                                 "subtPdEdDt" : "존속기간 종료일",
                                 "lstgScrtCnt" : "상장증권수",
                                 "lsYrEdVsFltRt" : "전년말대비 등락율",
                                 "basPntm" : "지수산출 시점",
                                 "basIdx" : "기준시점 지수값",
                                 "idxCsf" : "지수 분류명",
                                 "idxNm" : "지수 명칭",
                                 "epyItmsCnt" : "채용종목수",
                                 "lstgMrktTotAmt" : "포함종목 시가총액",
                                 "lsYrEdVsFltRg" : "전년대비 등락폭",
                                 "yrWRcrdHgst" : "연중최고치",
                                 "yrWRcrdHgstDt" : "연중최고치 일자",
                                 "yrWRcrdLwst" : "연중최저치",
                                 "yrWRcrdLwstDt" : "연중최저치 일자",
                                 "totBnfIdxClpr" : "총수익지수 종가",
                                 "totBnfIdxVs" : "총수익지수 전일 대비 증감",
                                 "nPrcIdxClpr" : "순가격지수 종가",
                                 "nPrcIdxVs" : "순가격지수 전일 대비 증감",
                                 "zrRinvIdxClpr" : "제로재투자지수 종가",
                                 "zrRinvIdxVs" : "제로재투자지수 전일 대비 증감",
                                 "clRinvIdxClpr" : "콜재투자지수 종가",
                                 "clRinvIdxVs" : "콜재투자지수 전일 대비 증감",
                                 "mrktPrcIdxClpr" : "시장가격지수 종가",
                                 "mrktPrcIdxVs" : "시장가격지수 전일 대비 증감",
                                 "durt" : "투자자금의 평균회수기간",
                                 "cnvt" : "채권지수 볼록성",
                                 "ytm" : "만기수익률",
                                 "wtAvgPrcCptn" : "경쟁매매의 가중평균가격",
                                 "wtAvgPrcDisc" : "협의거래의 가중평균가격",
                                 "oilCtg" : "유종구분",
                                 "nav" : "순자산총액 / 상장좌수",
                                 "nPptTotAmt" : "ETF 순자산총액",
                                 "bssIdxIdxNm" : "기초지수명",
                                 "bssIdxClpr" : "기초지수 종가",
                                 "indcValTotAmt" : "지표가치총액",
                                 "indcVal" : "지표가치총액 / 상장증권수",
                                 "udasAstNm" : "기초자산 명칭",
                                 "udasAstClpr" : "기초자산 종가",
                                 "mkpBnfRt" : "시가체결 수익률",
                                 "hiprPrc" : "최고가",
                                 "hiprBnfRt" : "고가체결 수익률",
                                 "loprPrc" : "최저가",
                                 
                                 "loprBnfRt" : "저가체결 수익률",
                                 "xpYrCnt" : "년단위 만기기간",
                                 "itmsCtg" : "지표/경과",
                                 "clprPrc" : "종가",
                                 "clprVs" : "종가 전일대비등락",
                                 "clprBnfRt" : "종가체결 수익률",
                                 "prdCtg" : "상품분류",
                                 "sptPrc" : "기초자산가격",
                                 "stmPrc" : "당일 정산가",
                                 "opnint" : "미결제 약정수량",
                                 "nxtDdBsPrc" : "익일 증거금기준가",
                                 "iptVlty" : "변동성 수치",
                                 
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
