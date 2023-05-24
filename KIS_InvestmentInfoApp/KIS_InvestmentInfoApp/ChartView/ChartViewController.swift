//
//  ChartViewController.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/02.
//

import UIKit
import Charts
import SnapKit
import Alamofire
import SwiftUI

//날짜정보 / 종목코드 / 종목명 / 상장시장명 / 시가 / 종가 / 최고가 / 최저가
class ChartViewController: UIViewController {
    
    
    // ---------------------======================== Variables ========================--------------------- //
    
    //저장할 파일의 이름을 담을 변수
    private var saveFileName: String = ""
    //저장 파일 이름 받아올 UIAlert
    private let alert = UIAlertController(title: "파일 제목", message: "저장할 파일의 이름을 입력해주세요", preferredStyle: .alert)
    private var ok = UIAlertAction()
    private var cancel = UIAlertAction()
    
    private var apiResultStr = ""
    // 이것이 json String을 이용해 최종적으로 얻은 배열이라고 생각하고 개발중
    private var jsonResultArr: [[String]] = DummyClass.getJsonResultArr()
    
    private var isClickedArr_row: [Bool] = [true, false, false, true, false, false, false, true, true, false, true, false, false, false, true, false, true, false, false, true]
    private var isClickedArr_col: [Bool] = [false, false,true, true, false, false, false, true, false, false, true, true, ]
    

    var api_result: String = ""
    
    // 원하는 기간의 주가정보를 받아와 저장할 배열
    private var securityDataArr: [SecurityDataCellData] = []
    
    // Identifiable 프로토콜을 따르는 [SecurityInfo] 배열, SwiftUI view로 넘겨줘야함
    private var securityInfoArr: [SecurityInfo] = []
    // SiteView를 따르는 것 시가/종가/ 최저가 /최고가
    private var mkpInfoArr: [SiteView] = []
    private var clprInfoArr: [SiteView] = []
    private var hiprInfoArr: [SiteView] = []
    private var loprInfoArr: [SiteView] = []
    
    private var now_section_idx: Int = 0
    private var now_subSection_idx: Int = 0
    // ---------------------========================----------------========================--------------------- //
    
    
    // ---------------------======================== UI Components ========================--------------------- //
    
    // section을 선택하는 collectionView
    private let sectionCollectionView = ChartViewCollectionView(frame: .zero, collectionViewLayout: ChartViewCollectionViewLayout())
    private let subSectionCollectionView = ItemSubSectionCollectionView(frame: .zero, collectionViewLayout: ItemSubSectionCollectionViewLayout())
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0.0
        return stackView
    }()
    
    // 그래프 이외의 Component들
    let itemNmLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.text = "종목명"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    let itemNmTextField: UITextField = {
        let tf = UITextField()
        
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
        tf.layer.cornerRadius = 12.0
        tf.backgroundColor = .systemBackground
        tf.placeholder = "종목명 입력"
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    // 그래프 이외의 Component들
    let startDateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.text = "차트조회 시작일"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    let startDateTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
        tf.layer.cornerRadius = 12.0
        tf.backgroundColor = .systemBackground
        tf.placeholder = "조회 시작일 선택"
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    // 그래프 이외의 Component들
    let endDateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.text = "차트조회 종료일"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let endDateTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
        tf.layer.cornerRadius = 12.0
        tf.backgroundColor = .systemBackground
        tf.placeholder = "조회 종료일 선택"
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    let requestButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 8.0
        btn.layer.borderWidth = 2.0
        btn.layer.borderColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0).cgColor
        btn.backgroundColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 244/255.0, alpha: 1.0)
        btn.setTitle("조회", for: .normal)
//        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .semibold)
        btn.addTarget(self, action: #selector(reqButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    let saveButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 8.0
        btn.layer.borderWidth = 2.0
        btn.layer.borderColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0).cgColor
        btn.backgroundColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 244/255.0, alpha: 1.0)
        btn.setTitle("CSV 저장", for: .normal)
//        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .bold)
        btn.addTarget(self, action: #selector(savefunc), for: .touchUpInside)
        return btn
    }()
    @objc func savefunc(){
        print("저장 버튼 클릭")
        self.present(alert, animated: true){
            print("alert 띄움")
        }
    }
    
    let showChartButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 8.0
        btn.layer.borderWidth = 2.0
        btn.layer.borderColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0).cgColor
        btn.backgroundColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 244/255.0, alpha: 1.0)
        btn.setTitle("차트 보기", for: .normal)
//        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .bold)
        btn.addTarget(self, action: #selector(showChartButtonClicked), for: .touchUpInside)
        return btn
    }()
   
   
    //TODO: dataTitles를 가져오는 api 항목에 맞게 따로 불러오는 기능 구현해야함
//    private var dataTitles: [String] = ["cur_unit", "ttb", "tts", "deal_bas_r", "bkpr", "yy_efee_r", "ten_dd_efee_r", "kftc_bkpr", "kftc_deal_bas_r", "cur_nm", "cur_unit", "ttb", "tts", "deal_bas_r", "bkpr", "yy_efee_r", "ten_dd_efee_r", "kftc_bkpr", "kftc_deal_bas_r", "cur_nm"]
//    private var erData: [ExchangeRateCellData] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = GridLayout()
        layout.cellHeight = 44
        layout.cellWidths = Array(repeating: CGFloat(120), count: jsonResultArr[0].count + 1)
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
    
    private let blankView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemBackground
        return v
    }()
    
    private let searchPartView = SearchPartView()

    private let startDateDatePicker = UIDatePicker()
    private let endDateDatePicker = UIDatePicker()
    private let purchaseDateDatePicker = UIDatePicker()
    private let sellDateDatePicker = UIDatePicker()
    private let topProfitDateDatePicker = UIDatePicker()
    private let worstProfitDateDatePicker = UIDatePicker()
    
    // ---------------------=================-------------------------=================--------------------- //
    
    
    // 차트 시작 전 입력받아야하는 것들 //
    private var securityName: String = ""
    private var strategyValye: String = ""
    private var startDate: Date?
    private var endDate: Date?
    // 차트 시작 전 입력받아야하는 것들 //
    
    private var purchaseDate: Date?
    private var sellDate: Date?
    private var topProfitDate: Date?
    private var worstProfitDate: Date?
    
    //PickerView를 종료하기 위한 콜백함수
    @objc func pickerExit(){
//        self.strategyTextField.text = nil
        self.view.endEditing(true)
    }
    @objc func pickerDone(){
        self.view.endEditing(true)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        itemNmTextField.tag = 1
        // strategyPicker를 꾸밈
//        let exitButton = UIBarButtonItem(title: "exit", style: .plain, target: self, action: #selector(pickerExit))
        let doneBT = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.pickerDone))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBT = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.pickerExit))
        
        let toolBar = UIToolbar()
        toolBar.tintColor = .systemBrown
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        toolBar.setItems([cancelBT,flexibleSpace,doneBT], animated: false)
        toolBar.isUserInteractionEnabled = true
        
//        strategyTextField.inputAccessoryView = toolBar
//        strategyTextField.inputView = strategyPicker
        
        setNavigationItems()
        //DatePicker 초기화
        setupStartDateDatePicker()
        setupEndDateDatePicker()

        
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
        subSectionCollectionView.setup(idx: 0)
        subSectionCollectionView.setupOnWhichView(onWhich: .Chart)
        
        self.collectionView.isHidden = true
        
        // 이것은 csv의 row, column을 선택할 때 관련한 noti
        NotificationCenter.default.addObserver(self, selector: #selector(changeCellColor(_:)), name: .cellColorChange, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(chartSectionDidChanged(_:)), name: .DidTapUnClickedCell, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didTapItemSubSectionCell_Chart(_:)), name: .DidTapItemSubSectionCell_Chart, object: nil)

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
        
    }
    
    @objc func didTapItemSubSectionCell_Chart(_ notification: Notification) {
        guard let clickedIdx = notification.userInfo?["idx"] as? Int else { return }
        now_subSection_idx = clickedIdx
        print("현재 선택된 section & subSection", now_section_idx, now_subSection_idx)
        
    }
    
    
    
    //section cell 선택이 바뀌었을 때 호출될 함수
    @objc func chartSectionDidChanged(_ notification: Notification){
        guard let clickedIdx = notification.userInfo?["row"] as? Int else { return }
        // 여기서 subSectionCollectionView도 바꿔줘야한다.
        subSectionCollectionView.setup(idx: clickedIdx)
        subSectionCollectionView.reloadData()
        
        
        
        //두개의 switch 문으로 분기하여 해결
        
        // 이미 나타나있던 화면을 constraints 제거
        switch now_section_idx {
        case 0:
            print("이미 선택되어있던 cell = ", 0)
            scrollView.snp.removeConstraints()
            
        default:
            print("default")
            searchPartView.snp.removeConstraints()
        }
        
        // 새롭게 나타나야하는 화면을 constraints 생성
        print("새로 선택된 cell = ", clickedIdx)
        now_section_idx = clickedIdx
        
        switch clickedIdx {
        case 0:
            
            // constraints 생성
            self.view.addSubview(scrollView)
            scrollView.snp.makeConstraints{
                $0.top.equalTo(subSectionCollectionView.snp.bottom)
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.bottom.equalTo(view.safeAreaLayoutGuide)
            }
            
        default:
            print("default")
            // constraints 생성
            // constraints 생성
            self.view.addSubview(searchPartView)
            searchPartView.snp.makeConstraints{
                $0.top.equalTo(subSectionCollectionView.snp.bottom)
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.bottom.equalTo(view.safeAreaLayoutGuide)
            }
            
        }
        
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
            print("CSV파일 생성 에러: \(error)")
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
        navigationItem.title = "주가 정보"
        //TODO: title color
    
        // embed UISearchController
//        navigationItem.searchController = uiSc
    }
    @objc func reqButtonClicked(){
        print("조회 버튼 클릭")
        print(itemNmTextField.text ?? "nil")
        print(startDateTextField.text ?? "nil")
        print(endDateTextField.text ?? "nil")

   
        self.requestAPI(itemName: self.itemNmTextField.text, startDate: self.startDate, endDate: self.endDate)
        self.requestAPI2(itemName: self.itemNmTextField.text, startDate: self.startDate, endDate: self.endDate)

    }
    
    @objc func saveButtonClicked(){
        print("저장 버튼 클릭")
        //날짜정보 / 종목코드 / 종목명 / 상장시장명 / 시가 / 종가 / 최고가 / 최저가
        //Async 처리
        
    }
    
    // 차트 SwiftUI ViewController present
    @objc func showChartButtonClicked(){
        print("차트 조회 버튼 클릭")
        //날짜정보 / 종목코드 / 종목명 / 상장시장명 / 시가 / 종가 / 최고가 / 최저가
        //Async 처리
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            print("정보 다 받아왔나?")
            print("차트 조회 버튼 클릭")
            // SwiftUI View를 출력하려면 UIHostingController로 감싸서 띄워야한다.
           
            let hostingController = UIHostingController(rootView: SwiftUIChartView(title: self.itemNmTextField.text ?? "종목 이름 오류", securityArr: self.securityInfoArr, mkpInfoArr: self.mkpInfoArr, clprInfoArr: self.clprInfoArr, hiprInfoArr: self.hiprInfoArr, loprInfoArr: self.loprInfoArr))
            if #available(iOS 16.0, *) {
                hostingController.sizingOptions = .preferredContentSize
            } else {
                // Fallback on earlier versions
            }
            hostingController.modalPresentationStyle = .popover
            self.present(hostingController, animated: true)
        }
    }
    
    private func attribute(){
        sectionCollectionView.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
    }
    
    private func layout(){
        [ sectionCollectionView, subSectionCollectionView, scrollView ].forEach {
            view.addSubview($0)
        }
        
        sectionCollectionView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(90)
        }
        
        subSectionCollectionView.snp.makeConstraints{
            $0.top.equalTo(sectionCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        scrollView.snp.makeConstraints{
            $0.top.equalTo(subSectionCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
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
        
        [ itemNmLabel, itemNmTextField, startDateLabel, startDateTextField, endDateLabel, endDateTextField, requestButton, collectionView,saveButton, showChartButton, blankView].forEach{
//            view.addSubview($0)
            stackView.addArrangedSubview($0)
        }
        
        itemNmLabel.snp.makeConstraints{
//            $0.top.equalTo(barGraphView.snp.bottom).offset(30)
//            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(34)
            $0.width.equalTo(80)
        }
        
        itemNmTextField.snp.makeConstraints{
//            $0.top.equalTo(itemNmLabel.snp.bottom).offset(30)
            $0.leading.equalTo(itemNmLabel.snp.trailing).offset(10)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        startDateLabel.snp.makeConstraints{
//            $0.top.equalTo(tickerTextField.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(34)
            $0.width.equalTo(80)
        }
        
        startDateTextField.snp.makeConstraints{
//            $0.top.equalTo(tickerLabel2.snp.bottom).offset(30)
            $0.leading.equalTo(itemNmLabel.snp.trailing).offset(10)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        endDateLabel.snp.makeConstraints{
//            $0.top.equalTo(tickerTextField2.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(34)
            $0.width.equalTo(80)
        }
        
        endDateTextField.snp.makeConstraints{
//            $0.top.equalTo(tickerLabel3.snp.bottom).offset(30)
            $0.leading.equalTo(itemNmLabel.snp.trailing).offset(10)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        requestButton.snp.makeConstraints{
//            $0.top.equalTo(endDateTextField.snp.bottom).offset(20)
            $0.leading.equalTo(itemNmLabel.snp.trailing).inset(40)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        collectionView.snp.makeConstraints{
//            $0.top.equalTo(endDateTextField.snp.bottom).offset(20)
            $0.leading.equalTo(itemNmLabel.snp.trailing).inset(40)
            $0.height.equalTo(400)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        saveButton.snp.makeConstraints{
//            $0.top.equalTo(endDateTextField.snp.bottom).offset(20)
            $0.leading.equalTo(itemNmLabel.snp.trailing).inset(40)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        showChartButton.snp.makeConstraints{
//            $0.top.equalTo(endDateTextField.snp.bottom).offset(20)
            $0.leading.equalTo(itemNmLabel.snp.trailing).inset(40)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        
        blankView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().offset(10)
            $0.height.equalTo(50)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension ChartViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(textField.tag)
    }
    
}

// MARK: 여기는 DatePicker관련 4가지

extension ChartViewController{
    
    private func setupStartDateDatePicker(){
        //날짜만 나오게 ( 시간 제외 )
        self.startDateDatePicker.datePickerMode = .date
        self.startDateDatePicker.preferredDatePickerStyle = .inline
        //for에는 어떤 event가 일어났을 때 action에 정의한 메서드를 호출할 것인지
        // 첫 번째 parameter에는 target
        self.startDateDatePicker.addTarget(
            self,
            action: #selector(startDateDatePickerValueDidChange(_:) ),
            for: .valueChanged
        )
        //연-월-일 순으로 + 한글
        self.startDateDatePicker.locale = Locale(identifier: "ko-KR")
        //dateTextField를 눌렀을 때, keyboard가 아닌 datePicker가 나오게 된다!
        self.startDateTextField.inputView = self.startDateDatePicker
//        self.endDateTextField.inputView = self.startDateDatePicker
//        self.purchaseDateTextField.inputView = self.startDateDatePicker
//        self.sellDateTextField.inputView = self.startDateDatePicker
//        self.topProfitTextField.inputView = self.startDateDatePicker
//        self.worstProfitTextField.inputView = self.startDateDatePicker
    }
    //datePicker 선택값이 달라지면 호출될 메서드
    @objc func startDateDatePickerValueDidChange(_ datePicker: UIDatePicker){
        //날짜, text를 반환해주는 역할
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy 년 MM월 dd일(EEEEE)"
//        formatter.dateFormat = "yyyyMMdd"
        formatter.locale = Locale(identifier: "ko_KR")

        self.startDate = datePicker.date
        self.startDateTextField.text = formatter.string(from: datePicker.date)
        // 다른 날짜를 선택해도,키보드로 텍스트를 입력받은 것이 아니기 때문에 dateTextFieldDidChange가 #selector에서 정상적으로 호출되지 않는다. 따라서 pick한 날짜가 변하면, .editingChanged 이벤트를 인위적으로 발생시켜준다.
        self.endDateTextField.sendActions(for: .editingChanged)
        print(self.endDateTextField.isFocused)
    }
    
    private func setupEndDateDatePicker(){
        //날짜만 나오게 ( 시간 제외 )
        self.endDateDatePicker.datePickerMode = .date
        self.endDateDatePicker.preferredDatePickerStyle = .inline
        //for에는 어떤 event가 일어났을 때 action에 정의한 메서드를 호출할 것인지
        // 첫 번째 parameter에는 target
        self.endDateDatePicker.addTarget(
            self,
            action: #selector(endDateDatePickerValueDidChange(_:) ),
            for: .valueChanged
        )
        //연-월-일 순으로 + 한글
        self.endDateDatePicker.locale = Locale(identifier: "ko-KR")
        //dateTextField를 눌렀을 때, keyboard가 아닌 datePicker가 나오게 된다!
        self.endDateTextField.inputView = self.endDateDatePicker
//        self.endDateTextField.inputView = self.startDateDatePicker
//        self.purchaseDateTextField.inputView = self.startDateDatePicker
//        self.sellDateTextField.inputView = self.startDateDatePicker
//        self.topProfitTextField.inputView = self.startDateDatePicker
//        self.worstProfitTextField.inputView = self.startDateDatePicker
    }
    //datePicker 선택값이 달라지면 호출될 메서드
    @objc func endDateDatePickerValueDidChange(_ datePicker: UIDatePicker){
        //날짜, text를 반환해주는 역할
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy 년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")

        self.endDate = datePicker.date
        self.endDateTextField.text = formatter.string(from: datePicker.date)
        // 다른 날짜를 선택해도,키보드로 텍스트를 입력받은 것이 아니기 때문에 dateTextFieldDidChange가 #selector에서 정상적으로 호출되지 않는다. 따라서 pick한 날짜가 변하면, .editingChanged 이벤트를 인위적으로 발생시켜준다.
        self.endDateTextField.sendActions(for: .editingChanged)
    }
    
}

extension ChartViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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
           
//            cell.setup(isFirstRow: isFirstRow, isFirstColumn: isFirstColumn, title: "sct = " + String(indexPath.section) + "idx = " + String(indexPath.item))
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

extension ChartViewController{
    //(itemCode: String, startDate: Date?, endDate: Date?) 매개변수 부분 이걸로 바꿔야함
    private func requestAPI(itemName: String?, startDate: Date?, endDate: Date?) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        formatter.locale = Locale(identifier: "ko_KR")
        
        var sDateText: String = ""
        var eDateText: String = ""
        var nowName: String = ""
        
        if startDate == nil || endDate == nil{
            sDateText = "20221201"
            eDateText = "20221231"
            
            //입력 안했을 시에 default로 입력할 기간
            self.startDate = formatter.date(from: sDateText)
            self.endDate = formatter.date(from: eDateText)
            
            let formatter_show = DateFormatter()
            formatter_show.dateFormat = "yyyy 년 MM월 dd일(EEEEE)"
    //        formatter.dateFormat = "yyyyMMdd"
            formatter_show.locale = Locale(identifier: "ko_KR")
            
            self.startDateTextField.text = formatter_show.string(from: self.startDate!)
            self.endDateTextField.text = formatter_show.string(from: self.endDate!)
        }else{
            sDateText = formatter.string(from: startDate!)
            eDateText = formatter.string(from: endDate!)
        }
        
        if itemName == nil || itemName == ""{
            nowName = "한국금융지주"
            self.itemNmTextField.text = nowName
        }else{
            nowName = itemName!.trimmingCharacters(in: .whitespaces)
        }
        
        let newnewurl = "http://apis.data.go.kr/1160100/service/GetStockSecuritiesInfoService/getStockPriceInfo" + "?numOfRows=365&resultType=json&serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D&itmsNm=" + nowName + "&beginBasDt=" + sDateText + "&endBasDt=" + eDateText
        
        print("url = " + newnewurl)
        let encoded = newnewurl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"])))
        print(encoded)
       
        //addingPercentEncoding은 한글(영어 이외의 값) 이 url에 포함되었을 때 오류나는 것을 막아준다.
        AF.request(newnewurl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"]))) ?? "")
            .responseDecodable(of: SecurityResponse.self){ [weak self] response in
                // success 이외의 응답을 받으면, else문에 걸려 함수 종료
                
                print(response)

                guard let self = self,
                    case .success(let data) = response.result else {
                    print("실패ㅜㅜ")
                          return }
                
                print("실패 아니면 여기 나와야함!!! ")
                //데이터 받아옴
                // [SecurityData] 형태임
                let now_arr = data.response.body.items.item
                
                self.securityDataArr = now_arr.map{ sd -> SecurityDataCellData in
                    let temp = SecurityDataCellData(basDt: sd.basDt, strnCd: sd.srtnCd, itmsNm: sd.itmsNm, mrktCtg: sd.mrktCtg, mkp: sd.mkp, clpr: sd.clpr, hipr: sd.hipr, lopr: sd.lopr)
                    return temp
                }
                // Identifiable인 SecurityInfo 배열에 방금 받아온 json으로 값을 채움
                self.securityInfoArr = now_arr.map{ sd -> SecurityInfo in
                    let temp = SecurityInfo(basDt: sd.basDt ?? "20220101", strnCd: sd.srtnCd ?? "071050", itmsNm: sd.itmsNm ?? "한국금융지주", mrktCtg: sd.mrktCtg ?? "KOSPI", mkp: sd.mkp ?? "57600", clpr: sd.clpr ?? "58600", hipr: sd.hipr ?? "58600", lopr: sd.lopr ?? "55600")
                    return temp
                }
//                print("받아온 배열 (최종)")
                
//                print(self.securityDataArr)
                
                let formatterr = DateFormatter()
                formatterr.dateFormat = "yyyyMMdd"
                formatterr.locale = Locale(identifier: "ko_KR")
                
//                mkpInfoArr, clprInfoArr, hiprInfoArr, loprInfoArr
                self.mkpInfoArr = self.securityInfoArr.map{ item -> SiteView in
                    let temp = SiteView(hour: formatter.date(from: item.basDt)!, views: Double(item.mkp)!)
                    return temp
                }
                self.clprInfoArr = self.securityInfoArr.map{ item -> SiteView in
                    let temp = SiteView(hour: formatter.date(from: item.basDt)!, views:  Double(item.clpr)!)
                    return temp
                }
                self.hiprInfoArr = self.securityInfoArr.map{ item -> SiteView in
                    let temp = SiteView(hour: formatter.date(from: item.basDt)!, views:  Double(item.hipr)!)
                    return temp
                }
                self.loprInfoArr = self.securityInfoArr.map{ item -> SiteView in
                    let temp = SiteView(hour: formatter.date(from: item.basDt)!, views:  Double(item.lopr)!)
                    return temp
                }
                //테이블 뷰 다시 그려줌
//                self.tableView.reloadData()
            }
            .resume()
    }
    
     //String으로 하는 것
    private func requestAPI2(itemName: String?, startDate: Date?, endDate: Date?) {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        formatter.locale = Locale(identifier: "ko_KR")
        
        var sDateText: String = ""
        var eDateText: String = ""
        var nowName: String = ""
        
        if startDate == nil || endDate == nil{
            sDateText = "20221201"
            eDateText = "20221231"
            
            //입력 안했을 시에 default로 입력할 기간
            self.startDate = formatter.date(from: sDateText)
            self.endDate = formatter.date(from: eDateText)
            
            let formatter_show = DateFormatter()
            formatter_show.dateFormat = "yyyy 년 MM월 dd일(EEEEE)"
    //        formatter.dateFormat = "yyyyMMdd"
            formatter_show.locale = Locale(identifier: "ko_KR")
            
            self.startDateTextField.text = formatter_show.string(from: self.startDate!)
            self.endDateTextField.text = formatter_show.string(from: self.endDate!)
        }else{
            sDateText = formatter.string(from: startDate!)
            eDateText = formatter.string(from: endDate!)
        }
        
        if itemName == nil || itemName == ""{
            nowName = "한국금융지주"
            self.itemNmTextField.text = nowName
        }else{
            nowName = itemName!.trimmingCharacters(in: .whitespaces)
        }
        
        let newnewurl = "http://apis.data.go.kr/1160100/service/GetStockSecuritiesInfoService/getStockPriceInfo" + "?numOfRows=365&resultType=json&serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D&itmsNm=" + nowName + "&beginBasDt=" + sDateText + "&endBasDt=" + eDateText
        
        print("url = " + newnewurl)
        let encoded = newnewurl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"])))
        print(encoded)
        //addingPercentEncoding은 한글(영어 이외의 값) 이 url에 포함되었을 때 오류나는 것을 막아준다.
        
        let aaa = AF.request(newnewurl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"]))) ?? "")
            .response(){ [weak self] response in
                guard
                    let self = self,
                    case .success(let data) = response.result else { return }
                //str이, 받아온 json을 형태 그대로 STring으로 만든 것이다.
                let str = String(decoding: data!, as: UTF8.self)
                self.apiResultStr = str
                self.jsonResultArr = JsonParser.jsonToArr2(jsonString: str)
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
    
    
    
