//
//  ButtonListViewCellCell.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/04.
//

import UIKit
import SnapKit

final class ButtonListViewCellCell: UICollectionViewCell{
    
    private lazy var titleButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute(){
        titleButton.setTitleColor(.black, for: .normal)
        titleButton.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .bold)
        titleButton.backgroundColor = .cyan
        titleButton.layer.cornerRadius = 12.0
        titleButton.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        
    }
    
    private func layout() {
        [ titleButton].forEach{ addSubview($0)}
        
        titleButton.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    @objc func btnClicked(){
        self.titleButton.backgroundColor = .brown
    }
    
    func setup(title: String){
        titleButton.setTitle(title, for: .normal)
    }
    
   
    
}
