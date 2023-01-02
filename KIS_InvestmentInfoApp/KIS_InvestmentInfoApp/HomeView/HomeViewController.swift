//
//  HomeViewController.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/02.
//

import UIKit

class HomeViewController: UIViewController {

    //검색했던 URL들을 담을 배열
    private var urlsArr: [String] = []
    
    private func isFirstTime() -> Bool {
        let defaults = UserDefaults.standard
        
        if defaults.object(forKey: "isFirstTime") == nil {
            defaults.set(false, forKey: "isFirstTime")
            return true
        } else {
            return false
        }
    }
    private let button = UIButton()
    //prefix가 같은 url들을 UserDefaults에서 불러와 뿌려줄 TableView
//    private lazy var urlTableView: UITableView = {
//        let tableView = UITableView()
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.isHidden = true
//        tableView.backgroundColor = .blue
//        return tableView
//    }()
    private var urlTableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

//        urlsArr = UserDefaults.standard.array(forKey: "urls") as? [String] ?? ["저장된 URL이 없음"]


    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        urlTableView.dataSource = self
        urlTableView.delegate = self
        urlTableView.isHidden = true
        urlTableView.backgroundColor = .blue
        let isFT = isFirstTime()
        print(isFT)
        // 앱 실행이 처음이라면
        if isFT{
            UserDefaults.standard.set(["url1", "url2","url3","url4", "url5"], forKey: "urls")
        }
        print(urlsArr)
        print(UserDefaults.standard.array(forKey: "urls") as? [String] ?? ["정보가 없습니다"])
//        self.urlsArr = UserDefaults.standard.array(forKey: "urls") as? [String] ?? ["정보가 없습니다"]
//        urlTableView.reloadData()
        
        
        view.backgroundColor = .white
        setNavigationItems()
        attribute()
        layout()
    }
    
    private func setNavigationItems(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "API 요청URL 입력"
        //TODO: title color 변경
//        navigationItem.titleView?.backgroundColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 194/255.0, alpha: 1.0)
//        navigationItem.titleView?.tintColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 194/255.0, alpha: 1.0)
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "요청 URL을 입력해주세요"
        //화면 어두워지지 않도록 false 처리
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        // embed UISearchController
        navigationItem.searchController = searchController
    }
    
    private func attribute(){
        button.setTitle("넘어가기", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(pushVC), for: .touchUpInside)
    }
    
    @objc func pushVC(){
        let vc = ShowDataViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    private func layout(){
        [button, urlTableView].forEach{
            view.addSubview($0)
        }
        button.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        urlTableView.snp.makeConstraints{
            $0.top.equalTo(button.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

extension HomeViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //이전 검색이 있었을 경우에, DidEndEditing에서 stations리스트를 비워두었고 tableView는 그대로이기 때문에
        // reloadData() 해주지 않으면 이전 검색 내역이 그대로 tableView에 남아있다.
        urlTableView.reloadData()
        urlTableView.isHidden = false
        print(urlsArr)
    }
 
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        urlTableView.isHidden = true
        //나중에 다시 검색창을 켰을 때, 이전에 검색했던 지하철역들이 TableView에 그대로 보이지 않도록 리스트 비워줌
        //urlsArr = []
    }
    //text가 바뀔 때마다 request를 Alamofire를 이용해 보내아고 받아옴
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            return
        }
        //TODO: 여기서 UserDefaults에서 prefix가 같은 것들 검색해와서 tableVIew reload
        
//        requestStationName(from: searchText)
    }
    
}

//TableView에 대한 delegate설정
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlsArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //기본 cell 사용
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let url = urlsArr[indexPath.row]
        cell.textLabel?.text = "url별칭"
        cell.detailTextLabel?.text = url
        return cell
    }
}

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = urlsArr[indexPath.row]
        print(url)
        //TODO: 여기서 채팅창에 url을 넘겨줘야함
        
    }
}
