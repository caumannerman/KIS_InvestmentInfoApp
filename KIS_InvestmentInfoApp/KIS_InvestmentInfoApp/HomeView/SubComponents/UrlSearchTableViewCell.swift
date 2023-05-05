//
//  UrlSearchTableViewCell.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/03.
//

import UIKit
import SnapKit

class UrlSearchTableViewCell: UITableViewCell {
    
    private var isStar: Bool = false
    
    private let titleLabel = UILabel()
    private let urlLabel = UILabel()
    private let starButton = UIImageView()
    private let searchButton = UIButton()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute(){
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 100/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1.0).cgColor
        contentView.layer.cornerRadius = 6
        backgroundColor = .white
        
        titleLabel.backgroundColor = .white
        titleLabel.font = .systemFont(ofSize: 22.0, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.text = "URL title"
        titleLabel.textAlignment = .left
        
        urlLabel.backgroundColor = .white
        urlLabel.font = .systemFont(ofSize: 16.0, weight: .regular)
        urlLabel.textColor = .darkGray
        urlLabel.text = "URL string"
        urlLabel.textAlignment = .left
        
        starButton.image = UIImage(systemName: "star")
        starButton.translatesAutoresizingMaskIntoConstraints = false
        starButton.contentMode = .scaleAspectFill
        starButton.clipsToBounds = true
        starButton.backgroundColor = .white
        starButton.isUserInteractionEnabled = true
        let starSettingTap = UITapGestureRecognizer(target: self, action: #selector(didClickStarButton))
        starButton.addGestureRecognizer(starSettingTap)
        
        searchButton.backgroundColor = .systemBackground
        searchButton.layer.borderColor = UIColor.systemBlue.cgColor
        searchButton.layer.borderWidth = 3
        searchButton.layer.cornerRadius = 6
        searchButton.addTarget(self, action: #selector(didClickSearchButton), for: .touchUpInside)
        searchButton.setTitle("검색", for: .normal)
        searchButton.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .bold)
        searchButton.setTitleColor(.systemBlue, for: .normal)
    }
    @objc func didClickSearchButton(){
        print("didClickSearchButton")
    }
    @objc func didClickStarButton(){
        print("star button clicked")
        isStar = !isStar
        changeStarButton(self.isStar)
        
    }
    func changeStarButton(_ isStar: Bool){
        switch isStar{
        case true:
            starButton.image = UIImage(systemName: "star.fill")
        default:
            starButton.image = UIImage(systemName: "star")
        }
    }
    
    
    private func layout(){
        [titleLabel, urlLabel, starButton, searchButton].forEach{
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(6)
        }
        
        urlLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(6)
            $0.width.equalToSuperview().inset(30)
        }
        
        starButton.snp.makeConstraints{
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-6)
            $0.width.equalTo(22)
            $0.height.equalTo(22)
        }
        
        searchButton.snp.makeConstraints{
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(6)
            $0.width.equalTo(70)
            $0.height.equalTo(40)
        }
    }
    
    
    func setup(title: String, url: String){
        titleLabel.text = title
        urlLabel.text = url
    }
}
