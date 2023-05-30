//
//  MarketCollectionViewCell.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/12.
//

import UIKit

enum MarketCellShowMode {
    case Simple
    case AllTextData
    case price3Chart
}

class MarketCollectionViewCell: UICollectionViewCell {
    
    private var showMode: MarketCellShowMode = .Simple
    private var title: String = ""
    private var subTitle: String = ""
    private var section: Int = -1
    private var subSection: Int = -1
    
    
    private let modeButton = UIButton()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
//    private let marketCVCellCollectionView = MarketCVCellCollectionView(frame: .zero, collectionViewLayout: MarketCVCellCollectionViewLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func attribute(){
        layer.borderWidth = 3
        layer.borderColor = UIColor(red: 160/255, green: 170/255, blue: 240/255, alpha: 1.0).cgColor
        layer.cornerRadius = 10.0
        layer.borderWidth = 3.0
       
        self.backgroundColor = .systemBackground
        
        modeButton.layer.borderWidth = 1.0
        modeButton.layer.borderColor = UIColor.lightGray.cgColor
        modeButton.layer.cornerRadius = 8.0
        modeButton.setTitle("simple", for: .normal)
        modeButton.setTitleColor(.lightGray, for: .normal)
        modeButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        modeButton.backgroundColor = .white
        modeButton.addTarget(self, action: #selector(modeButtonClicked), for: .touchUpInside)
        
        titleLabel.font = .systemFont(ofSize: 32.0, weight: .bold)
        titleLabel.textColor = .darkGray
        titleLabel.textAlignment = .center
    }
    @objc func modeButtonClicked(){
        print("clicked")
        switch self.showMode {
        case .Simple:
            self.showMode = .AllTextData
            modeButton.setTitle("all", for: .normal)
        case .AllTextData:
            self.showMode = .price3Chart
            modeButton.setTitle("chart", for: .normal)
        case .price3Chart:
            self.showMode = .Simple
            modeButton.setTitle("simple", for: .normal)
        }
    }
    private func layout(){
        [ modeButton, titleLabel, subTitleLabel ].forEach{ addSubview($0)}
        
        modeButton.snp.makeConstraints{
            $0.top.trailing.equalToSuperview().inset(6)
            $0.height.equalTo(30)
            $0.width.equalTo("simple".size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10, weight: .regular)]).width + 20)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(modeButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(30)
        }
        subTitleLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
//        marketCVCellCollectionView.snp.makeConstraints{
//            $0.edges.equalToSuperview().inset(12)
//        }
    }
    
    func setup(title: String, subtitle: String, section: Int, subSection: Int){
        self.titleLabel.text = title
        self.subTitleLabel.text = subtitle
        
        self.title = title
        self.subTitle = subtitle
        self.section = section
        self.subSection = subSection
    }
    
}
