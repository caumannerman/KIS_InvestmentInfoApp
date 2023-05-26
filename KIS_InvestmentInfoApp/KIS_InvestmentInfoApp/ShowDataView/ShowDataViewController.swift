//
//  ShowDataViewController.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/02.
//

import UIKit
import SnapKit
import Alamofire

enum ButtonMode{
    case GetData
    case SaveData
}

class ShowDataViewController: UIViewController {
    
    
    private var buttonMode: ButtonMode = .GetData
    // ----------------------------------------------------------------------------- 저장 시 Alert 관련 -----
    //저장할 파일의 이름을 담을 변수
    private var saveFileName: String = ""
    //저장 파일 이름 받아올 UIAlert
    private let alert = UIAlertController(title: "파일 제목", message: "저장할 파일의 이름을 입력해주세요", preferredStyle: .alert)
    private var ok = UIAlertAction()
    private var cancel = UIAlertAction()
    // ----------------------------------------------------------------------------- 저장 시 Alert 관련 -----
    //조회할 URL (이전 페이지에서 받아오는 것)
    private var apiUrl: String = ""
    
    
    private var apiResultStr = ""
    
    // ----------------------------------------------------------------------------- 임시 --------------------------------------------------------------------------- //
    
    // 이것이 json String을 이용해 최종적으로 얻은 배열이라고 생각하고 개발중
    private var jsonResultArr: [[String]] = DummyClass.getJsonResultArr()
    
    private var isClickedArr_row: [Bool] = [true, false, false, true, false, false, false, true, true, false, true, false, false, false, true, false, true, false, false, true]
    private var isClickedArr_col: [Bool] = [false, false,true, true, false, false, false, true, false, false, true, true, ]
//    private var jsonResultArr: [[String]] = [[]]
//    private var isClickedArr_row: [Bool] = []
//    private var isClickedArr_col: [Bool] = []
    //선택을 했는지 여부 동기화를 위한 배열
//    private var isClickedArr_row: [Bool] = Array(repeating: false, count: 20)
//    private var isClickedArr_col: [Bool] = Array(repeating: false, count: 12)
    

    
    // ----------------------------------------------------------------------------- 임시 --------------------------------------------------------------------------- //
    
    //JSon을 받아와 parsing한 뒤,
//    private var JsonRowCount: Int = 0
//    private var JsonColumnCount: Int = 0
    
   
   
    //TODO: dataTitles를 가져오는 api 항목에 맞게 따로 불러오는 기능 구현해야함
//    private var dataTitles: [String] = ["cur_unit", "ttb", "tts", "deal_bas_r", "bkpr", "yy_efee_r", "ten_dd_efee_r", "kftc_bkpr", "kftc_deal_bas_r", "cur_nm", "cur_unit", "ttb", "tts", "deal_bas_r", "bkpr", "yy_efee_r", "ten_dd_efee_r", "kftc_bkpr", "kftc_deal_bas_r", "cur_nm"]
//    private var erData: [ExchangeRateCellData] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = GridLayout()
        layout.cellHeight = 44
        layout.cellWidths = Array(repeating: CGFloat(200), count: jsonResultArr[0].count + 1)

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
    
    
    private let get_save_view = UIView()
    private lazy var callDataButton = UIButton()
    private lazy var saveCsvButton = UIButton()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.collectionView.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.isHidden = true
        view.backgroundColor = .systemBackground
        NotificationCenter.default.addObserver(self, selector: #selector(changeCellColor(_:)), name: .cellColorChange, object: nil)
        setNavigationItems()
       

        alert.addTextField{
            $0.placeholder = "저장 파일명을 입력하세요"
            $0.isSecureTextEntry = false
        }
        
        //아래처럼, 사용자가 제목을 입력하고, ok버튼을 누르면 해당 제목을 변수에 저장한 후, createCSV()를 호출하여 csv파일을 생성한다.
        ok = UIAlertAction(title: "OK", style: .default){
            action in print("OK")
            // 저장할 파일 ㅇ제목을 받고
            self.saveFileName = self.alert.textFields?[0].text ?? "Untitled"
            print("저장 파일 이름 = ")
            print(self.saveFileName)
            //TODO: 아래에서 핸드폰에 csv를 저장해야함
            print("저장!!!!")
            let resultString = self.sliceArrayAndReturnCSVString(s: self.jsonResultArr, isCheck_col: self.isClickedArr_col, isCheck_row: self.isClickedArr_row )
            self.createCSV(csvString: resultString)
        }
        cancel = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(ok)
        alert.addAction(cancel)
//        scrollView.backgroundColor = .yellow
//        contentView.backgroundColor = .green
    }
    
    private func createCSV(csvString: String) {
        print("Start Exporting ...")
        
        let fileManager = FileManager.default
        
        let folderName = "KIS_Finance_Info"
//        let csvFileName = "myCSVFile.csv"
        
        // 폴더 생성 documentDirectory userDomainMask
        let documentUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let directoryUrl = documentUrl.appendingPathComponent(folderName)
        do {
            try fileManager.createDirectory(atPath: directoryUrl.path, withIntermediateDirectories: true, attributes: nil)
        }
        catch let error as NSError {
            print("폴더 생성 에러: \(error)")
        }
        
        // csv 파일 생성
        let fileUrl = directoryUrl.appendingPathComponent(saveFileName + ".csv")
        let fileData = csvString.data(using: .utf8)
        
        do {
            try fileData?.write(to: fileUrl)
            
            print("Writing CSV to: \(fileUrl.path)")
        }
        catch let error as NSError {
            print("CSV파일 생성 에러!: \(error)")
        }
    }
    
    @objc func changeCellColor(_ notification: NSNotification){
        
        print(notification.userInfo!["row"]!)
        print(notification.userInfo!["col"]!)
        
        let now_row = notification.userInfo!["row"] as? Int
        let now_col = notification.userInfo!["col"] as? Int
        
        print(type(of:notification.userInfo!["row"]!))
        print(type(of:notification.userInfo!["col"]!))
        //첫 행인 경우
        if now_row == -1{
          isClickedArr_col[now_col!] = !isClickedArr_col[now_col!]
        }// 첫 열인 경우
        else if now_col == -2 {
            isClickedArr_row[now_row!] = !isClickedArr_row[now_row!]
        }
        
        print("isClickedArr_row 는!!!!!")
        print(isClickedArr_row)
        print("isClickedArr_col 는!!!!!")
        print(isClickedArr_col)
    }
    
    private func setNavigationItems(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "URL 응답 데이터"
        // "This,is,just,some,dummy,data\n11,22,33,44,55,66,777"
        
    }
    //api 주소를 잘 전달했다는 것을 보여주기 위한 것
    func setup(apiUrl: String){
//        print(apiUrl)
        self.apiUrl = apiUrl
        
//        saveButton.setTitle(apiUrl, for: .normal)
    }
    func bind(){

    }
    
    func attribute(){
        view.backgroundColor = .systemBackground

        get_save_view.backgroundColor = UIColor(red: 210/255.0, green: 220/255.0, blue: 250/255.0, alpha: 1.0)
        
        callDataButton.backgroundColor = .white
        callDataButton.setTitle("데이터 불러오기", for: .normal)
        callDataButton.titleLabel?.font = .systemFont(ofSize: 28, weight: .bold)
        callDataButton.setTitleColor(.black, for: .normal)
        callDataButton.addTarget(self, action: #selector(get_or_save_func), for: .touchUpInside)
        callDataButton.layer.cornerRadius = 12.0
        callDataButton.layer.borderWidth = 3.0
        callDataButton.layer.borderColor = UIColor.lightGray.cgColor
        
//        saveCsvButton.backgroundColor = .white
//
//        saveCsvButton.titleLabel?.font = .systemFont(ofSize: 28, weight: .bold)
//        saveCsvButton.setTitleColor(.black, for: .normal)
//        saveCsvButton.addTarget(self, action: #selector(savefunc), for: .touchUpInside)
//        saveCsvButton.layer.cornerRadius = 12.0
//        saveCsvButton.layer.borderWidth = 3.0
//        saveCsvButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func layout(){
        
        [collectionView, get_save_view].forEach{
            view.addSubview($0)
//            stackView.addArrangedSubview($0)
//            stackView.addSubview($0)
        }
        
        collectionView.snp.makeConstraints{
//            $0.edges.equalToSuperview()
            
//            $0.top.equalTo(getDataButton.snp.bottom)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(100)
//            $0.width.equalTo(scrollView.snp.width)
        }
        get_save_view.snp.makeConstraints{
            $0.top.equalTo(collectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(100)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        [callDataButton, saveCsvButton].forEach{
            get_save_view.addSubview($0)
        }

        callDataButton.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(6)
            $0.leading.equalToSuperview().inset(10)
         
//            $0.trailing.equalTo( get_save_view.snp.center).offset(-10)
//            $0.width.equalTo((UIScreen.main.bounds.midY - 40) / 2 )
            $0.trailing.equalToSuperview().inset(10)
        }
        
//        saveCsvButton.snp.makeConstraints{
//            $0.top.bottom.equalToSuperview().inset(6)
//            $0.trailing.equalToSuperview().inset(10)
//
//            $0.leading.equalTo(callDataButton.snp.center )
////            $0.leading.equalTo( get_save_view.snp.center).offset(10)
////            $0.width.equalTo((UIScreen.main.bounds.width - 40) / 2 )
//        }
    }

    @objc func get_or_save_func(){
        switch buttonMode {
        case .GetData:
            print("호출 버튼 클릭")
    //        let result = GetERNetwork().getErData()
            requestAPI()
            print("호출완료!!!!")
            buttonMode = .SaveData
            callDataButton.setTitle("저장하기", for: .normal)
        default:
            print("저장 버튼 클릭")
            self.present(alert, animated: true){
                print("alert 띄움")
            }
        }
    }
    
    
    func sliceArrayAndReturnCSVString(s: [[String]], isCheck_col: [Bool], isCheck_row: [Bool] ) -> String{
        
        var result: String = ""

        for i in 0 ..< s.count{
            if i > 0 && !isCheck_row[i - 1]{
                continue
            }
            for j in 0 ..< s[0].count{
                if i == 0 {
                    if isCheck_col[j]{
                        result += String(s[i][j])
                        if j != s[0].count - 1{
                            result += ","
                        }
                    }
                }
                else{
                    if isCheck_col[j] {
                        result += String(s[i][j])
                        if j != s[0].count - 1{
                            result += ","
                        }
                    }
                }
            }
            result += "\n"
        }
        return result
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
            if isFirstRow{
                cell.setup(isFirstRow: isFirstRow, isFirstColumn: isFirstColumn, title: now_title, isClicked: isClickedArr_col[indexPath.row - 1], rowIdx: -1, colIdx: indexPath.row - 1)
            }// FirstColumn도 FirstRow도 아닌 경우는 클릭 X
            else{
                cell.setup(isFirstRow: isFirstRow, isFirstColumn: isFirstColumn, title: now_title, isClicked: false, rowIdx: -3, colIdx: -3)
            }
        }
        //FirstColumn인 경우
        else{
            //여기는 firstCol이자 firstRow이므로
            if isFirstRow{
                cell.setup(isFirstRow: isFirstRow, isFirstColumn: isFirstColumn, title: String(indexPath.section), isClicked: false, rowIdx: 0, colIdx: 0)
            }
            else{
                cell.setup(isFirstRow: isFirstRow, isFirstColumn: isFirstColumn, title: String(indexPath.section), isClicked: isClickedArr_row[indexPath.section - 1], rowIdx: indexPath.section - 1, colIdx: -2)
            }
            
        }
//        cell.setRecord(records[indexPath.section][indexPath.item])
        return cell
    }
}


// network 함수 구현할 곳
extension ShowDataViewController{
    private func requestAPI(){
//        let url = "https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=BlCJAvGJ4IuXS30CPGMFIjQpiCuDTbjb&searchdate=20221227&data=AP01"
        let url = self.apiUrl
        //addingPercentEncoding은 한글(영어 이외의 값) 이 url에 포함되었을 때 오류나는 것을 막아준다.
        
        let aaa = AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .response(){ [weak self] response in
                guard
                    let self = self,
                    case .success(let data) = response.result else { return }
                //str이, 받아온 json을 형태 그대로 STring으로 만든 것이다.
                let str = String(decoding: data!, as: UTF8.self)
                self.apiResultStr = str
                self.jsonResultArr = JsonParser.jsonToArr(jsonString: str)
                print(self.jsonResultArr)
                self.isClickedArr_col = Array(repeating: false, count: self.jsonResultArr[0].count)
                self.isClickedArr_row = Array(repeating: false, count: self.jsonResultArr.count - 1)

//                //테이블 뷰 다시 그려줌
                self.collectionView.isHidden = false
                self.collectionView.reloadData()
            }
            .resume()
    }
}

