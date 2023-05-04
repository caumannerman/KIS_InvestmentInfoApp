//
//  ChartViewCollectionViewCell.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/04.
//

import UIKit
import SnapKit

final class ChartViewCollectionViewCell: UICollectionViewCell{
    
    private var isClicked: Bool = false
    private var rowNum: Int = -1
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
        layer.borderWidth = 2
        layer.borderColor = UIColor(red: 210/255, green: 157/255, blue: 200/255, alpha: 1.0).cgColor
        layer.cornerRadius = 10.0
        self.backgroundColor = .systemBackground
       
        titleButton.backgroundColor = .white
        titleButton.setTitleColor(.black, for: .normal)
        titleButton.titleLabel?.font = .systemFont(ofSize: 32.0, weight: .bold)
        titleButton.setTitle("채권", for: .normal)
        titleButton.addTarget(self, action: #selector(didClickCell), for: .touchUpInside)
    }
    //false인 것을 눌렀을 때만 NotificationCenter로 신호를 보내도록 개발하였음
    @objc func didClickCell(){
        print("cell clicked!!")
        if isClicked{
            return
        }
        self.isClicked = !isClicked
        if isClicked{
            titleButton.backgroundColor = UIColor(red: 230/255, green: 240/255, blue: 255/255, alpha: 1.0)
        }else {
            titleButton.backgroundColor = .white
        }
        print(isClicked)
        NotificationCenter.default.post(name: .chartSectionChanged, object: nil, userInfo: ["row": rowNum])
        print("changed")
    }
    
    private func layout() {
        [ titleButton ].forEach{ addSubview($0)}
        
        titleButton.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func setup(title: String, rowNum: Int){
        titleButton.setTitle(title, for: .normal)
        self.rowNum = rowNum
    }
  
}

extension Notification.Name {
    static let chartSectionChanged = Notification.Name("chartSectionChanged")
}
