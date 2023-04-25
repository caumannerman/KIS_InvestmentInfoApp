//
//  ApiListTableViewCell.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/04/25.
//

import UIKit
import SnapKit

class ApiListTableViewCell: UITableViewCell {
    
    
    private lazy var aliasLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemMint
        return label
    }()
    
    private lazy var urlLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        return label
    }()
    
    private lazy var validationButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .magenta
        
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 6, bottom: 8, right: 6))
        
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
        [aliasLabel, urlLabel, validationButton].forEach{
            addSubview($0)
        }
        
        aliasLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(6)
            $0.leading.equalToSuperview().inset(6)
            $0.width.equalTo(100)
            $0.height.equalTo(30)
        }
        
        urlLabel.snp.makeConstraints{
            $0.top.equalTo(aliasLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(6)
            $0.width.equalTo(250)
            $0.height.equalTo(30)
            
        }
        validationButton.snp.makeConstraints{
            $0.top.equalToSuperview().inset(6)
            $0.trailing.equalToSuperview().inset(6)
        }
        
    }
    

}
