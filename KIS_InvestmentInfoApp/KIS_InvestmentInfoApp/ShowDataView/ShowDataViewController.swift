//
//  ShowDataViewController.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/02.
//

import UIKit
import SnapKit
import Alamofire

class ShowDataViewController: UIViewController {
    
    //TODO: dataTitles를 가져오는 api 항목에 맞게 따로 불러오는 기능 구현해야함
    private var dataTitles: [String] = ["cur_unit", "ttb", "tts", "deal_bas_r", "bkpr", "yy_efee_r", "ten_dd_efee_r", "kftc_bkpr", "kftc_deal_bas_r", "cur_nm"]
    private var erData: [ExchangeRateCellData] = []
    // ------------------------------ UI Components ------------------------------ //
    
//    private let scrollView = UIScrollView()
//    private let contentView = UIView()
//
//    private lazy var stackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.distribution = .fill
//        stackView.spacing = 0.0
//        return stackView
//    }()
//
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
//        tableView.delegate = self
        tableView.backgroundColor = .yellow
        tableView.register(ButtonListViewCell.self, forCellReuseIdentifier: "ButtonListViewCell")
        tableView.rowHeight = 30
        return tableView
    }()
    
    private lazy var callButton: UIButton = {
        let button = UIButton()
        button.setTitle("Call", for: .normal)
        button.backgroundColor = UIColor(red: 195/255.0, green: 222/255.0, blue: 194/255.0, alpha: 1.0)
        button.layer.borderColor = UIColor(red: 153/255.0, green: 76/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        button.layer.borderWidth = 2.0
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(getfunc), for: .touchUpInside)
        
        return button
        
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = UIColor(red: 195/255.0, green: 222/255.0, blue: 194/255.0, alpha: 1.0)
        button.layer.borderColor = UIColor(red: 153/255.0, green: 76/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        button.layer.borderWidth = 2.0
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(savefunc), for: .touchUpInside)
        
        return button
        
    }()
    
   
    
//    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//
////        collectionView.delegate = self
////        collectionView.dataSource = self
//        collectionView.backgroundColor = .systemPink
//
//        collectionView.register(ButtonListViewCell.self, forCellWithReuseIdentifier: "ButtonListViewCell")
//        return collectionView
//    }()
//
 
    
    // ------------------------------ UI Components ------------------------------ //
    
    // ------------------------------ Rx Traits ------------------------------ //
    
    
    // ------------------------------ Rx Traits ------------------------------ //
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setNavigationItems()
    }
    
    private func setNavigationItems(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "URL 응답 데이터"

        
//        let searchController = UISearchController()
//        searchController.searchBar.placeholder = "요청 URL을 입력해주세요"
//        //화면 어두워지지 않도록 false 처리
//        searchController.obscuresBackgroundDuringPresentation = false
        
    }
    //api 주소를 잘 전달했다는 것을 보여주기 위한 것
    func setup(apiUrl: String){
        print(apiUrl)
//        saveButton.setTitle(apiUrl, for: .normal)
    }
    func bind(){
        

    }
    
    
    func attribute(){
        view.backgroundColor = .systemBackground
        tableView.backgroundColor = .lightGray
//        collectionView.backgroundColor = .systemYellow
        
    }
    
    func layout(){
//        view.addSubview(scrollView)
//        scrollView.snp.makeConstraints{
//            $0.top.equalTo(view.safeAreaLayoutGuide)
//            $0.bottom.leading.trailing.equalToSuperview()
//        }
//        scrollView.addSubview(contentView)
//        contentView.snp.makeConstraints{
//            $0.edges.equalToSuperview()
//            //가로를 고정시켜주어 세로스크롤 뷰가 된다.
//            $0.width.equalToSuperview()
//        }
//        contentView.addSubview(stackView)
//        stackView.snp.makeConstraints{
//            $0.edges.equalToSuperview()
//        }
        
        [tableView, callButton, saveButton].forEach{
            view.addSubview($0)
        }
        
        tableView.snp.makeConstraints{
//            $0.top.equalTo(getDataButton.snp.bottom)
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(100)
        }
        
        callButton.snp.makeConstraints{
            $0.top.equalTo(tableView.snp.bottom).offset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.leading.equalToSuperview().inset(60)
            $0.width.equalTo(120)
//            $0.height.equalTo(40)
        }
        
        saveButton.snp.makeConstraints{
            $0.top.equalTo(tableView.snp.bottom).offset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.trailing.equalToSuperview().inset(60)
            $0.width.equalTo(120)
//            $0.height.equalTo(40)
        }
        
//        collectionView.snp.makeConstraints{
//            $0.top.equalTo(tableView.snp.bottom)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(500)
//        }
    }

    @objc func getfunc(){
        print("호출 버튼 클릭")
//        let result = GetERNetwork().getErData()
        requestAPI()
//        print(result)
    }
    
    @objc func savefunc(){
        print("저장 버튼 클릭")
        //TODO: csv로 저장하는 것
//        DispatchQueue.main.async{ [weak self] in
//            guard let currentCell = self?.tableView.cellForRow(at: IndexPath(index: 1)) as? ButtonListViewCell else { return }
//            currentCell.collectionView.
//        }
    }

}

extension ShowDataViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return erData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return UITableViewCell()
        }
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
//        let er = erData[indexPath.row - 1]
//        cell.textLabel?.text = er.cur_nm
//        cell.detailTextLabel?.text = er.bkpr
//        return cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonListViewCell", for: indexPath) as? ButtonListViewCell else { return UITableViewCell() }
        
        cell.setup()
        
        return cell
    }
}

//extension TestViewController: UITableViewDelegate{
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let station = stations
//    }
//}

// network 함수 구현할 곳
extension ShowDataViewController{
    private func requestAPI(){
        let url = "https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=BlCJAvGJ4IuXS30CPGMFIjQpiCuDTbjb&searchdate=20221227&data=AP01"
        //addingPercentEncoding은 한글(영어 이외의 값) 이 url에 포함되었을 때 오류나는 것을 막아준다.
        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: [ExchangeRate].self){ [weak self] response in
                // success 이외의 응답을 받으면, else문에 걸려 함수 종료
                guard
                    let self = self,
                    case .success(let data) = response.result else { return }
                //데이터 받아옴
                self.erData = data.map{ er -> ExchangeRateCellData in
                    let temp = ExchangeRateCellData(cur_unit: er.cur_unit, ttb: er.ttb, tts: er.tts, deal_bas_r: er.deal_bas_r, bkpr: er.bkpr, yy_efee_r: er.yy_efee_r, ten_dd_efee_r: er.ten_dd_efee_r, kftc_bkpr: er.kftc_bkpr, kftc_deal_bas_r: er.kftc_deal_bas_r, cur_nm: er.cur_nm)
                    return temp
                }
                //테이블 뷰 다시 그려줌
                self.tableView.reloadData()
            }
            .resume()
    }
}

//extension ShowDataViewController: UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonListViewCell", for: indexPath) as? ButtonListViewCell else { return UICollectionViewCell()}
//
//        let now_data = erData[indexPath.item]
//        cell.setup
//    }
//}
