//
//  JsonParser.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/10.
//

import Foundation

class JsonParser {
    // 최종 return값은 csv형태를 가진 String의 2차원배열이어야 한다.
    public static func jsonToArr(jsonString: String) -> [[String]]{
//        print("합수 시작")
        // a.r, b.i, b.i.11 처럼 모든 최종 column 담을 곳
        // final_dict_key는 추가한 순서대로 Key를 담을 곳이다.
        var final_dict_key: [String] = []
        var final_dict: [String: [String]] = [:]
        
        //그 때 그때 쌓인 column의 part 이름들을 저장할 곳
        var column_name: [String] = []
        var value_name: [String] = []
        
        // 여는 대괄호
        var lBracketCount: Int = 0
        // 닫는 대괄호
        var rBraketCount: Int = 0
        // 여는 중괄호
        var lBraceCount: Int = 0
        // 닫는 중괄호
        var rBraceCount: Int = 0
        // :를 기준으로 뭐 해줘야됨....
        // MARK: 괄호들을 Stack에 넣으면서 관리해줘야함
        var bracketStack: [String] = []
        
        // 따옴표가 열려있는지 여부
        var isDDaomOpen: Bool = false
        // 따옴표랑 항상 같이 놀아야하는 것은 그 상황에서의 따옴표 내부 문자열 -> 이어붙여야함
        var now_btwn_Ddaom_name: String = ""
        //: 뒤에서 일반문자가 나왔을 때. 무조건 값인 경우에 저장할 곳
        var now_value: String = ""
        
        var now_opened_colon: Int = 0
        //방금 전에 :가 등장해서 value가 등장할 차례인 경우를 표시하기 위해
        var is_now_value_timing: Bool = true
        
        var i: Int = 0
        
        while i < jsonString.count {
            let now_char: String = String(jsonString[String.Index(utf16Offset: i, in: jsonString)])
//            print(now_char)
            // jsonString[String.Index(utf16Offset: i, in: jsonString)] 가 인덱스 하나씩 접근하는 것
            if now_char == "["{
                is_now_value_timing = false
                bracketStack.append("[")
                lBracketCount += 1
                i += 1
            }
            else if now_char == "]"{
                rBraketCount += 1
    //            bracketStack.append("]")
                // ]와 [를 차례로 pop해준다.
    //            bracketStack.removeLast()
                bracketStack.removeLast()
                //대괄호가 닫힐 때는 무조건 대괄호가 열리는 key를 pop해줘야한다.
                if bracketStack.count > 0 {
                    column_name.removeLast()
                }
                i += 1
            }
            else if now_char == "{"{
                bracketStack.append("{")
                is_now_value_timing = false
                lBraceCount += 1
                i += 1
            }
            //이거 닫힐 때는 대괄호가 열려있는 경우에는 column_name에서 아무것도 안 빼줘도되고, 열려있는 대괄호가 없는 경우에만 } 닫힐 때 stack에서 빼주면 됨
            else if now_char == "}"{
    //            bracketStack.append("}")
    //
    //            bracketStack.removeLast()
                bracketStack.removeLast()
                //}와 {를 pop하고 남은 것이 [라면, col_name에서 pop하지 않는다. {라면 pop한다.
                if bracketStack.count > 0 && bracketStack.last! == "{"{
                    //pop
                    column_name.removeLast()
                }// [인 경우이거나 비었을 경우
                rBraceCount += 1
                //대괄호가 열려있을 때, 대괄호 여는것 - 대괄호 닫는것 < 중괄호 여는것 - 중괄호 닫는 것 이면 pop   중괄호 여는게 닫는거보다 2개 이상 크면
                i += 1
            }
            //
            else if now_char == "\""{
                // 열려있던 상태였다면, 이제 column이름 저장하고 닫아야함
                if isDDaomOpen{
                    //value인 경우 -> 무조건 column_name에서 하나씩 이름을 뺴줘야함
                    if is_now_value_timing{
                        value_name.append(now_btwn_Ddaom_name)
//                        print(value_name)
                        
                        //값이 나왔으니까 현재까지 stack에 쌓인 column_name을 key로 하여 dict에 값을 value로 넣어준다
                        let now_joined_column = column_name.joined(separator: "/")
                        if final_dict[now_joined_column] == nil {
                            final_dict[now_joined_column] = [now_btwn_Ddaom_name]
                            //없던 key이기 때문에, final_dict_key에도 넣어준다.
                            final_dict_key.append(now_joined_column)
                        }else{
                            final_dict[now_joined_column]?.append(now_btwn_Ddaom_name)
                        }
                        // 방금 나온 값에 대해 완료했으니, 해당 이름을 하나 pop 한다.
                        column_name.removeLast()
                        is_now_value_timing = false
                    }
                    //column이다.
                    else {
                        column_name.append(now_btwn_Ddaom_name)
//                        print(column_name)
                    }
                    
                    
                    now_btwn_Ddaom_name = ""
                    isDDaomOpen = false
                    i += 1
                }
                //닫혀있었는데, 방금 열리는 상태라면, "가 나올 때까지 사이의 값을 now_column_name에 저장해야한다
                else{
                    //방금은 " 였으니까
                    i += 1
                    isDDaomOpen = true
                    while true {
                        let now_char2: String = String(jsonString[String.Index(utf16Offset: i, in: jsonString)])
                        // "가 나오기 전까지는
                        if now_char2 != "\""{
                            now_btwn_Ddaom_name += now_char2
                            i += 1
                        }// "가 나오면 빠져나가야함
                        else{
                            break
                        }
                    }
                }
            }
            //:가 나왔다면 이제 value가 나와야할 자리인데, [ 혹은 {가 나오는 경우, is_now_value_timing을 false로 바꿔야한다
            else if now_char == ":"{
                now_opened_colon += 1
                is_now_value_timing = true
                i += 1
            }
            
            else if now_char == "," || now_char == " " || now_char == "\n"{
                i += 1
                continue
            }
            //일반 문자일 때 -> 여기는 있어서는 안됨
            else{
                // value자리인 경우
                if is_now_value_timing{
                    // ,나오기 전까지는 계속 value이니까 계속 이어붙여줌
                    while true{
                        let now_char3: String = String(jsonString[String.Index(utf16Offset: i, in: jsonString)])
                        if now_char3 != "," {
                            now_value += now_char3
                            i += 1
                        }//MARK: ,가 나오면 value를 print하고 넘어가자 일단
                        else{
                            
                            value_name.append(now_value)
//                            print(value_name)
                            //값이 나왔으니까 현재까지 stack에 쌓인 column_name을 key로 하여 dict에 값을 value로 넣어준다
                            let now_joined_column = column_name.joined(separator: "/")
                            if final_dict[now_joined_column] == nil {
                                final_dict[now_joined_column] = [now_value]
                                //없던 key이기 때문에, final_dict_key에도 넣어준다.
                                final_dict_key.append(now_joined_column)
                            }else{
                                final_dict[now_joined_column]?.append(now_value)
                            }
                            // 방금 나온 값에 대해 완료했으니, 해당 이름을 하나 pop 한다.
                            column_name.removeLast()
                            
                            now_value = ""
                            i += 1
                            is_now_value_timing = false
                            break
                        }
                        
                    }
                   
                }
                else {
                    print("일반 문자 등장. 있어서는 안됨 ")
                }
            }
        }
        var dict_val_max: Int = -1
        for i in final_dict.values {
            dict_val_max = max( dict_val_max, i.count )
        }
        var result_arr: [[String]] = Array(repeating: Array(repeating: "", count: final_dict_key.count), count: dict_val_max + 1)
        
        for i in 0 ..< final_dict_key.count{
            result_arr[0][i] = final_dict_key[i]
        }
        for i in 0 ..< final_dict_key.count {
            for j in 0 ..< final_dict[final_dict_key[i]]!.count {
                result_arr[j + 1][i] = final_dict[final_dict_key[i]]![j]
            }
        }
        return result_arr
    }
    
    
    
    
    
    
    
    
    
    
    
    public static func jsonToArr2(jsonString: String) -> [[String]]{
//        print("합수 시작")
        // a.r, b.i, b.i.11 처럼 모든 최종 column 담을 곳
        // final_dict_key는 추가한 순서대로 Key를 담을 곳이다.
        var final_dict_key: [String] = []
        var final_dict: [String: [String]] = [:]
        
        //그 때 그때 쌓인 column의 part 이름들을 저장할 곳
        var column_name: [String] = []
        var value_name: [String] = []
        
        // 여는 대괄호
        var lBracketCount: Int = 0
        // 닫는 대괄호
        var rBraketCount: Int = 0
        // 여는 중괄호
        var lBraceCount: Int = 0
        // 닫는 중괄호
        var rBraceCount: Int = 0
        // :를 기준으로 뭐 해줘야됨....
        // MARK: 괄호들을 Stack에 넣으면서 관리해줘야함
        var bracketStack: [String] = []
        
        // 따옴표가 열려있는지 여부
        var isDDaomOpen: Bool = false
        // 따옴표랑 항상 같이 놀아야하는 것은 그 상황에서의 따옴표 내부 문자열 -> 이어붙여야함
        var now_btwn_Ddaom_name: String = ""
        //: 뒤에서 일반문자가 나왔을 때. 무조건 값인 경우에 저장할 곳
        var now_value: String = ""
        
        var now_opened_colon: Int = 0
        //방금 전에 :가 등장해서 value가 등장할 차례인 경우를 표시하기 위해
        var is_now_value_timing: Bool = true
        
        var i: Int = 0
        
        while i < jsonString.count {
            let now_char: String = String(jsonString[String.Index(utf16Offset: i, in: jsonString)])
//            print(now_char)
            // jsonString[String.Index(utf16Offset: i, in: jsonString)] 가 인덱스 하나씩 접근하는 것
            if now_char == "["{
                is_now_value_timing = false
                bracketStack.append("[")
                lBracketCount += 1
                i += 1
            }
            else if now_char == "]"{
                rBraketCount += 1
    //            bracketStack.append("]")
                // ]와 [를 차례로 pop해준다.
    //            bracketStack.removeLast()
                bracketStack.removeLast()
                //대괄호가 닫힐 때는 무조건 대괄호가 열리는 key를 pop해줘야한다.
                if bracketStack.count > 0 {
                    column_name.removeLast()
                }
                i += 1
            }
            else if now_char == "{"{
                bracketStack.append("{")
                is_now_value_timing = false
                lBraceCount += 1
                i += 1
            }
            //이거 닫힐 때는 대괄호가 열려있는 경우에는 column_name에서 아무것도 안 빼줘도되고, 열려있는 대괄호가 없는 경우에만 } 닫힐 때 stack에서 빼주면 됨
            else if now_char == "}"{
    //            bracketStack.append("}")
    //
    //            bracketStack.removeLast()
                bracketStack.removeLast()
                //}와 {를 pop하고 남은 것이 [라면, col_name에서 pop하지 않는다. {라면 pop한다.
                if bracketStack.count > 0 && bracketStack.last! == "{"{
                    //pop
                    column_name.removeLast()
                }// [인 경우이거나 비었을 경우
                rBraceCount += 1
                //대괄호가 열려있을 때, 대괄호 여는것 - 대괄호 닫는것 < 중괄호 여는것 - 중괄호 닫는 것 이면 pop   중괄호 여는게 닫는거보다 2개 이상 크면
                i += 1
            }
            //
            else if now_char == "\""{
                // 열려있던 상태였다면, 이제 column이름 저장하고 닫아야함
                if isDDaomOpen{
                    //value인 경우 -> 무조건 column_name에서 하나씩 이름을 뺴줘야함
                    if is_now_value_timing{
                        value_name.append(now_btwn_Ddaom_name)
//                        print(value_name)
                        
                        //값이 나왔으니까 현재까지 stack에 쌓인 column_name을 key로 하여 dict에 값을 value로 넣어준다
                        let now_joined_column = column_name.joined(separator: "/")
                        if final_dict[now_joined_column] == nil {
                            final_dict[now_joined_column] = [now_btwn_Ddaom_name]
                            //없던 key이기 때문에, final_dict_key에도 넣어준다.
                            final_dict_key.append(now_joined_column)
                        }else{
                            final_dict[now_joined_column]?.append(now_btwn_Ddaom_name)
                        }
                        // 방금 나온 값에 대해 완료했으니, 해당 이름을 하나 pop 한다.
                        column_name.removeLast()
                        is_now_value_timing = false
                    }
                    //column이다.
                    else {
                        column_name.append(now_btwn_Ddaom_name)
//                        print(column_name)
                    }
                    
                    
                    now_btwn_Ddaom_name = ""
                    isDDaomOpen = false
                    i += 1
                }
                //닫혀있었는데, 방금 열리는 상태라면, "가 나올 때까지 사이의 값을 now_column_name에 저장해야한다
                else{
                    //방금은 " 였으니까
                    i += 1
                    isDDaomOpen = true
                    while true {
                        let now_char2: String = String(jsonString[String.Index(utf16Offset: i, in: jsonString)])
                        // "가 나오기 전까지는
                        if now_char2 != "\""{
                            now_btwn_Ddaom_name += now_char2
                            i += 1
                        }// "가 나오면 빠져나가야함
                        else{
                            break
                        }
                    }
                }
            }
            //:가 나왔다면 이제 value가 나와야할 자리인데, [ 혹은 {가 나오는 경우, is_now_value_timing을 false로 바꿔야한다
            else if now_char == ":"{
                now_opened_colon += 1
                is_now_value_timing = true
                i += 1
            }
            
            else if now_char == "," || now_char == " " || now_char == "\n"{
                i += 1
                continue
            }
            //일반 문자일 때 -> 여기는 있어서는 안됨
            else{
                // value자리인 경우
                if is_now_value_timing{
                    // ,나오기 전까지는 계속 value이니까 계속 이어붙여줌
                    while true{
                        let now_char3: String = String(jsonString[String.Index(utf16Offset: i, in: jsonString)])
                        if now_char3 != "," {
                            now_value += now_char3
                            i += 1
                        }//MARK: ,가 나오면 value를 print하고 넘어가자 일단
                        else{
                            
                            value_name.append(now_value)
//                            print(value_name)
                            //값이 나왔으니까 현재까지 stack에 쌓인 column_name을 key로 하여 dict에 값을 value로 넣어준다
                            let now_joined_column = column_name.joined(separator: "/")
                            if final_dict[now_joined_column] == nil {
                                final_dict[now_joined_column] = [now_value]
                                //없던 key이기 때문에, final_dict_key에도 넣어준다.
                                final_dict_key.append(now_joined_column)
                            }else{
                                final_dict[now_joined_column]?.append(now_value)
                            }
                            // 방금 나온 값에 대해 완료했으니, 해당 이름을 하나 pop 한다.
                            column_name.removeLast()
                            
                            now_value = ""
                            i += 1
                            is_now_value_timing = false
                            break
                        }
                        
                    }
                   
                }
                else {
                    print("일반 문자 등장. 있어서는 안됨 ")
                }
            }
        }
//        print("최종 결과!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
//        for key_name in final_dict_key{
//            print(key_name, terminator: " ")
//            print(final_dict[key_name]!)
//            print()
//        }
        
//        final_dict_key
//        final_dict
        //날짜정보 / 종목코드 / 종목명 / 상장시장명 / 시가 / 종가 / 최고가 / 최저가
        let r_dict: [String : String] = ["response/body/items/item/basDt" : "날짜",
                                         "response/body/items/item/srtnCd" : "종목코드",
                                         "response/body/items/item/itmsNm" : "항목명", "response/body/items/item/mrktCtg" : "시장명", "response/body/items/item/mkp" : "시가", "response/body/items/item/clpr" : "종가", "response/body/items/item/hipr" : "최고가", "response/body/items/item/lopr" : "최저가",
                                         "response/body/items/item/vs" : "전일대비등락",
                                         "response/body/items/item/fltRt" : "전일대비등락비",
                                         "response/body/items/item/trqu" : "체결량누적",
                                         "response/body/items/item/trPrc" : "거래건 별 체결가 * 체결수량 누적합",
                                         "response/body/items/item/lstgStCnt" : "상장주수",
                                         "response/body/items/item/isinCd" : "국제식별번호",
                                         "response/body/items/item/mrktTotAmt" : "종가 * 상장주수",
                                         "response/body/items/item/nstIssPrc" : "신주발행가",
                                         "response/body/items/item/dltDt" : "상장폐지일",
                                         "response/body/items/item/purRgtScrtItmsCd" : "목적주권 종목코드",
                                         "response/body/items/item/purRgtScrtItmsNm" : "목적주권 종목명",
                                         "response/body/items/item/purRgtScrtItmsClpr" : "목적주권 종가",
                                         "response/body/items/item/stLstgCnt" : "상장좌수",
                                         "response/body/items/item/exertPric" : "권리행사가격",
                                         "response/body/items/item/subtPdSttgDt" : "존속기간 시작일",
                                         "response/body/items/item/subtPdEdDt" : "존속기간 종료일ㄹ",
                                         "response/body/items/item/lstgScrtCnt" : "상장증권수",
                                         "response/body/items/item/lsYrEdVsFltRt" : "전년말대비 등락율",
                                         "response/body/items/item/basPntm" : "지수산출 시점",
                                         "response/body/items/item/basIdx" : "기준시점 지수값",
                                         "response/body/items/item/idxCsf" : "지수 분류명",
                                         "response/body/items/item/idxNm" : "지수 명칭",
                                         "response/body/items/item/epyItmsCnt" : "채용종목수",
                                         "response/body/items/item/lstgMrktTotAmt" : "포함종목 시가총액",
                                         "response/body/items/item/lsYrEdVsFltRg" : "전년대비 등락폭",
                                         "response/body/items/item/yrWRcrdHgst" : "연중최고치",
                                         "response/body/items/item/yrWRcrdHgstDt" : "연중최고치 일자",
                                         "response/body/items/item/yrWRcrdLwst" : "연중최저치",
                                         "response/body/items/item/yrWRcrdLwstDt" : "연중최저치 일자",
                                         "response/body/items/item/totBnfIdxClpr" : "총수익지수 종가",
                                         "response/body/items/item/totBnfIdxVs" : "총수익지수 전일 대비 증감",
                                         "response/body/items/item/nPrcIdxClpr" : "순가격지수 종가",
                                         "response/body/items/item/nPrcIdxVs" : "순가격지수 전일 대비 증감",
                                         "response/body/items/item/zrRinvIdxClpr" : "제로재투자지수 종가",
                                         "response/body/items/item/zrRinvIdxVs" : "제로재투자지수 전일 대비 증감",
                                         "response/body/items/item/clRinvIdxClpr" : "콜재투자지수 종가",
                                         "response/body/items/item/clRinvIdxVs" : "콜재투자지수 전일 대비 증감",
                                         "response/body/items/item/mrktPrcIdxClpr" : "시장가격지수 종가",
                                         "response/body/items/item/mrktPrcIdxVs" : "시장가격지수 전일 대비 증감",
                                         "response/body/items/item/durt" : "투자자금의 평균회수기간",
                                         "response/body/items/item/cnvt" : "채권지수 볼록성",
                                         "response/body/items/item/ytm" : "만기수익률",
                                         "response/body/items/item/wtAvgPrcCptn" : "경쟁매매의 가중평균가격",
                                         "response/body/items/item/wtAvgPrcDisc" : "협의거래의 가중평균가격",
                                         "response/body/items/item/oilCtg" : "유종구분",
                                         "response/body/items/item/nav" : "순자산총액 / 상장좌수",
                                         "response/body/items/item/nPptTotAmt" : "ETF 순자산총액",
                                         "response/body/items/item/bssIdxIdxNm" : "기초지수명",
                                         "response/body/items/item/bssIdxClpr" : "기초지수 종가",
                                         "response/body/items/item/indcValTotAmt" : "지표가치총액",
                                         "response/body/items/item/indcVal" : "지표가치총액 / 상장증권수",
                                         "response/body/items/item/udasAstNm" : "기초자산 명칭",
                                         "response/body/items/item/udasAstClpr" : "기초자산 종가",
                                         "response/body/items/item/mkpBnfRt" : "시가체결 수익률",
                                         "response/body/items/item/hiprPrc" : "최고가",
                                         "response/body/items/item/hiprBnfRt" : "고가체결 수익률",
                                         "response/body/items/item/loprPrc" : "최저가",
                                         
                                         "response/body/items/item/loprBnfRt" : "저가체결 수익률",
                                         "response/body/items/item/xpYrCnt" : "년단위 만기기간",
                                         "response/body/items/item/itmsCtg" : "지표/경과",
                                         "response/body/items/item/clprPrc" : "종가",
                                         "response/body/items/item/clprVs" : "종가 전일대비등락",
                                         "response/body/items/item/clprBnfRt" : "종가체결 수익률",
                                         "response/body/items/item/prdCtg" : "상품분류",
                                         "response/body/items/item/sptPrc" : "기초자산가격",
                                         "response/body/items/item/stmPrc" : "당일 정산가",
                                         "response/body/items/item/opnint" : "미결제 약정수량",
                                         "response/body/items/item/nxtDdBsPrc" : "익일 증거금기준가",
                                         "response/body/items/item/iptVlty" : "변동성 수치",
                                         
        ]
        
        var final_dict_key2: [String] = []
        
        for i in final_dict_key{
            if r_dict.keys.contains(i){
                print("포함")
                final_dict_key2.append(i)
            }//제거
            else{
                final_dict[i] = nil
            }
        }
        var dict_val_max: Int = -1
        for i in final_dict.values {
            dict_val_max = max( dict_val_max, i.count )
        }
        
        var result_arr: [[String]] = Array(repeating: Array(repeating: "", count: final_dict_key2.count), count: dict_val_max + 1)
        
        for i in 0 ..< final_dict_key2.count{
            result_arr[0][i] = r_dict[final_dict_key2[i]] ?? ""
        }
        for i in 0 ..< final_dict_key2.count {
            for j in 0 ..< final_dict[final_dict_key2[i]]!.count {
                result_arr[j + 1][i] = final_dict[final_dict_key2[i]]![j]
            }
        }
        return result_arr
    }

}

