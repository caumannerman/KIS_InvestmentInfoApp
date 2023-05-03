//
//  UrlSearchTableViewCell.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/03.
//

import UIKit
import SnapKit

class UrlSearchTableViewCell: UITableViewCell {
    
    
    private let titleLabel = UILabel()
    
    private let urlLabel = UILabel()
    
    
    
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
        
        titleLabel.backgroundColor = .yellow
        titleLabel.font = .systemFont(ofSize: 18.0, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.text = "URL title"
        titleLabel.textAlignment = .left
        
        urlLabel.backgroundColor = .blue
        urlLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        urlLabel.textColor = .darkGray
        urlLabel.text = "URL string"
        urlLabel.textAlignment = .left
    }
    
    
    private func layout(){
        [titleLabel, urlLabel].forEach{
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(6)
            $0.leading.equalToSuperview().inset(6)
        }
        
        urlLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview().inset(6)
        }
    }
    
    
    func setup(title: String, url: String){
        titleLabel.text = title
        urlLabel.text = url
    }
}
