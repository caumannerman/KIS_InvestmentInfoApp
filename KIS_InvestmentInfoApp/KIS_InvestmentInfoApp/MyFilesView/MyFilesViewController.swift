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
    
    private var isClickedArr_row: [Bool] = [true, false, false, true, false, false, false, true, true, false, true, false, false, false, true, false, true, false, false, true]
    private var isClickedArr_col: [Bool] = [false, false,true, true, false, false, false, true, false, false, true, true, ]
    
    
    

    //저장할 파일의 이름을 담을 변수
    private var saveFileName: String = ""
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
    
    let getDataButton = UIButton()
    let saveCsvButton = UIButton()
    
//    let textField = UITextField()
    
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
        getDataButton.backgroundColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 244/255.0, alpha: 1.0)
        getDataButton.setTitle("get", for: .normal)
        getDataButton.addTarget(self, action: #selector(getCsv), for: .touchUpInside)
        getDataButton.layer.cornerRadius = 12.0
        getDataButton.layer.borderWidth = 1.0
        getDataButton.layer.borderColor = UIColor(red: 0/255.0, green: 202/255.0, blue: 184/255.0, alpha: 1.0).cgColor
        
        saveCsvButton.backgroundColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 244/255.0, alpha: 1.0)
        saveCsvButton.setTitle("save", for: .normal)
        saveCsvButton.addTarget(self, action: #selector(saveCsv), for: .touchUpInside)
        saveCsvButton.layer.cornerRadius = 12.0
        saveCsvButton.layer.borderWidth = 1.0
        saveCsvButton.layer.borderColor = UIColor(red: 0/255.0, green: 202/255.0, blue: 184/255.0, alpha: 1.0).cgColor
//
//        textField.layer.borderWidth = 1
//        textField.layer.borderColor = UIColor.black.cgColor
    }

    func layout(){
        [collectionView, getDataButton, saveCsvButton].forEach{
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
        getDataButton.snp.makeConstraints{
            $0.top.equalTo(collectionView.snp.bottom).offset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.equalToSuperview().inset(60)
            $0.width.equalTo(120)
//            $0.height.equalTo(40)
        }
        
        saveCsvButton.snp.makeConstraints{
            $0.top.equalTo(collectionView.snp.bottom).offset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.trailing.equalToSuperview().inset(60)
            $0.width.equalTo(120)
//            $0.height.equalTo(40)
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
