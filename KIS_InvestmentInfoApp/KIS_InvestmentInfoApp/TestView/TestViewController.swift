//
//  TestViewController.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/02.
//


import UIKit
import SnapKit
import Alamofire

class TestViewController: UIViewController {
   
    private var erData: [ExchangeRateCellData] = []
    // ------------------------------ UI Components ------------------------------ //
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0.0
        return stackView
    }()
    
    
    let getDataButton = UIButton()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
//        tableView.delegate = self
        
        return tableView
    }()
    
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
//        view.backgroundColor = .blue
    }
    
    func bind(){
        

    }
    
    
    func attribute(){
        view.backgroundColor = .yellow
        getDataButton.backgroundColor = UIColor(red: 155/255.0, green: 202/255.0, blue: 184/255.0, alpha: 1.0)
        getDataButton.setTitle("get!", for: .normal)
        getDataButton.addTarget(self, action: #selector(getfunc), for: .touchUpInside)
    }
    
    func layout(){
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            //가로를 고정시켜주어 세로스크롤 뷰가 된다.
            $0.width.equalToSuperview()
        }
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        [getDataButton, tableView].forEach{
            stackView.addArrangedSubview($0)
        }
        
        getDataButton.snp.makeConstraints{
            $0.leading.top.equalToSuperview()
            $0.height.equalTo(30)
            $0.width.equalTo(60)
        }
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(getDataButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(250)
        }
    }

    @objc func getfunc(){
        print("호출 버튼 클릭")
//        let result = GetERNetwork().getErData()
        requestAPI()
//        print(result)
    }

}

extension TestViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return erData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let er = erData[indexPath.row]
        cell.textLabel?.text = er.cur_nm
        cell.detailTextLabel?.text = er.bkpr
        return cell
    }
}

//extension TestViewController: UITableViewDelegate{
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let station = stations
//    }
//}

// network 함수 구현할 곳
extension TestViewController{
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

