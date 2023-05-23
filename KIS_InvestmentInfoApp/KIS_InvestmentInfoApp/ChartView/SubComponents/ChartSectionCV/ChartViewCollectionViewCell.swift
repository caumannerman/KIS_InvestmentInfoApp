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
    
//    @objc func noticedSelectedCellIdx(_ notification: Notification){
//        guard let clickedIdx = notification.userInfo?["idx"] as? Int else { return }
//        print(clickedIdx, "선택된 cell 공지됨")
//        // 선택된 cell이 본인이라면 상태 변경
//        if rowNum == clickedIdx {
//            self.isClicked = !isClicked
//            layer.borderWidth = 3
//            layer.borderColor = UIColor(red: 200/255, green: 210/255, blue: 250/255, alpha: 1.0).cgColor
//        }else if isClicked { //선택되었다가 해제해야하는 경우
//            self.isClicked = !isClicked
//            layer.borderWidth = 2
//            layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0).cgColor
//        }
//    }
    
    private func attribute(){
        layer.borderWidth = 2
        layer.borderColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0).cgColor
        layer.cornerRadius = 10.0
        self.backgroundColor = .white
       
        titleButton.backgroundColor = .white
        titleButton.setTitleColor(.black, for: .normal)
        titleButton.titleLabel?.font = .systemFont(ofSize: 32.0, weight: .bold)
        titleButton.setTitle("채권", for: .normal)
        titleButton.layer.cornerRadius = 10.0
        titleButton.addTarget(self, action: #selector(didClickCell), for: .touchUpInside)
    }
    //false인 것을 눌렀을 때만 NotificationCenter로 신호를 보내도록 개발하였음
    @objc func didClickCell(){
        print("cell clicked!!")
        // 현재 isClicked가 false일 때만
        if isClicked{
            return
        }
        // isClicked를 true로 바꾸고 notiCenter로 DidTapUnClickedCell신호를 보냄
        NotificationCenter.default.post(name: .DidTapUnClickedCell, object: nil, userInfo: ["row": rowNum])
    }
    
    private func layout() {
        [ titleButton ].forEach{ addSubview($0)}
        
        titleButton.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func setup(title: String, isClicked: Bool, rowNum: Int){
        titleButton.setTitle(title, for: .normal)
        self.rowNum = rowNum
        // 첫 cell( 맨 처음 선택되어있어야하는 cell )
        if isClicked {
            self.isClicked = true
            layer.borderWidth = 5
            layer.borderColor = UIColor(red: 200/255, green: 210/255, blue: 250/255, alpha: 1.0).cgColor
        }
        else {
            self.isClicked = false
            layer.borderWidth = 2
            layer.borderColor = UIColor(red: 220/255, green: 230/255, blue: 255/255, alpha: 1.0).cgColor
        }
        
    }
  
}

