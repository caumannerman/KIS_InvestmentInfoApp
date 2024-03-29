//
//  UrlSearchTableView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/03.
//

import UIKit

class UrlSearchTableView: UITableView {

     private let scoms = UrlCommonState.getInstance()
//    private var urlsAlias: [String] = []
//    private var urlsArr: [String] = []
//    private var urlsStarred: [Bool] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
//        urlsArr = UserDefaults.standard.array(forKey: "urls") as? [String] ?? ["정보가 없습니다"]
//        urlsAlias = UserDefaults.standard.array(forKey: "urlAlias") as? [String] ?? ["정보가 없습니다"]
//        urlsStarred = UserDefaults.standard.array(forKey: "urlStarred") as? [Bool] ?? Array(repeating: true, count: 100)
        attribute()
        
        //Cell에서 즐찾 버튼이 변경됐다는 신호를 받아주는 친구.
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeUrlStar(_:)), name: .DidChangeUrlStar, object: nil)
        //현재 검색하고있는 텍스트 받아와서 reload해야됨
        NotificationCenter.default.addObserver(self, selector: #selector(getUrlSearchText(_:)), name: .sendUrlSearchText, object: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute(){
        self.dataSource = self
        self.delegate = self
        self.backgroundColor = UIColor(red: 200/255, green: 220/255, blue: 250/255, alpha: 1.0)
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
        
        if now_isStar {
            scoms.InsertNewlyStarredUrl(rowNum: now_rowNum)
        } else {
            scoms.InsertNewlyUnStarredUrl(rowNum: now_rowNum)
        }
        print("즐찾 바꾼 후", terminator: " ")
        print(scoms.getUrlStarred())
       
        self.reloadData()
    }
    @objc func getUrlSearchText(_ notification: Notification) {
        print("Notification getUrlSearchText")
        self.reloadData()
    }
    
}

extension UrlSearchTableView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did click cell!" + "\(indexPath)")
//        let url = urlsArr[indexPath.row]
        let url = scoms.getUrls()[indexPath.row]

        NotificationCenter.default.post(name:.DidTapUrlTVCell, object: .none, userInfo: ["url": url])
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}

extension UrlSearchTableView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return urlsArr.count
        return scoms.getUrlsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UrlSearchTableViewCell", for: indexPath) as? UrlSearchTableViewCell else { return UITableViewCell()}
        
        cell.setup(title: scoms.urlsAlias[indexPath.row], url: scoms.urlsArr[indexPath.row], isStar: scoms.urlsStarred[indexPath.row], rowNum: indexPath.row)
       
        return cell
    }
}


