//
//  Former_ChartViewController.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/24.
//

import UIKit
import Charts
import SnapKit
import Alamofire
import SwiftUI
//
////날짜정보 / 종목코드 / 종목명 / 상장시장명 / 시가 / 종가 / 최고가 / 최저가
//class Former_ChartViewController: UIViewController {
//
//
//    // ---------------------======================== Variables ========================--------------------- //
//
//    //저장할 파일의 이름을 담을 변수
//    private var saveFileName: String = ""
//    //저장 파일 이름 받아올 UIAlert
//    private let alert = UIAlertController(title: "파일 제목", message: "저장할 파일의 이름을 입력해주세요", preferredStyle: .alert)
//    private var ok = UIAlertAction()
//    private var cancel = UIAlertAction()
//
//    private var apiResultStr = ""
//    // 이것이 json String을 이용해 최종적으로 얻은 배열이라고 생각하고 개발중
//    private var jsonResultArr: [[String]] = DummyClass.getJsonResultArr()
//
//    private var isClickedArr_row: [Bool] = [true, false, false, true, false, false, false, true, true, false, true, false, false, false, true, false, true, false, false, true]
//    private var isClickedArr_col: [Bool] = [false, false,true, true, false, false, false, true, false, false, true, true, ]
//
//
//    var api_result: String = ""
//
//    // 원하는 기간의 주가정보를 받아와 저장할 배열
//    private var securityDataArr: [SecurityDataCellData] = []
//
//    // Identifiable 프로토콜을 따르는 [SecurityInfo] 배열, SwiftUI view로 넘겨줘야함
//    private var securityInfoArr: [SecurityInfo] = []
//    // SiteView를 따르는 것 시가/종가/ 최저가 /최고가
//    private var mkpInfoArr: [SiteView] = []
//    private var clprInfoArr: [SiteView] = []
//    private var hiprInfoArr: [SiteView] = []
//    private var loprInfoArr: [SiteView] = []
//
//    private var now_section_idx: Int = 0
//    private var now_subSection_idx: Int = 0
//    // ---------------------========================----------------========================--------------------- //
//
//
//    // ---------------------======================== UI Components ========================--------------------- //
//
//    let requestButton: UIButton = {
//        let btn = UIButton()
//        btn.layer.cornerRadius = 8.0
//        btn.layer.borderWidth = 2.0
//        btn.layer.borderColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0).cgColor
//        btn.backgroundColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 244/255.0, alpha: 1.0)
//        btn.setTitle("조회", for: .normal)
////        btn.setTitleColor(.black, for: .normal)
//        btn.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .semibold)
//        btn.addTarget(self, action: #selector(reqButtonClicked), for: .touchUpInside)
//        return btn
//    }()
//
//    let saveButton: UIButton = {
//        let btn = UIButton()
//        btn.layer.cornerRadius = 8.0
//        btn.layer.borderWidth = 2.0
//        btn.layer.borderColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0).cgColor
//        btn.backgroundColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 244/255.0, alpha: 1.0)
//        btn.setTitle("CSV 저장", for: .normal)
////        btn.setTitleColor(.black, for: .normal)
//        btn.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .bold)
//        btn.addTarget(self, action: #selector(savefunc), for: .touchUpInside)
//        return btn
//    }()
//    @objc func savefunc(){
//        print("저장 버튼 클릭")
//        self.present(alert, animated: true){
//            print("alert 띄움")
//        }
//    }
//
//    let showChartButton: UIButton = {
//        let btn = UIButton()
//        btn.layer.cornerRadius = 8.0
//        btn.layer.borderWidth = 2.0
//        btn.layer.borderColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0).cgColor
//        btn.backgroundColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 244/255.0, alpha: 1.0)
//        btn.setTitle("차트 보기", for: .normal)
////        btn.setTitleColor(.black, for: .normal)
//        btn.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .bold)
//        btn.addTarget(self, action: #selector(showChartButtonClicked), for: .touchUpInside)
//        return btn
//    }()
//
//
//
//    private lazy var collectionView: UICollectionView = {
//        let layout = GridLayout()
//        layout.cellHeight = 44
//        layout.cellWidths = Array(repeating: CGFloat(120), count: jsonResultArr[0].count + 1)
//        //layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
////        layout.minimumLineSpacing = 4
////        layout.minimumInteritemSpacing = 2
////        layout.scrollDirection = .horizontal
//
//        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
//        collectionView.isDirectionalLockEnabled = true
//        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
////        collectionView.register(ShowDataViewCollectionViewCell.self, forCellWithReuseIdentifier: "ShowDataViewCollectionViewCell")
//        collectionView.register(ShowDataViewCollectionViewCell.self, forCellWithReuseIdentifier: "ShowDataViewCollectionViewCell")
//        collectionView.dataSource = self
//        collectionView.delegate = self
////        collectionView.isPagingEnabled = true
//        collectionView.showsHorizontalScrollIndicator = true
//        collectionView.backgroundColor = .systemBackground
//        collectionView.layer.borderWidth = 1.0
//        collectionView.layer.borderColor = UIColor.lightGray.cgColor
////        collectionView.isScrollEnabled = false
//        return collectionView
//    }()
//
//
//
//
//
//    // ---------------------=================-------------------------=================--------------------- //
//
//
//    // 차트 시작 전 입력받아야하는 것들 //
//    private var securityName: String = ""
//    private var strategyValye: String = ""
//    private var startDate: Date?
//    private var endDate: Date?
//    // 차트 시작 전 입력받아야하는 것들 //
//
//    private var purchaseDate: Date?
//    private var sellDate: Date?
//    private var topProfitDate: Date?
//    private var worstProfitDate: Date?
//
//    //PickerView를 종료하기 위한 콜백함수
//    @objc func pickerExit(){
////        self.strategyTextField.text = nil
//        self.view.endEditing(true)
//    }
//    @objc func pickerDone(){
//        self.view.endEditing(true)
//    }
//
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        itemNmTextField.tag = 1
//        // strategyPicker를 꾸밈
////        let exitButton = UIBarButtonItem(title: "exit", style: .plain, target: self, action: #selector(pickerExit))
//        let doneBT = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.pickerDone))
//        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let cancelBT = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.pickerExit))
//
//        let toolBar = UIToolbar()
//        toolBar.tintColor = .systemBrown
//        toolBar.isTranslucent = true
//        toolBar.sizeToFit()
//        toolBar.setItems([cancelBT,flexibleSpace,doneBT], animated: false)
//        toolBar.isUserInteractionEnabled = true
//
////        strategyTextField.inputAccessoryView = toolBar
////        strategyTextField.inputView = strategyPicker
//
//        setNavigationItems()
//
//        attribute()
//        layout()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        self.collectionView.isHidden = true
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.collectionView.isHidden = true
//
//        // 이것은 csv의 row, column을 선택할 때 관련한 noti
//        NotificationCenter.default.addObserver(self, selector: #selector(changeCellColor(_:)), name: .cellColorChange, object: nil)
//
//
//
//        alert.addTextField{
//            $0.placeholder = "저장 파일명을 입력하세요"
//            $0.isSecureTextEntry = false
//        }
//
//        //아래처럼, 사용자가 제목을 입력하고, ok버튼을 누르면 해당 제목을 변수에 저장한 후, createCSV()를 호출하여 csv파일을 생성한다.
//        ok = UIAlertAction(title: "OK", style: .default){
//            action in print("OK")
//            // 저장할 파일 ㅇ제목을 받고
//            self.saveFileName = self.alert.textFields?[0].text ?? "Untitled"
//            print("저장 파일 이름 = ")
//            print(self.saveFileName)
//            //TODO: 아래에서 핸드폰에 csv를 저장해야함
//            print("저장!!!!")
//            let resultString = self.sliceArrayAndReturnCSVString(s: self.jsonResultArr, isCheck_col: self.isClickedArr_col, isCheck_row: self.isClickedArr_row )
//            self.createCSV(csvString: resultString)
//        }
//        cancel = UIAlertAction(title: "Cancel", style: .destructive)
//        alert.addAction(ok)
//        alert.addAction(cancel)
//
//    }
//
//    @objc func didTapItemSubSectionCell_Chart(_ notification: Notification) {
//        guard let clickedIdx = notification.userInfo?["idx"] as? Int else { return }
//        now_subSection_idx = clickedIdx
//        print("현재 선택된 section & subSection", now_section_idx, now_subSection_idx)
//
//    }
//
//
//
//
//
//    private func createCSV(csvString: String) {
//        print("Start Exporting ...")
//
//        let fileManager = FileManager.default
//
//        let folderName = "KIS_Finance_Info"
////        let csvFileName = "myCSVFile.csv"
//
//        // 폴더 생성 documentDirectory userDomainMask
//        let documentUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let directoryUrl = documentUrl.appendingPathComponent(folderName)
//        do {
//            try fileManager.createDirectory(atPath: directoryUrl.path, withIntermediateDirectories: true, attributes: nil)
//        }
//        catch let error as NSError {
//            print("폴더 생성 에러: \(error)")
//        }
//
//        // csv 파일 생성
//        let fileUrl = directoryUrl.appendingPathComponent(saveFileName + ".csv")
//        let fileData = csvString.data(using: .utf8)
//
//        do {
//            try fileData?.write(to: fileUrl)
//
//            print("Writing CSV to: \(fileUrl.path)")
//        }
//        catch let error as NSError {
//            print("CSV파일 생성 에러: \(error)")
//        }
//    }
//    func sliceArrayAndReturnCSVString(s: [[String]], isCheck_col: [Bool], isCheck_row: [Bool] ) -> String{
//
//        var result: String = ""
//
//        for i in 0 ..< s.count{
//            if i > 0 && !isCheck_row[i - 1]{
//                continue
//            }
//            for j in 0 ..< s[0].count{
//                if i == 0 {
//                    if isCheck_col[j]{
//                        result += String(s[i][j])
//                        if j != s[0].count - 1{
//                            result += ","
//                        }
//                    }
//                }
//                else{
//                    if isCheck_col[j] {
//                        result += String(s[i][j])
//                        if j != s[0].count - 1{
//                            result += ","
//                        }
//                    }
//                }
//            }
//            result += "\n"
//        }
//        return result
//    }
//
//    @objc func changeCellColor(_ notification: NSNotification){
//
//        print(notification.userInfo!["row"]!)
//        print(notification.userInfo!["col"]!)
//
//        let now_row = notification.userInfo!["row"] as? Int
//        let now_col = notification.userInfo!["col"] as? Int
//
//        print(type(of:notification.userInfo!["row"]!))
//        print(type(of:notification.userInfo!["col"]!))
//        //첫 행인 경우
//        if now_row == -1{
//          isClickedArr_col[now_col!] = !isClickedArr_col[now_col!]
//        }// 첫 열인 경우
//        else if now_col == -2 {
//            isClickedArr_row[now_row!] = !isClickedArr_row[now_row!]
//        }
//
//        print("isClickedArr_row 는!!!!!")
//        print(isClickedArr_row)
//        print("isClickedArr_col 는!!!!!")
//        print(isClickedArr_col)
//    }
//
//    private func setNavigationItems(){
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.title = "주가 정보"
//        //TODO: title color
//
//        // embed UISearchController
////        navigationItem.searchController = uiSc
//    }
//    @objc func reqButtonClicked(){
//        print("조회 버튼 클릭")
//        print(itemNmTextField.text ?? "nil")
//        print(startDateTextField.text ?? "nil")
//        print(endDateTextField.text ?? "nil")
//
//
//        self.requestAPI(itemName: self.itemNmTextField.text, startDate: self.startDate, endDate: self.endDate)
//        self.requestAPI2(itemName: self.itemNmTextField.text, startDate: self.startDate, endDate: self.endDate)
//
//    }
//
//    @objc func saveButtonClicked(){
//        print("저장 버튼 클릭")
//        //날짜정보 / 종목코드 / 종목명 / 상장시장명 / 시가 / 종가 / 최고가 / 최저가
//        //Async 처리
//
//    }
//
//    // 차트 SwiftUI ViewController present
//    @objc func showChartButtonClicked(){
//        print("차트 조회 버튼 클릭")
//        //날짜정보 / 종목코드 / 종목명 / 상장시장명 / 시가 / 종가 / 최고가 / 최저가
//        //Async 처리
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
//            print("정보 다 받아왔나?")
//            print("차트 조회 버튼 클릭")
//            // SwiftUI View를 출력하려면 UIHostingController로 감싸서 띄워야한다.
//
//            let hostingController = UIHostingController(rootView: SwiftUIChartView(title: self.itemNmTextField.text ?? "종목 이름 오류", securityArr: self.securityInfoArr, mkpInfoArr: self.mkpInfoArr, clprInfoArr: self.clprInfoArr, hiprInfoArr: self.hiprInfoArr, loprInfoArr: self.loprInfoArr))
//            if #available(iOS 16.0, *) {
//                hostingController.sizingOptions = .preferredContentSize
//            } else {
//                // Fallback on earlier versions
//            }
//            hostingController.modalPresentationStyle = .popover
//            self.present(hostingController, animated: true)
//        }
//    }
//
//
//    private func layout(){
//
//        [  requestButton, collectionView,saveButton, showChartButton].forEach{
////            view.addSubview($0)
//            view.addSubview($0)
//        }
//
//
//
//        requestButton.snp.makeConstraints{
////            $0.top.equalTo(endDateTextField.snp.bottom).offset(20)
//            $0.leading.equalTo(requestButton.snp.trailing).inset(40)
//            $0.height.equalTo(34)
//            $0.trailing.equalToSuperview().inset(20)
//        }
//
//        collectionView.snp.makeConstraints{
////            $0.top.equalTo(endDateTextField.snp.bottom).offset(20)
//            $0.leading.equalTo(requestButton.snp.trailing).inset(40)
//            $0.height.equalTo(400)
//            $0.trailing.equalToSuperview().inset(20)
//        }
//
//        saveButton.snp.makeConstraints{
////            $0.top.equalTo(endDateTextField.snp.bottom).offset(20)
//            $0.leading.equalTo(requestButton.snp.trailing).inset(40)
//            $0.height.equalTo(34)
//            $0.trailing.equalToSuperview().inset(20)
//        }
//
//        showChartButton.snp.makeConstraints{
////            $0.top.equalTo(endDateTextField.snp.bottom).offset(20)
//            $0.leading.equalTo(requestButton.snp.trailing).inset(40)
//            $0.height.equalTo(34)
//            $0.trailing.equalToSuperview().inset(20)
//        }
//
//
//
//    }
//
//
//}
//
//
//extension Former_ChartViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
////        return records.count
//        return self.jsonResultArr.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        return records[section].count
//        return self.jsonResultArr[0].count + 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowDataViewCollectionViewCell", for: indexPath) as? ShowDataViewCollectionViewCell else { return UICollectionViewCell() }
//        let isFirstRow: Bool = (indexPath.section == 0)
//        let isFirstColumn: Bool = (indexPath.row == 0)
//
//
//        if !isFirstColumn{
//            let now_title: String = jsonResultArr[indexPath.section][indexPath.row - 1]
//            if isFirstRow{
//                cell.setup(isFirstRow: isFirstRow, isFirstColumn: isFirstColumn, title: now_title, isClicked: isClickedArr_col[indexPath.row - 1], rowIdx: -1, colIdx: indexPath.row - 1)
//            }// FirstColumn도 FirstRow도 아닌 경우는 클릭 X
//            else{
//                cell.setup(isFirstRow: isFirstRow, isFirstColumn: isFirstColumn, title: now_title, isClicked: false, rowIdx: -3, colIdx: -3)
//            }
//
////            cell.setup(isFirstRow: isFirstRow, isFirstColumn: isFirstColumn, title: "sct = " + String(indexPath.section) + "idx = " + String(indexPath.item))
//        }
//        //FirstColumn인 경우
//        else{
//            //여기는 firstCol이자 firstRow이므로
//            if isFirstRow{
//                cell.setup(isFirstRow: isFirstRow, isFirstColumn: isFirstColumn, title: String(indexPath.section), isClicked: false, rowIdx: 0, colIdx: 0)
//            }
//            else{
//                cell.setup(isFirstRow: isFirstRow, isFirstColumn: isFirstColumn, title: String(indexPath.section), isClicked: isClickedArr_row[indexPath.section - 1], rowIdx: indexPath.section - 1, colIdx: -2)
//            }
//
//        }
////        cell.setRecord(records[indexPath.section][indexPath.item])
//        return cell
//    }
//}
//

