//
//  ShowDataViewCollectionViewCell.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/07.
//

import UIKit


class ShowDataViewCollectionViewCell: UICollectionViewCell{
    
    private lazy var titleButton = UIButton()
    private var rowNum: Int = -1
    private var colNum: Int = -1
    private var isClicked: Bool = false
    
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
        titleButton.backgroundColor = UIColor(red: 230 / 255.0, green: 230 / 255.0, blue: 230 / 255.0, alpha: 1.0)
//        titleButton.layer.cornerRadius = 12.0
        titleButton.layer.borderWidth = 1.0
        titleButton.layer.borderColor = UIColor.lightGray.cgColor
        titleButton.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        titleButton.isEnabled = false
    }
    
    private func layout() {
        [ titleButton].forEach{ addSubview($0)}
        
        titleButton.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    @objc func btnClicked(){
        if self.isClicked{
            self.titleButton.backgroundColor = UIColor(red: 230 / 255.0, green: 230 / 255.0, blue: 230 / 255.0, alpha: 1.0)
        }
        else{
            self.titleButton.backgroundColor = UIColor(red: 153 / 460.0, green: 280 / 460.0, blue: 459 / 460.0, alpha: 1.0)
        }
        self.isClicked = !self.isClicked
       
        //버튼 클릭 시, 버튼클릭여부 Bool 값을 반대로 바꾸라고 신호를 보내줘야함
        NotificationCenter.default.post(name: .cellColorChange, object: nil, userInfo: ["row": rowNum, "col": colNum])
    }
    
   
    
    // firstColumn인 경우에는 인덱스 번호를( 날짜 정보를 다 받아와줄 수는 없다. json에 날짜가 없을 수 있으니), firstRow인 경우에는 column이름들을 출력해줘야할 것이다.
    // FirstColumn 혹은 FirstRow인 경우에는 모드 Clickable,  둘 다 False인 경우에는 모두 UnClickable이어야한다.
    func setup(isFirstRow: Bool, isFirstColumn: Bool, title: String, isClicked: Bool, rowIdx: Int, colIdx: Int){
        self.rowNum = rowIdx
        self.colNum = colIdx
        if isFirstRow && isFirstColumn{
            titleButton.setTitle("선택", for: .normal)
            titleButton.isEnabled = false
        }
        else if isFirstRow && !isFirstColumn{
            titleButton.setTitle(title, for: .normal)
            //클릭 가능하게
            titleButton.isEnabled = true
        }
        else if !isFirstRow && isFirstColumn{
            //인덱스 번호를 매개변수로 받아올 것이며 1,2,3,4 차례로 설정할 것
            titleButton.setTitle(title, for: .normal)
            //클릭 가능하게
            titleButton.isEnabled = true
        }
        else{
            //이미 비활되어있으므로, title만 바꿔주면 됨
            titleButton.setTitle(title, for: .normal)
            titleButton.isEnabled = false
        }
        
        self.isClicked = isClicked
        // 클릭 상태면 파란색으로
        if isClicked{
            titleButton.backgroundColor = UIColor(red: 153 / 460.0, green: 280 / 460.0, blue: 459 / 460.0, alpha: 1.0)
        }//클릭 X 상태면 밝은 회색
        else{
            titleButton.backgroundColor = UIColor(red: 230 / 255.0, green: 230 / 255.0, blue: 230 / 255.0, alpha: 1.0)
        }
        
    }
    
}

