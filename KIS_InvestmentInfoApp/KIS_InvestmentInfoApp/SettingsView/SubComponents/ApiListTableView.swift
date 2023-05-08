//
//  ApiListTableView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/04/25.
//

import UIKit

class ApiListTableView: UITableView {

    // urlsAlias와 urlsArr은 갯수를 항상 동일하게맞추어야한다.
    private var urlsAlias: [String] = []
    //검색했던 URL들을 담을 배열
    private var urlsArr: [String] = []
    private var urlsStarred: [Bool] = []
    private var urlsIsValid: [Bool] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.dataSource = self
        self.delegate = self
        self.register(ApiListTableViewCell.self, forCellReuseIdentifier: "ApiListTableViewCell")
        self.rowHeight = 80
        
        urlsArr = UserDefaults.standard.array(forKey: "urls")as? [String] ?? ["정보가 없습니다"]
        urlsAlias = UserDefaults.standard.array(forKey: "urlAlias") as? [String] ?? ["정보가 없습니다"]
        urlsStarred = UserDefaults.standard.array(forKey: "urlStarred") as? [Bool] ?? Array(repeating: true, count: 100)
        
        print(urlsStarred, "입니다")
        urlsAlias = Array(urlsAlias[1..<urlsAlias.count])
        urlsArr = Array(urlsArr[1..<urlsArr.count])
        urlsStarred = Array(urlsStarred[1..<urlsStarred.count])
        
        //여기서, 즉 url들을 받아왔으니, 지금 각 url이 유효한지 테스트하고, urlsIsValid에 값을 채워넣어야함.
        checkUrlIsValid()
        print("SettingsView의 ApiListTableView Init 시점 테스트")
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TODO: 1순위
    //url이 유효한지, 즉 유의미한 값이 들어있는 json을 받아오는지 알아야함.
    private func checkUrlIsValid(){
        // 여기서 urlsIsValid에 값 채워야함.
        for i in urlsArr{
            
        }
        
    }
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
        return urlsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ApiListTableViewCell", for: indexPath) as? ApiListTableViewCell else { return UITableViewCell()}
        cell.selectionStyle = .none
        cell.setup(urlAlias: urlsAlias[indexPath.row], url: urlsArr[indexPath.row], isValid: true, isStar: urlsStarred[indexPath.row])
        return cell
    }
}
