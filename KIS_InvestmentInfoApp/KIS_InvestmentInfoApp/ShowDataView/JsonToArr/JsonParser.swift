//
//  JsonParser.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/10.
//

import Foundation

class JsonParser {
    let testStr: String = "[{\"result\":1,\"cur_unit\":\"AED\",\"ttb\":\"344.03\",\"tts\":\"350.98\",\"deal_bas_r\":\"347.51\",\"bkpr\":\"347\",\"yy_efee_r\":\"0\",\"ten_dd_efee_r\":\"0\",\"kftc_bkpr\":\"347\",\"kftc_deal_bas_r\":\"347.51\",\"cur_nm\":\"아랍에미리트 디르함\"},{\"result\":1,\"cur_unit\":\"AUD\",\"ttb\":\"851.18\",\"tts\":\"868.37\",\"deal_bas_r\":\"859.78\",\"bkpr\":\"859\",\"yy_efee_r\":\"0\",\"ten_dd_efee_r\":\"0\",\"kftc_bkpr\":\"859\",\"kftc_deal_bas_r\":\"859.78\",\"cur_nm\":\"호주 달러\"},{\"result\":1,\"cur_unit\":\"BHD\",\"ttb\":\"3,351.55\",\"tts\":\"3,419.26\",\"deal_bas_r\":\"3,385.41\",\"bkpr\":\"3,385\",\"yy_efee_r\":\"0\",\"ten_dd_efee_r\":\"0\",\"kftc_bkpr\":\"3,385\",\"kftc_deal_bas_r\":\"3,385.41\",\"cur_nm\":\"바레인 디나르\"},{\"result\":1,\"cur_unit\":\"BND\",\"ttb\":\"937.24\",\"tts\":\"956.17\",\"deal_bas_r\":\"946.71\",\"bkpr\":\"946\",\"yy_efee_r\":\"0\",\"ten_dd_efee_r\":\"0\",\"kftc_bkpr\":\"946\",\"kftc_deal_bas_r\":\"946.71\",\"cur_nm\":\"브루나이 달러\"},{\"result\":1,\"cur_unit\":\"CAD\",\"ttb\":\"930.64\",\"tts\":\"949.45\",\"deal_bas_r\":\"940.05\",\"bkpr\":\"940\",\"yy_efee_r\":\"0\",\"ten_dd_efee_r\":\"0\",\"kftc_bkpr\":\"940\",\"kftc_deal_bas_r\":\"940.05\",\"cur_nm\":\"캐나다 달러\"},{\"result\":1,\"cur_unit\":\"CHF\",\"ttb\":\"1,354.31\",\"tts\":\"1,381.66\",\"deal_bas_r\":\"1,367.99\",\"bkpr\":\"1,367\",\"yy_efee_r\":\"0\",\"ten_dd_efee_r\":\"0\",\"kftc_bkpr\":\"1,367\",\"kftc_deal_bas_r\":\"1,367.99\",\"cur_nm\":\"스위스 프랑\"},{\"result\":1,\"cur_unit\":\"CNH\",\"ttb\":\"180.78\",\"tts\":\"184.43\",\"deal_bas_r\":\"182.61\",\"bkpr\":\"182\",\"yy_efee_r\":\"0\",\"ten_dd_efee_r\":\"0\",\"kftc_bkpr\":\"182\",\"kftc_deal_bas_r\":\"182.61\",\"cur_nm\":\"위안화\"},{\"result\":1,\"cur_unit\":\"DKK\",\"ttb\":\"180.73\",\"tts\":\"184.38\",\"deal_bas_r\":\"182.56\",\"bkpr\":\"182\",\"yy_efee_r\":\"0\",\"ten_dd_efee_r\":\"0\",\"kftc_bkpr\":\"182\",\"kftc_deal_bas_r\":\"182.56\",\"cur_nm\":\"덴마아크 크로네\"},{\"result\":1,\"cur_unit\":\"EUR\",\"ttb\":\"1,344.13\",\"tts\":\"1,371.28\",\"deal_bas_r\":\"1,357.71\",\"bkpr\":\"1,357\",\"yy_efee_r\":\"0\",\"ten_dd_efee_r\":\"0\",\"kftc_bkpr\":\"1,357\",\"kftc_deal_bas_r\":\"1,357.71\",\"cur_nm\":\"유로\"},{\"result\":1,\"cur_unit\":\"GBP\",\"ttb\":\"1,525.33\",\"tts\":\"1,556.14\",\"deal_bas_r\":\"1,540.74\",\"bkpr\":\"1,540\",\"yy_efee_r\":\"0\",\"ten_dd_efee_r\":\"0\",\"kftc_bkpr\":\"1,540\",\"kftc_deal_bas_r\":\"1,540.74\",\"cur_nm\":\"영국 파운드\"},{\"result\":1,\"cur_unit\":\"HKD\",\"ttb\":\"161.86\",\"tts\":\"165.13\",\"deal_bas_r\":\"163.5\",\"bkpr\":\"163\",\"yy_efee_r\":\"0\",\"ten_dd_efee_r\":\"0\",\"kftc_bkpr\":\"163\",\"kftc_deal_bas_r\":\"163.5\",\"cur_nm\":\"홍콩 달러\"},{\"result\":1,\"cur_unit\":\"IDR(100)\",\"ttb\":\"8.08\",\"tts\":\"8.25\",\"deal_bas_r\":\"8.17\",\"bkpr\":\"8\",\"yy_efee_r\":\"0\",\"ten_dd_efee_r\":\"0\",\"kftc_bkpr\":\"8\",\"kftc_deal_bas_r\":\"8.17\",\"cur_nm\":\"인도네시아 루피아\"},{\"result\":1,\"cur_unit\":\"JPY(100)\",\"ttb\":\"951.42\",\"tts\":\"970.65\",\"deal_bas_r\":\"961.04\",\"bkpr\":\"961\",\"yy_efee_r\":\"0\",\"ten_dd_efee_r\":\"0\",\"kftc_bkpr\":\"961\",\"kftc_deal_bas_r\":\"961.04\",\"cur_nm\":\"일본 옌\"},{\"result\":1,\"cur_unit\":\"KRW\",\"ttb\":\"0\",\"tts\":\"0\",\"deal_bas_r\":\"1\",\"bkpr\":\"1\",\"yy_efee_r\":\"0\",\"ten_dd_efee_r\":\"0\",\"kftc_bkpr\":\"1\",\"kftc_deal_bas_r\":\"1\",\"cur_nm\":\"한국 원\"},{\"result\":1,\"cur_unit\":\"KWD\",\"ttb\":\"4,124.4\",\"tts\":\"4,207.73\",\"deal_bas_r\":\"4,166.07\",\"bkpr\":\"4,166\",\"yy_efee_r\":\"0\",\"ten_dd_efee_r\":\"0\",\"kftc_bkpr\":\"4,166\",\"kftc_deal_bas_r\":\"4,166.07\",\"cur_nm\":\"쿠웨이트 디나르\"},{\"result\":1,\"cur_unit\":\"MYR\",\"ttb\":\"285.56\",\"tts\":\"291.33\",\"deal_bas_r\":\"288.45\",\"bkpr\":\"288\",\"yy_efee_r\":\"0\",\"ten_dd_efee_r\":\"0\",\"kftc_bkpr\":\"288\",\"kftc_deal_bas_r\":\"288.45\",\"cur_nm\":\"말레이지아 링기트\"},{\"result\":1,\"cur_unit\":\"NOK\",\"ttb\":\"128.33\",\"tts\":\"130.92\",\"deal_bas_r\":\"129.63\",\"bkpr\":\"129\",\"yy_efee_r\":\"0\",\"ten_dd_efee_r\":\"0\",\"kftc_bkpr\":\"129\",\"kftc_deal_bas_r\":\"129.63\",\"cur_nm\":\"노르웨이 크로네\"},{\"result\":1,\"cur_unit\":\"NZD\",\"ttb\":\"791.03\",\"tts\":\"807.02\",\"deal_bas_r\":\"799.03\",\"bkpr\":\"799\",\"yy_efee_r\":\"0\",\"ten_dd_efee_r\":\"0\",\"kftc_bkpr\":\"799\",\"kftc_deal_bas_r\":\"799.03\",\"cur_nm\":\"뉴질랜드 달러\"},{\"result\":1,\"cur_unit\":\"SAR\",\"ttb\":\"335.93\",\"tts\":\"342.72\",\"deal_bas_r\":\"339.33\",\"bkpr\":\"339\",\"yy_efee_r\":\"0\",\"ten_dd_efee_r\":\"0\",\"kftc_bkpr\":\"339\",\"kftc_deal_bas_r\":\"339.33\",\"cur_nm\":\"사우디 리얄\"},{\"result\":1,\"cur_unit\":\"SEK\",\"ttb\":\"120.28\",\"tts\":\"122.71\",\"deal_bas_r\":\"121.5\",\"bkpr\":\"121\",\"yy_efee_r\":\"0\",\"ten_dd_efee_r\":\"0\",\"kftc_bkpr\":\"121\",\"kftc_deal_bas_r\":\"121.5\",\"cur_nm\":\"스웨덴 크로나\"},{\"result\":1,\"cur_unit\":\"SGD\",\"ttb\":\"937.24\",\"tts\":\"956.17\",\"deal_bas_r\":\"946.71\",\"bkpr\":\"946\",\"yy_efee_r\":\"0\",\"ten_dd_efee_r\":\"0\",\"kftc_bkpr\":\"946\",\"kftc_deal_bas_r\":\"946.71\",\"cur_nm\":\"싱가포르 달러\"},{\"result\":1,\"cur_unit\":\"THB\",\"ttb\":\"36.42\",\"tts\":\"37.15\",\"deal_bas_r\":\"36.79\",\"bkpr\":\"36\",\"yy_efee_r\":\"0\",\"ten_dd_efee_r\":\"0\",\"kftc_bkpr\":\"36\",\"kftc_deal_bas_r\":\"36.79\",\"cur_nm\":\"태국 바트\"},{\"result\":1,\"cur_unit\":\"USD\",\"ttb\":\"1,263.63\",\"tts\":\"1,289.16\",\"deal_bas_r\":\"1,276.4\",\"bkpr\":\"1,276\",\"yy_efee_r\":\"0\",\"ten_dd_efee_r\":\"0\",\"kftc_bkpr\":\"1,276\",\"kftc_deal_bas_r\":\"1,276.4\",\"cur_nm\":\"미국 달러\"}]"
    public static func jsonToArr(jsonString: String){
        
        // a.r, b.i, b.i.11 처럼 모든 최종 column 담을 곳
        var final_columns: [String] = []
        //그 때 그때 쌓인 column의 part 이름들을 저장할 곳
        var column_name: [String] = []
        
        // 여는 대괄호
        var lBracketCount: Int = 0
        // 닫는 대괄호
        var rBraketCount: Int = 0
        // 여는 중괄호
        var lBraceCount: Int = 0
        // 닫는 중괄호
        var rBraceCount: Int = 0
        // :를 기준으로 뭐 해줘야됨....
        
        
        // 따옴표가 열려있는지 여부
        var isDDaomOpen: Bool = false
        // 따옴표랑 항상 같이 놀아야하는 것은 그 상황에서의 따옴표 내부 문자열
        var now_column_name: String = ""
        
        
        
        for i in 0 ..< jsonString.count {
            let now_char: String = String(jsonString[String.Index(utf16Offset: i, in: jsonString)])
            
            // jsonString[String.Index(utf16Offset: i, in: jsonString)] 가 인덱스 하나씩 접근하는 것
            if now_char == "["{
                lBracketCount += 1
            }
            else if now_char == "]"{
                rBraketCount += 1
            }
            else if now_char == "{"{
                lBraceCount += 1
            }
            else if now_char == "}"{
                rBraceCount += 1
            }
            //
            else if now_char == "\""{
                // 열려있던 상태였다면, 이제 column이름 저장하고 닫아야함
                if isDDaomOpen{
                    
                    column_name.append(now_column_name)
                }
                isDDaomOpen = !isDDaomOpen
            }
            else if now_char == ":"{
                continue
            }
            //일반 문자일 때
            else{
                if isDDaomOpen{
                    now_column_name += now_char
                }
            }
                
            
        }
    }
}

