//
//  ApiListTableViewCell.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/04/25.
//

import UIKit
import SnapKit

class ApiListTableViewCell: UITableViewCell {
    
    private var isValid: Bool = false
    private var isStar: Bool = false
    
    private lazy var aliasLabel: UITextField = {
        let label = UITextField()
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.textColor = .black
        label.text = "URL별칭"
        label.textAlignment = .center
        label.isEnabled = false
        return label
    }()
    
    private lazy var reviseButton: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "pencil")
        iv.isUserInteractionEnabled = true
        let settingTap = UITapGestureRecognizer(target: self, action: #selector(settingTapped))
        iv.addGestureRecognizer(settingTap)
        return iv
    }()
    
    private lazy var urlLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        label.textColor = .darkGray
        label.text = "www.abababababab.com"
        return label
    }()
    
    private lazy var starButton: UIImageView = {
        let iv = UIImageView()
        
        iv.image = UIImage(systemName: "star")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        
        iv.isUserInteractionEnabled = true
        let settingTap = UITapGestureRecognizer(target: self, action: #selector(didClickStarButton))
        iv.addGestureRecognizer(settingTap)
        
        return iv
    }()
    
    private lazy var validationButton: UIButton = {
        let btn = UIButton()
        
        btn.backgroundColor = .systemBackground
        btn.layer.borderColor = UIColor.darkGray.cgColor
        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 6
        btn.addTarget(self, action: #selector(didClickValidButton), for: .touchUpInside)
        btn.setTitle("만료", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .bold)
        btn.setTitleColor(.darkGray, for: .normal)
        
        
        return btn
    }()
    
    @objc func settingTapped(){
        print("연필 클릭")
        aliasLabel.isEnabled = true
        
    }
    @objc func didClickValidButton(){
        print("didValidButton click")
        isValid = !isValid
        if self.isValid {
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
    

}
