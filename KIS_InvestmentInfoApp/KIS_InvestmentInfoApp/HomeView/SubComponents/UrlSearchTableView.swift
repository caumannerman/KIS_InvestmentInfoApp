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
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.urlsArr = UserDefaults.standard.array(forKey: "urls") as? [String] ?? ["정보가 없습니다"]
        self.urlsAlias = UserDefaults.standard.array(forKey: "urlAlias") as? [String] ?? ["정보가 없습니다"]
        attribute()
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
}

extension UrlSearchTableView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did click cell!" + "\(indexPath)")
        let url = urlsArr[indexPath.row]
//        let vc = ShowDataViewController()
//        vc.setup(apiUrl: url)
        
        NotificationCenter.default.post(name:.DidTapCell, object: .none, userInfo: ["url": url])
        
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
        cell.setup(title: urlsAlias[indexPath.row], url: urlsArr[indexPath.row])
        return cell
    }
}


extension Notification.Name {
    static let DidTapCell = Notification.Name("DidTapCell")
}
