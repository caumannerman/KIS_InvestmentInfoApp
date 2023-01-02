//
//  MyFilesViewController.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/02.
//

import UIKit
import SnapKit

class MyFilesViewController: UIViewController {

    let getDataButton = UIButton()
    let saveCsvButton = UIButton()
    
    let textField = UITextField()
    
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
        // Do any additional setup after loading the view.
        
    }
    
    func attribute(){
        getDataButton.backgroundColor = UIColor(red: 155/255.0, green: 202/255.0, blue: 184/255.0, alpha: 1.0)
        getDataButton.setTitle("get!", for: .normal)
        getDataButton.addTarget(self, action: #selector(getCsv), for: .touchUpInside)
        
        saveCsvButton.backgroundColor = UIColor(red: 155/255.0, green: 202/255.0, blue: 184/255.0, alpha: 1.0)
        saveCsvButton.setTitle("save!", for: .normal)
        saveCsvButton.addTarget(self, action: #selector(saveCsv), for: .touchUpInside)
        
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
    }

    func layout(){
        [getDataButton, saveCsvButton, textField].forEach{
            view.addSubview($0)
        }
        
        getDataButton.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(50)
        }
        
        saveCsvButton.snp.makeConstraints{
            $0.top.equalTo(getDataButton.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(80)
            $0.height.equalTo(50)
        }
        
        textField.snp.makeConstraints{
            $0.top.equalTo(saveCsvButton.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(300)
        }
    }
    
    @objc func getCsv(){
        
    }
    
    @objc func saveCsv(){
        createCSV()
    }

    private func createCSV() {
        
        let fileManager = FileManager.default
        
        let folderName = "newCSVFolder"
        let csvFileName = "myCSVFile.csv"
        
        // 폴더 생성
        let documentUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let directoryUrl = documentUrl.appendingPathComponent(folderName)
        do {
            try fileManager.createDirectory(atPath: directoryUrl.path, withIntermediateDirectories: true, attributes: nil)
        }
        catch let error as NSError {
            print("폴더 생성 에러: \(error)")
        }
        
        // csv 파일 생성
        let fileUrl = directoryUrl.appendingPathComponent(csvFileName)
        let fileData = "This,is,just,some,dummy,data".data(using: .utf8)
        
        do {
            try fileData?.write(to: fileUrl)
            
            print("Writing CSV to: \(fileUrl.path)")
        }
        catch let error as NSError {
            print("CSV파일 생성 에러: \(error)")
        }
    }
}
