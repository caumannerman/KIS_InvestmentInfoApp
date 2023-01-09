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

    //저장할 파일의 이름을 담을 변수
    private var saveFileName: String = ""
    //저장 파일 이름 받아올 UIAlert
    private let alert = UIAlertController(title: "파일 제목", message: "저장할 파일의 이름을 입력해주세요", preferredStyle: .alert)
    private var ok = UIAlertAction()
    private var cancel = UIAlertAction()
    
    //한 출에 표시할 데이터 수
    final let numRow: Int = 12
    //TODO: dataTitles를 가져오는 api 항목에 맞게 따로 불러오는 기능 구현해야함
    private var dataTitles: [String] = ["cur_unit", "ttb", "tts", "deal_bas_r", "bkpr", "yy_efee_r", "ten_dd_efee_r", "kftc_bkpr", "kftc_deal_bas_r", "cur_nm", "cur_unit", "ttb", "tts", "deal_bas_r", "bkpr", "yy_efee_r", "ten_dd_efee_r", "kftc_bkpr", "kftc_deal_bas_r", "cur_nm"]
    private var erData: [ExchangeRateCellData] = []
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 2
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ButtonListViewCellCell.self, forCellWithReuseIdentifier: "ButtonListViewCellCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
//        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = true

        collectionView.backgroundColor = .lightGray
        
        collectionView.register(ShowDataViewCollectionViewCell.self, forCellWithReuseIdentifier: "ShowDataViewCollectionViewCell")
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
    override func viewDidLoad() {
        super.viewDidLoad()
        alert.addTextField{
            $0.placeholder = "별칭을 입력하세요"
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
            self.createCSV()
        }
        cancel = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(ok)
        alert.addAction(cancel)
    }
    
    func attribute(){
        getDataButton.backgroundColor = UIColor(red: 155/255.0, green: 202/255.0, blue: 184/255.0, alpha: 1.0)
        getDataButton.setTitle("get", for: .normal)
        getDataButton.addTarget(self, action: #selector(getCsv), for: .touchUpInside)
        getDataButton.layer.cornerRadius = 12.0
        getDataButton.layer.borderWidth = 1.0
        getDataButton.layer.borderColor = UIColor(red: 0/255.0, green: 202/255.0, blue: 184/255.0, alpha: 1.0).cgColor
        
        saveCsvButton.backgroundColor = UIColor(red: 155/255.0, green: 202/255.0, blue: 184/255.0, alpha: 1.0)
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
        requestAPI()
        
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

    private func createCSV() {
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
        let fileData = "This,is,just,some,dummy,data\n11,22,33,44,55,66,777".data(using: .utf8)
        
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        erData.count * 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowDataViewCollectionViewCell", for: indexPath) as? ShowDataViewCollectionViewCell else { return UICollectionViewCell() }
//        let a = indexPath.row
        if indexPath.row == 0 {
            cell.setup(isFirstRow: true, isFirstColumn: true, title: "선택")
        }
        //첫 열
        else if indexPath.row > 0 && indexPath.row <= numRow{
            cell.setup(isFirstRow: false, isFirstColumn: true, title: String(indexPath.row))
        }
        //첫 행
        else if indexPath.row % ( numRow + 1) == 0 {
            let now_title_sunseo_idx = indexPath.row / ( numRow + 1) - 1
            cell.setup(isFirstRow: true, isFirstColumn: false, title: dataTitles[now_title_sunseo_idx])
        }
        //일반 cell
        else{
            cell.setup(isFirstRow: false, isFirstColumn: false, title: "일반")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = ( (collectionView.frame.height - CGFloat(numRow * 2)) / CGFloat(numRow + 1) )
        let width = height * 2
//                let itemsPerRow: CGFloat = 2
//                let widthPadding = sectionInsets.left * (itemsPerRow + 1)
//                let itemsPerColumn: CGFloat = 3
//                let heightPadding = sectionInsets.top * (itemsPerColumn + 1)
//                let cellWidth = (width - widthPadding) / itemsPerRow
//                let cellHeight = (height - heightPadding) / itemsPerColumn
                
        return CGSize(width: width, height: height)
    }

}



// network 함수 구현할 곳
extension MyFilesViewController{
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
                
                print( "총 row 수 = " + String(self.erData.count))
                print( "0번째 인덱스 " )
                print( self.erData[0] )
              
                //테이블 뷰 다시 그려줌
                self.collectionView.reloadData()
            }
            .resume()
    }
}

extension MyFilesViewController: UIDocumentPickerDelegate {
    
//    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//        guard let selectedFileURL = urls.first else {
//            return
//        }
//        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//
//    }
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        print("a file was selected")
        let rows = NSArray(
        )
        
    }
}
