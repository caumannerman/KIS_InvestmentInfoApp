//
//  ApiListTableViewCell.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/04/25.
//

import UIKit
import SnapKit
import Alamofire
import WebKit

class ApiListTableViewCell: UITableViewCell {
    
    let scoms = UrlCommonState.getInstance()
    private var rowNum: Int = -1
    private var isValid: Bool = false
    private var isStar: Bool = false
    
    private let aliasLabel = UITextField()
    private let reviseButton = UIImageView()
    private let urlLabel = UILabel()
    private let starButton = UIImageView()
    private let validationButton = UIButton()

    @objc func settingTapped(){
        print("연필 클릭")
        aliasLabel.isEnabled = true
    }
    
    @objc func didClickValidButton() {
        
        if !self.isValid {
            print("갱신하시겠습니까?")
            NotificationCenter.default.post(name:.PushWebView, object: .none)

            
        }
       
    }
    
    // setup에서도 사용하기 위해, isValid값에 따른 색,글자를 변경하는 부분을 별도 함수로 분리하였다.
    func changeValidButton(_ isValid: Bool){
        
        if isValid {
            validationButton.setTitle("유효", for: .normal)
            validationButton.layer.borderColor = UIColor.red.cgColor
            validationButton.setTitleColor(.red, for: .normal)
        }
        else {
            validationButton.setTitle("만료", for: .normal)
            validationButton.layer.borderColor = UIColor.darkGray.cgColor
            validationButton.setTitleColor(.darkGray, for: .normal)
        }
    }
    
    @objc func didClickStarButton(){
        print("star button clicked")
        isStar = !isStar
        changeStarButton(self.isStar)

    
        if isStar {
            scoms.InsertNewlyStarredUrl(rowNum: rowNum + 1)
        } else {
            scoms.InsertNewlyUnStarredUrl(rowNum: rowNum + 1)
        }
        print("Settings에서 변경 후", terminator: " ")
        print(scoms.getUrlStarred())
        
        NotificationCenter.default.post(name:.DidChangeUrlStarInSettings, object: .none)
    }
    
    func changeStarButton(_ isStar: Bool){
        switch isStar{
        case true:
            starButton.image = UIImage(systemName: "star.fill")
        default:
            starButton.image = UIImage(systemName: "star")
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 6, bottom: 8, right: 6))
//        validationButton.setTitle("aaa", for: .normal)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute(){
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 100/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1.0).cgColor
        contentView.layer.cornerRadius = 10
        backgroundColor = .white
        
        aliasLabel.backgroundColor = .white
        aliasLabel.font = .systemFont(ofSize: 18.0, weight: .bold)
        aliasLabel.textColor = .black
        aliasLabel.text = "URL별칭"
        aliasLabel.textAlignment = .center
        aliasLabel.isEnabled = false
        
        reviseButton.image = UIImage(systemName: "pencil")
        reviseButton.isUserInteractionEnabled = true
        let pencilSettingTap = UITapGestureRecognizer(target: self, action: #selector(settingTapped))
        reviseButton.addGestureRecognizer(pencilSettingTap)
        
        urlLabel.backgroundColor = .white
        urlLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        urlLabel.textColor = .darkGray
        urlLabel.text = "www.abababababab.com"
        
        starButton.image = UIImage(systemName: "star")
        starButton.translatesAutoresizingMaskIntoConstraints = false
        starButton.contentMode = .scaleAspectFill
        starButton.clipsToBounds = true
        starButton.backgroundColor = .white
        starButton.isUserInteractionEnabled = true
        let starSettingTap = UITapGestureRecognizer(target: self, action: #selector(didClickStarButton))
        starButton.addGestureRecognizer(starSettingTap)
        
        validationButton.backgroundColor = .systemBackground
        validationButton.layer.borderColor = UIColor.darkGray.cgColor
        validationButton.layer.borderWidth = 2
        validationButton.layer.cornerRadius = 6
        validationButton.addTarget(self, action: #selector(didClickValidButton), for: .touchUpInside)
        validationButton.setTitle("만료", for: .normal)
        validationButton.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .bold)
        validationButton.setTitleColor(.darkGray, for: .normal)
        
    }
    
    private func layout(){
        [aliasLabel, reviseButton, urlLabel, starButton, validationButton].forEach{
            addSubview($0)
        }
        
        aliasLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(6)
            $0.leading.equalToSuperview().inset(6)
//            $0.width.equalTo(100)
//            $0.height.equalTo(30)
        }
        
        reviseButton.snp.makeConstraints{
            $0.bottom.equalTo(aliasLabel.snp.bottom).offset(2)
            $0.leading.equalTo(aliasLabel.snp.trailing).offset(2)
            $0.width.equalTo(18)
            $0.height.equalTo(18)
        }
        
        urlLabel.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(6)
            $0.leading.equalToSuperview().inset(6)
            $0.width.equalTo(250)
            $0.height.equalTo(30)
        }
        
        starButton.snp.makeConstraints{
            $0.top.equalToSuperview().inset(6)
            $0.trailing.equalToSuperview().inset(6)
            $0.width.equalTo(22)
            $0.height.equalTo(22)
        }
        
        validationButton.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(6)
            $0.trailing.equalToSuperview().inset(6)
            $0.width.equalTo(60)
            $0.height.equalTo(30)
        }
        
    }
    
    func setup(urlAlias: String, url: String, isValid: Bool, isStar: Bool, rowNum: Int ){
        self.aliasLabel.text = urlAlias
        self.urlLabel.text = url
        self.isValid = isValid
        self.rowNum = rowNum
        changeValidButton(isValid)
        self.isStar = isStar
        changeStarButton(isStar)
    }
}

class WebViewController: UIViewController, WKNavigationDelegate,
    WKUIDelegate {

    var webView: WKWebView!

    override func loadView() {
        super.loadView()
        print("load view")
        webView = WKWebView(frame: self.view.frame)
        self.view = self.webView!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("vdl")
        let sURL = "https://fisis.fss.or.kr/fss/fsiview/indexw_ng.html"
        let uURL = URL(string: sURL)
        var request = URLRequest(url: uURL!)
        webView.load(request)
    }
}
