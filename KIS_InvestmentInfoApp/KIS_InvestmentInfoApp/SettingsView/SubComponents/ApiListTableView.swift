//
//  ApiListTableView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/04/25.
//

import UIKit
import Alamofire

class ApiListTableView: UITableView {

    let scoms = UrlCommonState.getInstance()

    private var urlsIsValid: [Bool] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.dataSource = self
        self.delegate = self
        self.register(ApiListTableViewCell.self, forCellReuseIdentifier: "ApiListTableViewCell")
        self.rowHeight = 80
        
//        urlsArr = UserDefaults.standard.array(forKey: "urls")as? [String] ?? ["정보가 없습니다"]
//        urlsAlias = UserDefaults.standard.array(forKey: "urlAlias") as? [String] ?? ["정보가 없습니다"]
//        urlsStarred = UserDefaults.standard.array(forKey: "urlStarred") as? [Bool] ?? Array(repeating: true, count: 100)
        
//        print(urlsStarred, "입니다")
        
//        urlsAlias = Array(urlsAlias[1..<urlsAlias.count])
//        urlsArr = Array(urlsArr[1..<urlsArr.count])
//        urlsStarred = Array(urlsStarred[1..<urlsStarred.count])
        
        //여기서, 즉 url들을 받아왔으니, 지금 각 url이 유효한지 테스트하고, urlsIsValid에 값을 채워넣어야함.
        print("SettingsView의 ApiListTableView Init 시점 테스트")
//        checkUrlIsValid()
        print("url valid 여부 확인 완료")
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TODO: 1순위
    //url이 유효한지, 즉 유의미한 값이 들어있는 json을 받아오는지 알아야함.
//    private func checkUrlIsValid(){
//        // 여기서 urlsIsValid에 값 채워야함.
//        for i in scoms.urlsArr{
//            print("-----------------------------------------!")
//            scoms.requestAPI(url: i)
//        }
//    }
}

extension ApiListTableView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did click cell!" + "\(indexPath)")
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("삭제")
            
        }
    }
}

extension ApiListTableView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return urlsArr.count
        return scoms.getUrlsCount() - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ApiListTableViewCell", for: indexPath) as? ApiListTableViewCell else { return UITableViewCell()}
        cell.selectionStyle = .none
        cell.setup(urlAlias: scoms.urlsAlias[indexPath.row + 1], url: scoms.urlsArr[indexPath.row + 1], isValid: scoms.urlsIsValid[indexPath.row + 1], isStar: scoms.urlsStarred[indexPath.row + 1], rowNum: indexPath.row)
        return cell
    }
}


