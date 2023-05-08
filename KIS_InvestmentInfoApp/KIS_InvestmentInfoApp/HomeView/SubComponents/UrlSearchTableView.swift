//
//  UrlSearchTableView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/03.
//

import UIKit

class UrlSearchTableView: UITableView {

    private var urlsAlias: [String] = []
    private var urlsArr: [String] = []
    private var urlsStarred: [Bool] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        urlsArr = UserDefaults.standard.array(forKey: "urls") as? [String] ?? ["정보가 없습니다"]
        urlsAlias = UserDefaults.standard.array(forKey: "urlAlias") as? [String] ?? ["정보가 없습니다"]
        urlsStarred = UserDefaults.standard.array(forKey: "urlStarred") as? [Bool] ?? Array(repeating: true, count: 100)
        attribute()
        
        //Cell에서 즐찾 버튼이 변경됐다는 신호를 받아주는 친구.
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeUrlStar(_:)), name: .DidChangeUrlStar, object: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute(){
        self.dataSource = self
        self.delegate = self
        self.register(UrlSearchTableViewCell.self, forCellReuseIdentifier: "UrlSearchTableViewCell")
        self.rowHeight = 100
        self.backgroundColor = UIColor(patternImage: UIImage(named: "splash")!)
    }
    
    @objc func didChangeUrlStar(_ notification: Notification) {
        print("Notification DidChangeUrlStar")
        guard let now_dict = notification.userInfo as? Dictionary<String, Any> else { return }
        guard let now_isStar = now_dict["isStar"] as? Bool else { return }
        guard let now_rowNum = now_dict["rowNum"] as? Int else { return }
        print("지금 받아온 now_isStar", terminator: " ")
        print(now_isStar)
        print("지금 받아온 now_rowNum", terminator: " ")
        print(now_rowNum)
        
        urlsStarred[now_rowNum] = now_isStar
        // isStar과 rowNum을 이용하여 UserDefaults에 업데이트 해야함
        UserDefaults.standard.set(urlsStarred, forKey: "urlStarred")

    }
}

extension UrlSearchTableView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did click cell!" + "\(indexPath)")
        let url = urlsArr[indexPath.row]
//        let vc = ShowDataViewController()
//        vc.setup(apiUrl: url)
        
        NotificationCenter.default.post(name:.DidTapUrlTVCell, object: .none, userInfo: ["url": url])
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}

extension UrlSearchTableView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UrlSearchTableViewCell", for: indexPath) as? UrlSearchTableViewCell else { return UITableViewCell()}
        cell.selectionStyle = .none
        cell.setup(title: urlsAlias[indexPath.row], url: urlsArr[indexPath.row], isStar: urlsStarred[indexPath.row], rowNum: indexPath.row)
        return cell
    }
}


