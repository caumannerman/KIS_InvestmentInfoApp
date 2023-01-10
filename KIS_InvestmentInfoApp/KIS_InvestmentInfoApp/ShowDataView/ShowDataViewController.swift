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
    
    private var apiResultStr = ""
    
//    var records: [[String]] = (0 ..< 50).map { row in
//        (0 ..< 6).map {
//            column in
//            "Row \(row) columnssssssssdfdfaddffa \(column)"
//        }
//    }
    // 이것이 json String을 이용해 최종적으로 얻은 배열이라고 생각하고 개발중
    private var jsonResultArr: [[String]] = [
    ["col이름1", "col이름2", "col이름3", "col이름4", "col이름5", "col이름6", "col이름7", "col이름8", "col이름9", "col이름10", "col이름11", "col이름12"],
    ["row1값1", "row1값2", "row1값3", "row1값4", "row1값5", "row1값6", "row1값7", "row1값8", "row1값9", "row1값10", "row1값11", "row1값12"],
    ["row2값1", "row2값2", "row2값3", "row2값4", "row1값5", "row1값6", "row1값7", "row1값8", "row1값9", "row1값10", "row1값11", "row1값12"],
    ["row3값1", "row3값2", "row3값3", "row3값4", "row1값5", "row1값6", "row1값7", "row1값8", "row1값9", "row1값10", "row1값11", "row1값12"],
    ["row4값1", "row4값2", "row4값3", "row4값4", "row1값5", "row1값6", "row1값7", "row1값8", "row1값9", "row1값10", "row1값11", "row1값12"],
    ["row5값1", "row5값2", "row5값3", "row5값4", "row1값5", "row1값6", "row1값7", "row1값8", "row1값9", "row1값10", "row1값11", "row1값12"],
    ["row6값1", "row6값2", "row6값3", "row6값4", "row1값5", "row1값6", "row1값7", "row1값8", "row1값9", "row1값10", "row1값11", "row1값12"],
    ["row7값1", "row7값2", "row7값3", "row7값4", "row1값5", "row1값6", "row1값7", "row1값8", "row1값9", "row1값10", "row1값11", "row1값12"],
    ["row8값1", "row8값2", "row8값3", "row8값4", "row1값5", "row1값6", "row1값7", "row1값8", "row1값9", "row1값10", "row1값11", "row1값12"],
    ["row9값1", "row9값2", "row9값3", "row9값4", "row1값5", "row1값6", "row1값7", "row1값8", "row1값9", "row1값10", "row1값11", "row1값12"],
    ["row10값1", "row10값2", "row10값3", "row10값4", "row10값5", "row10값6", "row10값7", "row10값8", "row10값9", "row10값10", "row10값11", "row10값12"],
    ["row11값1", "row11값2", "row11값3", "row11값4", "row11값5", "row11값6", "row11값7", "row11값8", "row11값9", "row11값10", "row11값11", "row11값12"],
    ["row12값1", "row12값2", "row12값3", "row12값4", "row12값5", "row12값6", "row12값7", "row12값8", "row12값9", "row12값10", "row12값11", "row12값12"],
    ["row13값1", "row13값2", "row13값3", "row13값4", "row13값5", "row13값6", "row13값7", "row13값8", "row13값9", "row13값10", "row13값11", "row13값12"],
    ["row14값1", "row14값2", "row14값3", "row14값4", "row14값5", "row14값6", "row14값7", "row14값8", "row14값9", "row14값10", "row14값11", "row14값12"],
    ["row15값1", "row15값2", "row15값3", "row15값4", "row15값5", "row15값6", "row15값7", "row15값8", "row15값9", "row15값10", "row15값11", "row15값12"],
    ["row16값1", "row16값2", "row16값3", "row16값4", "row16값5", "row16값6", "row16값7", "row16값8", "row16값9", "row16값10", "row16값11", "row16값12"],
    ["row17값1", "row17값2", "row17값3", "row17값4", "row17값5", "row17값6", "row17값7", "row17값8", "row17값9", "row17값10", "row17값11", "row17값12"],
    ["row18값1", "row18값2", "row18값3", "row18값4", "row18값5", "row18값6", "row18값7", "row18값8", "row18값9", "row18값10", "row18값11", "row18값12"],
    ["row19값1", "row19값2", "row19값3", "row19값4", "row19값5", "row19값6", "row19값7", "row19값8", "row19값9", "row19값10", "row19값11", "row19값12"],
    ["row20값1", "row20값2", "row10값3", "row20값4", "row20값5", "row20값6", "row20값7", "row20값8", "row20값9", "row20값10", "row20값11", "row20값12"],
    ]
    
    
    var cellWidths: [CGFloat] = [ 180, 200, 180, 160, 200, 200 ]
    
    //JSon을 받아와 parsing한 뒤,
//    private var JsonRowCount: Int = 0
//    private var JsonColumnCount: Int = 0
    
    private var isClickedArr: [[Bool]] = []
   
    //TODO: dataTitles를 가져오는 api 항목에 맞게 따로 불러오는 기능 구현해야함
    private var dataTitles: [String] = ["cur_unit", "ttb", "tts", "deal_bas_r", "bkpr", "yy_efee_r", "ten_dd_efee_r", "kftc_bkpr", "kftc_deal_bas_r", "cur_nm", "cur_unit", "ttb", "tts", "deal_bas_r", "bkpr", "yy_efee_r", "ten_dd_efee_r", "kftc_bkpr", "kftc_deal_bas_r", "cur_nm"]
    private var erData: [ExchangeRateCellData] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = GridLayout()
        layout.cellHeight = 44
        layout.cellWidths = Array(repeating: CGFloat(200), count: jsonResultArr[0].count + 1)
        //layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
//        layout.minimumLineSpacing = 4
//        layout.minimumInteritemSpacing = 2
//        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.isDirectionalLockEnabled = true
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        collectionView.register(ShowDataViewCollectionViewCell.self, forCellWithReuseIdentifier: "ShowDataViewCollectionViewCell")
        collectionView.register(ShowDataViewCollectionViewCell.self, forCellWithReuseIdentifier: "ShowDataViewCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.backgroundColor = .systemBackground
        collectionView.layer.borderWidth = 1.0
        collectionView.layer.borderColor = UIColor.lightGray.cgColor
//        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    //TODO: 임시로 버튼 하나만 해놓은 것이고, 나중에 컬렉션뷰에 버튼들 가로로 나열해야함
    private lazy var pageButton: UIButton = {
        let button = UIButton()
        button.setTitle("1", for: .normal)
        button.backgroundColor = UIColor(red: 195/255.0, green: 222/255.0, blue: 194/255.0, alpha: 1.0)
        button.layer.borderColor = UIColor(red: 153/255.0, green: 76/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8.0
        button.addTarget(self, action: #selector(pageChangeButtonClicked), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var pageButton2: UIButton = {
        let button = UIButton()
        button.setTitle("2", for: .normal)
        button.backgroundColor = UIColor(red: 195/255.0, green: 222/255.0, blue: 194/255.0, alpha: 1.0)
        button.layer.borderColor = UIColor(red: 153/255.0, green: 76/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8.0
        button.addTarget(self, action: #selector(pageChangeButtonClicked), for: .touchUpInside)
        
        return button
    }()
    
    
    private lazy var pageButton3: UIButton = {
        let button = UIButton()
        button.setTitle("3", for: .normal)
        button.backgroundColor = UIColor(red: 195/255.0, green: 222/255.0, blue: 194/255.0, alpha: 1.0)
        button.layer.borderColor = UIColor(red: 153/255.0, green: 76/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8.0
        button.addTarget(self, action: #selector(pageChangeButtonClicked), for: .touchUpInside)
        
        return button
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
//        scrollView.backgroundColor = .yellow
//        contentView.backgroundColor = .green
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
//        tableView.backgroundColor = .lightGray
//        collectionView.backgroundColor = .systemYellow
    }
    
    func layout(){
//        view.addSubview(scrollView)
//        scrollView.snp.makeConstraints{
//            $0.top.equalTo(view.safeAreaLayoutGuide)
////            $0.bottom.leading.trailing.equalToSuperview()
//            $0.leading.trailing.equalToSuperview()
//            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(100)
//        }
//        scrollView.addSubview(contentView)
//        contentView.snp.makeConstraints{
//            $0.edges.equalToSuperview()
//            //세로를 고정시켜주어 세로스크롤 뷰가 된다.
//            $0.height.equalToSuperview()
//        }
//        contentView.addSubview(stackView)
//        stackView.snp.makeConstraints{
//            $0.edges.equalToSuperview()
//        }
        
        [collectionView].forEach{
            view.addSubview($0)
//            stackView.addArrangedSubview($0)
//            stackView.addSubview($0)
        }
        
        collectionView.snp.makeConstraints{
//            $0.edges.equalToSuperview()
            
//            $0.top.equalTo(getDataButton.snp.bottom)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(100)
//            $0.width.equalTo(scrollView.snp.width)
        }
        
//        tableView.snp.makeConstraints{
////            $0.edges.equalToSuperview()
//
////            $0.top.equalTo(getDataButton.snp.bottom)
//            $0.top.equalTo(view.safeAreaLayoutGuide)
//            $0.leading.equalToSuperview()
//            $0.trailing.equalToSuperview()
//            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(100)
////            $0.width.equalTo(scrollView.snp.width)
//        }
//
        [pageButton, pageButton2, pageButton3, callButton, saveButton].forEach{
            view.addSubview($0)
        }
        
        pageButton.snp.makeConstraints{
            $0.top.equalTo(collectionView.snp.bottom).offset(10)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.leading.equalToSuperview().inset(60)
            $0.width.equalTo(20)
            $0.height.equalTo(20)
        }
        
        pageButton2.snp.makeConstraints{
            $0.top.equalTo(collectionView.snp.bottom).offset(10)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.leading.equalTo(pageButton.snp.trailing).offset(6)
            $0.width.equalTo(20)
            $0.height.equalTo(20)
        }
        
        pageButton3.snp.makeConstraints{
            $0.top.equalTo(collectionView.snp.bottom).offset(10)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.leading.equalTo(pageButton2 .snp.trailing).offset(6)
            $0.width.equalTo(20)
            $0.height.equalTo(20)
        }
        
        
        callButton.snp.makeConstraints{
            $0.top.equalTo(pageButton.snp.bottom).offset(12)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.equalToSuperview().inset(60)
            $0.width.equalTo(120)
//            $0.height.equalTo(40)
        }
        
        saveButton.snp.makeConstraints{
            $0.top.equalTo(pageButton.snp.bottom).offset(12)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.trailing.equalToSuperview().inset(60)
            $0.width.equalTo(120)
//            $0.height.equalTo(40)
        }
//        callButton.snp.makeConstraints{
//            $0.top.equalTo(tableView.snp.bottom).offset(20)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
//            $0.leading.equalToSuperview().inset(60)
//            $0.width.equalTo(120)
////            $0.height.equalTo(40)
//        }
//
//        saveButton.snp.makeConstraints{
//            $0.top.equalTo(tableView.snp.bottom).offset(20)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
//            $0.trailing.equalToSuperview().inset(60)
//            $0.width.equalTo(120)
////            $0.height.equalTo(40)
//        }
        
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
        print("호출완료!!!!")
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
    
    @objc func pageChangeButtonClicked(){
        print("페이지 변경 버튼 클릭")
    }
}


extension ShowDataViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return records.count
        return self.jsonResultArr.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return records[section].count
        return self.jsonResultArr[0].count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowDataViewCollectionViewCell", for: indexPath) as? ShowDataViewCollectionViewCell else { return UICollectionViewCell() }
        let isFirstRow: Bool = (indexPath.section == 0)
        let isFirstColumn: Bool = (indexPath.row == 0)
        
        
        if !isFirstColumn{
            let now_title: String = jsonResultArr[indexPath.section][indexPath.row - 1]
            cell.setup(isFirstRow: isFirstRow, isFirstColumn: isFirstColumn, title: now_title)
//            cell.setup(isFirstRow: isFirstRow, isFirstColumn: isFirstColumn, title: "sct = " + String(indexPath.section) + "idx = " + String(indexPath.item))
        }
        else{
            cell.setup(isFirstRow: isFirstRow, isFirstColumn: isFirstColumn, title: String(indexPath.section))
        }
//        cell.setRecord(records[indexPath.section][indexPath.item])
       

        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        erData.count * 4
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowDataViewCollectionViewCell", for: indexPath) as? ShowDataViewCollectionViewCell else { return UICollectionViewCell() }
////        let a = indexPath.row
//        if indexPath.row == 0 {
//            cell.setup(isFirstRow: true, isFirstColumn: true, title: "선택")
//        }
//        //첫 열
//        else if indexPath.row > 0 && indexPath.row <= numRow{
//            cell.setup(isFirstRow: false, isFirstColumn: true, title: String(indexPath.row))
//        }
//        //첫 행
//        else if indexPath.row % ( numRow + 1) == 0 {
//            let now_title_sunseo_idx = indexPath.row / ( numRow + 1) - 1
//            cell.setup(isFirstRow: true, isFirstColumn: false, title: dataTitles[now_title_sunseo_idx])
//        }
//        //일반 cell
//        else{
//            cell.setup(isFirstRow: false, isFirstColumn: false, title: "일반")
//        }
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let height = ( (collectionView.frame.height - CGFloat(numRow * 2)) / CGFloat(numRow + 1) )
//        let width = height * 2
////                let itemsPerRow: CGFloat = 2
////                let widthPadding = sectionInsets.left * (itemsPerRow + 1)
////                let itemsPerColumn: CGFloat = 3
////                let heightPadding = sectionInsets.top * (itemsPerColumn + 1)
////                let cellWidth = (width - widthPadding) / itemsPerRow
////                let cellHeight = (height - heightPadding) / itemsPerColumn
//
//        return CGSize(width: width, height: height)
//    }

}

// 원래 쓰던 TableView datasource
//extension ShowDataViewController: UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return erData.count + 1
//        return 10
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == 0 {
//            return UITableViewCell()
//        }
////        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
////        let er = erData[indexPath.row - 1]
////        cell.textLabel?.text = er.cur_nm
////        cell.detailTextLabel?.text = er.bkpr
////        return cell
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonListViewCell", for: indexPath) as? ButtonListViewCell else { return UITableViewCell() }
//
//        cell.setup()
//
//        return cell
//    }
//}

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
        
        let aaa = AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .response(){ [weak self] response in
                guard
                    let self = self,
                    case .success(let data) = response.result else { return }
                let str = String(decoding: data!, as: UTF8.self)
                self.apiResultStr = str
                print("nownownow!!!!!!!!!!")
                print(str)
                
            }
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

                print( "총 row 수 = " + String(self.erData.count))
                print( "0번째 인덱스 " )
                print( self.erData[0] )
//                self.JsonRowCount = self.erData.count
//                self.JsonColumnCount = 20
//                self.isClickedArr = Array(repeating: Array(repeating: false ,count: self.JsonColumnCount), count: self.JsonRowCount)
//                print("isClickedArr row길이 =")
//                print( self.isClickedArr.count)
//                print("isClickedArr column길이 =")
//                print( self.isClickedArr[0].count)

                //테이블 뷰 다시 그려줌
                self.collectionView.reloadData()
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
