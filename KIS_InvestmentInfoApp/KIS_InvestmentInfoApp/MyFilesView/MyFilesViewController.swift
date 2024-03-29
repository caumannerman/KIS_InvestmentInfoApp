//
//  MyFilesViewController.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/02.
//

import UIKit
import SnapKit
import Alamofire
import UniformTypeIdentifiers

class MyFilesViewController: UIViewController {
    
    //오류방지를 위한 DummyData
    private var jsonResultArr: [[String]] = DummyClass.getJsonResultArr()
    
    private var isClickedArr_row: [Bool] = [true, false, false, true, false, false, false, true, true, false, true, false, false, false, true, false, true, false, false, true]
    private var isClickedArr_col: [Bool] = [false, false,true, true, false, false, false, true, false, false, true, true, ]
    
    

    //저장할 파일의 이름을 담을 변수
    private var saveFileName: String = ""
    
    // ---------------------===================== UI Components ======================--------------------- //
    
    
    //저장 파일 이름 받아올 UIAlert
    private let alert = UIAlertController(title: "파일 제목", message: "저장할 파일의 이름을 입력해주세요", preferredStyle: .alert)
    private var ok = UIAlertAction()
    private var cancel = UIAlertAction()
    
    
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
    
    private let get_save_view = UIView()
    private let getDataButton = UIButton()
    private let saveCsvButton = UIButton()
    
    // ---------------------=====================---------------======================--------------------- //

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        view.backgroundColor = .systemBackground
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
        NotificationCenter.default.addObserver(self, selector: #selector(changeCellColor(_:)), name: .cellColorChange, object: nil)
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
    
    
    func attribute(){
        
        get_save_view.backgroundColor = UIColor(red: 236/255.0, green: 236/255.0, blue: 236/255.0, alpha: 1.0)
        
        getDataButton.backgroundColor = .white
        getDataButton.setTitle("csv/xlsx 가져오기", for: .normal)
        getDataButton.titleLabel?.font = .systemFont(ofSize: 28, weight: .bold)
        getDataButton.setTitleColor(.black, for: .normal)
        getDataButton.addTarget(self, action: #selector(getCsv), for: .touchUpInside)
        getDataButton.layer.cornerRadius = 12.0
        getDataButton.layer.borderWidth = 3.0
        getDataButton.layer.borderColor = UIColor.lightGray.cgColor
        
        saveCsvButton.backgroundColor = .white
        saveCsvButton.setTitle("저장하기", for: .normal)
        saveCsvButton.titleLabel?.font = .systemFont(ofSize: 28, weight: .bold)
        saveCsvButton.setTitleColor(.black, for: .normal)
        saveCsvButton.addTarget(self, action: #selector(saveCsv), for: .touchUpInside)
        saveCsvButton.layer.cornerRadius = 12.0
        saveCsvButton.layer.borderWidth = 3.0
        saveCsvButton.layer.borderColor = UIColor.lightGray.cgColor
    }

    func layout(){
        [collectionView, get_save_view].forEach{
            view.addSubview($0)
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
        
        get_save_view.snp.makeConstraints{
            $0.top.equalTo(collectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        [getDataButton, saveCsvButton].forEach{
            get_save_view.addSubview($0)
        }
        
        getDataButton.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(6)
            $0.leading.equalToSuperview().inset(10)
            $0.width.equalTo((UIScreen.main.bounds.width - 40) / 2 )
        }
        
        saveCsvButton.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(6)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.equalTo((UIScreen.main.bounds.width - 40) / 2 )
        }
        
        
//        textField.snp.makeConstraints{
//            $0.top.equalTo(saveCsvButton.snp.bottom).offset(30)
//            $0.leading.trailing.equalToSuperview().inset(10)
//            $0.height.equalTo(300)
//        }
    }
    
    @objc func getCsv(){
        
        
//        guard let docsUrl = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first else { return }
//        let dirUrl = docsUrl.appendingPathComponent("KIS_Finance_Info")
//        let saveUrl = dirUrl.appendingPathComponent("MyFileSaveName.mp4")
        let suppertedFiles: [UTType] = [UTType.data]
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: suppertedFiles, asCopy: true)
      
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true){
            print("url name")
            
        }
    }
    
    @objc func saveCsv(){
        //save버튼 누르면 저장할 파일 제목 입력할 alert창을 띄워줘야한다.
        self.present(alert, animated: true){
            print("kkkkkk")
        }
        
        
//        exportAction()
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
    
//    private func exportAction() {
//        print("Start Exporting ...")
//
//        let fileManager = FileManager.default
//        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
//
//        // 도큐먼트 URL에 만들 폴더명
//        let directoryURL = documentURL.appendingPathComponent("KIS_Finance_Info")
//
//        do {
//            // 폴더 생성
//            try fileManager.createDirectory(atPath: directoryURL.path, withIntermediateDirectories: false, attributes: nil)
//        } catch let e as NSError {
//            print("Error다")
//            print(e.localizedDescription)
//        }
//
//        let fileName = directoryURL.appendingPathComponent(saveFileName)
//        let text = "aa,bb,cc,dd\n ee,ff,gg,hh"
//        do{
//            // 파일 생성
//            try text.write(to: fileName, atomically: false, encoding: .utf8)
//        } catch let e as NSError {
//            print(e.localizedDescription)
//        }
//    }
}



extension MyFilesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.jsonResultArr.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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



// network 함수 구현할 곳
extension MyFilesViewController{
    func csvStringToArray(csvString: String) -> [[String]] {
        var temp_row = csvString.split(separator: "\n").map{ now_row -> String in
            return String(now_row)
        }

        var result: [[String]] = []
        for i in 0 ..< temp_row.count {
            result.append( temp_row[i].components(separatedBy: ",").map{ subs -> String in
                return String(subs)
            })
        }
        return result
    }
}

extension MyFilesViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        print("a file was selected")
        print("url = ", terminator: " ")
        print(url)
        
        var now_url = url.absoluteString.removingPercentEncoding!
        print("decoded = ")
        print(now_url)
        for _ in 0 ..< 7 {
            now_url.removeFirst()
        }

        var result_string = ""
        // 파일 읽어옴
        let file: FileHandle? = FileHandle(forReadingAtPath: now_url)
        if file != nil {
            let data = file?.readDataToEndOfFile()
            file!.closeFile()
            result_string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String
            print(result_string)
        }
        else {
            print("Ooops! Something went wrong!")
        }
        
        //가져온 것으로 data 채움

        print("여기")
        print(result_string)
        
        self.jsonResultArr = csvStringToArray(csvString: result_string)
        print(jsonResultArr)
        if jsonResultArr.count == 0 {
            jsonResultArr = [["내용이 없습니다"], ["비어있는 CSV 파일입니다."]]
        }
        self.isClickedArr_col = Array(repeating: false, count: self.jsonResultArr[0].count)
        self.isClickedArr_row = Array(repeating: false, count: self.jsonResultArr.count - 1)
        
        
//                //테이블 뷰 다시 그려줌
        self.collectionView.isHidden = false
        self.collectionView.reloadData()
        
        
    }
}
