//
//  HomeViewController.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/02.
//

import UIKit
import SnapKit
import Alamofire

class HomeViewController: UIViewController {

    
    private let alert = UIAlertController(title: "api별칭 입력", message: "별칭을 입력해주세요", preferredStyle: .alert)
    private var ok = UIAlertAction()
    // urlsAlias와 urlsArr은 갯수를 항상 동일하게맞추어야한다.
    private var urlsAlias: [String] = []
    //검색했던 URL들을 담을 배열
    private var urlsArr: [String] = []
    //header를 담기위한 dictionary
    private var headerDict: [String: String] = [:]
    
    private func isFirstTime() -> Bool {
        let defaults = UserDefaults.standard
        
        if defaults.object(forKey: "isFirstTime") == nil {
            defaults.set(false, forKey: "isFirstTime")
            return true
        } else {
            return false
        }
    }
    
//    private lazy var addHeaderTableView: UITableView = {
//        let tableView = UITableView()
////        tableView.dataSource = self
////        tableView.delegate = self
//        tableView.backgroundColor = .yellow
//        tableView.register(AddHeaderViewCell.self, forCellReuseIdentifier: "AddHeaderViewCell")
//        tableView.rowHeight = 50
//        tableView.tag = 1
//        return tableView
//    }()
    
//    private let button = UIButton()
    //prefix가 같은 url들을 UserDefaults에서 불러와 뿌려줄 TableView

    private lazy var urlTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.backgroundColor = UIColor(red: 223/255.0, green: 156/255.0, blue: 50/255.0, alpha: 1.0)
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "splash")!)
        return tableView
        
    }()
    private let uiSc: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "요청 URL을 입력해주세요"
        //화면 어두워지지 않도록 false 처리
        searchController.obscuresBackgroundDuringPresentation = false
        
        return searchController
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        let ur = UserDefaults.standard.array(forKey: "urls") as? [String] ?? ["저장된 URL이 없음"]
        print(type(of: ur))
        print(ur)
        self.uiSc.isActive = true
        self.uiSc.isEditing = true
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItems()
        
        view.backgroundColor = .systemBackground
        // DataSource, Delegate 설정 시 구분을 위해 tag 설정
        alert.addTextField{
            $0.placeholder = "별칭을 입력하세요"
            $0.isSecureTextEntry = false
        }
        
        
        let isFT = isFirstTime()
        print(isFT)
        // 앱 실행이 처음이라면
        if isFT{
            UserDefaults.standard.set(["", "https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=BlCJAvGJ4IuXS30CPGMFIjQpiCuDTbjb&searchdate=20221227&data=AP01", "https://www.koreaexim.go.kr/site/program/financial/interestJSON?authkey=4qVtBPk7TdjRIHVUfFXJWXg6rrbt80zj&searchdata=20221227&data=AP02","https://opendart.fss.or.kr/api/list.json?crtfc_key=4f00bd74671058d76697c90e95c123d088e36610"], forKey: "urls")
            
            UserDefaults.standard.set(["검색", "현재환율_수출입은행", "대출금리_수출입은행","openDart"], forKey: "urlAlias")
        }
        print(urlsArr)
        print(UserDefaults.standard.array(forKey: "urls") as? [String] ?? ["정보가 없습니다"])
        self.urlsArr = UserDefaults.standard.array(forKey: "urls") as? [String] ?? ["정보가 없습니다"]
        self.urlsAlias = UserDefaults.standard.array(forKey: "urlAlias") as? [String] ?? ["정보가 없습니다"]
//        urlTableView.reloadData()

        
        attribute()
        layout()
        
        ok = UIAlertAction(title: "OK", style: .default){
            action in print("OK")
            self.urlsArr.append(self.uiSc.searchBar.text ?? "")
            self.urlsAlias.append(self.alert.textFields?[0].text ?? "")
            self.uiSc.searchBar.text = ""
            
           
            self.urlsArr[0] = ""
            self.urlsAlias[0] = "검색중"
            //UserDefaults에도 값 갱신
            UserDefaults.standard.set(self.urlsArr, forKey: "urls")
            UserDefaults.standard.set(self.urlsAlias, forKey: "urlAlias")
            let url = self.urlsArr.last!
            let vc = ShowDataViewController()
            vc.setup(apiUrl: url)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        alert.addAction(ok)
    }
    
    private func setNavigationItems(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "API 요청URL 입력"
        //TODO: title color 변경
        
//        let searchController = UISearchController()
//        searchController.searchBar.placeholder = "요청 URL을 입력해주세요"
//        //화면 어두워지지 않도록 false 처리
//        searchController.obscuresBackgroundDuringPresentation = false
        uiSc.searchBar.delegate = self
        
        // embed UISearchController
        navigationItem.searchController = uiSc
    }
    
    private func attribute(){
//        button.setTitle("요청 URL 입력", for: .normal)
//        button.backgroundColor = .lightGray
//        button.addTarget(self, action: #selector(pushVC), for: .touchUpInside)
    }
    
    @objc func pushVC(){
        let vc = ShowDataViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    private func layout(){
        [ urlTableView].forEach{
            view.addSubview($0)
        }
//        addHeaderTableView.snp.makeConstraints{
//            $0.top.equalTo(view.safeAreaLayoutGuide)
//
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo( (headerDict.count + 2) * 50)
//        }
//
//        button.snp.makeConstraints{
//            $0.top.equalTo(view.safeAreaLayoutGuide)
//            $0.leading.trailing.equalToSuperview().inset(30)
//            $0.height.equalTo(50)
//        }
        
        urlTableView.snp.makeConstraints{
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
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
//        urlsArr = []
        
    }
    //text가 바뀔 때마다 request를 Alamofire를 이용해 보내아고 받아옴
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            return
        }
        //TODO: 여기서 UserDefaults에서 prefix가 같은 것들 검색해와서 tableVIew reload
        let now_text = searchBar.text ?? ""
        urlsArr[0] = now_text
        
        requestStationName()
    }
    //검색 버튼을 눌렀을 때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchButton clicked!!")
        print(searchBar.text)
        
        self.present(alert, animated: true){
            print("kkkkkk")
        }
        
        print("여기까지 됨")
        //검색을 했을 시, 지역 변수 배열 두가지에 검색한 url에 대하여 값을 append하고, 이를 UserDefaults에도 갱신해준다.
        // OK쪽 콜백으로 옮김
//        self.urlsArr.append(searchBar.text ?? "")
//        self.urlsAlias.append("새로 검색한 url")
//
//        self.urlsArr[0] = ""
//        self.urlsAlias[0] = "별칭"
//        //UserDefaults에도 값 갱신
//        UserDefaults.standard.set(urlsArr, forKey: "urls")
//        UserDefaults.standard.set(urlsAlias, forKey: "urlAlias")
//        let url = searchBar.text?.trimmingCharacters(in: .whitespaces) ?? ""
//        let vc = ShowDataViewController()
//        vc.setup(apiUrl: url)
//        navigationController?.pushViewController(vc, animated: true)

    }
    
}

//TableView에 대한 delegate설정
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return urlsArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // addHeaderTableView
//        if tableView.tag == 1{
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddHeaderViewCell", for: indexPath) as? AddHeaderViewCell else { return UITableViewCell() }
//            return cell
//        }

        // urlTableView
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        // 첫 cell에는 현재 검색하고있는 내용을 실시간으로 작성해줄 것이다.
        
//        if indexPath.row == 0 {
//            let url = "검색url"
//            let url_alias = "검색중"
//            cell.textLabel?.text = url_alias
//            cell.detailTextLabel?.text = url
//            return cell
//        }
            let url = urlsArr[indexPath.row ]
        let url_alias = urlsAlias[indexPath.row ]
            
            cell.textLabel?.text = url_alias
            cell.detailTextLabel?.text = url
            return cell
        

    }
}

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        let url = urlsArr[indexPath.row]
        let vc = ShowDataViewController()
        vc.setup(apiUrl: url)
        navigationController?.pushViewController(vc, animated: true)

        //TODO: 여기서 채팅창에 url을 넘겨줘야함

    }
}

extension HomeViewController {
    private func requestStationName(){
//        self.urlsArr.append("newUrl")
//        self.urlsAlias.append("newUrlAlias")
        print("revised")
        //테이블 뷰 다시 그려줌
        self.urlTableView.reloadData()
        }
}

