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
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.dataSource = self
        self.delegate = self
        self.register(ApiListTableViewCell.self, forCellReuseIdentifier: "ApiListTableViewCell")
        self.rowHeight = 80
        
        self.urlsArr = UserDefaults.standard.array(forKey: "urls") as? [String] ?? ["정보가 없습니다"]
        self.urlsAlias = UserDefaults.standard.array(forKey: "urlAlias") as? [String] ?? ["정보가 없습니다"]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func reloadData(){
//        self.urlsArr = UserDefaults.standard.array(forKey: "urls") as? [String] ?? ["정보가 없습니다"]
//        self.urlsAlias = UserDefaults.standard.array(forKey: "urlAlias") as? [String] ?? ["정보가 없습니다"]
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
        return urlsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ApiListTableViewCell", for: indexPath) as? ApiListTableViewCell else { return UITableViewCell()}
        cell.selectionStyle = .none
        cell.setup(urlAlias: urlsAlias[indexPath.row], url: urlsArr[indexPath.row], isValid: true, isStar: true)
        return cell
    }
}
