//
//  AddHeaderViewCell.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/02.
//

import UIKit
import SnapKit

final class AddHeaderViewCell: UITableViewCell {
    
    private lazy var textView: UITextView = {
        let tv = UITextView()
        tv.layer.borderWidth = 2
        tv.layer.borderColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0).cgColor
        tv.layer.cornerRadius = 10
        return tv
    }()
    
    private lazy var addButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 3.0
        btn.layer.borderWidth = 2.0
        btn.layer.borderColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0).cgColor
        btn.backgroundColor = .black
        btn.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .semibold)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute(){
        
    }
    
    private func layout(){
        [textView, addButton].forEach{
            addSubview($0)
        }
        
        textView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(50)
        }
        
        addButton.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(textView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
}
