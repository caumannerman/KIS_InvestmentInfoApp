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
    private let scrollView = UIScrollView()
    private let subTitleLabel = UILabel()

    private let tableView = UITableView()
    
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
        
        scrollView.showsHorizontalScrollIndicator = false
        titleLabel.font = .systemFont(ofSize: 32.0, weight: .bold)
        titleLabel.textColor = .darkGray
        titleLabel.textAlignment = .center
        
        subTitleLabel.font = .systemFont(ofSize: 20.0, weight: .bold)
        subTitleLabel.textColor = .darkGray
        subTitleLabel.textAlignment = .left
        
        tableView.backgroundColor = .yellow
        tableView.isHidden = true
    }
    @objc func modeButtonClicked(){
        print("clicked")
        switch self.showMode {
        case .Simple:
            self.showMode = .AllTextData
            modeButton.setTitle("all", for: .normal)
            changeLayoutByMode()
        case .AllTextData:
            self.showMode = .price3Chart
            modeButton.setTitle("chart", for: .normal)
            changeLayoutByMode()
        case .price3Chart:
            self.showMode = .Simple
            modeButton.setTitle("simple", for: .normal)
            changeLayoutByMode()
        }
    }
    
    private func changeLayoutByMode(){
        switch self.showMode {
        case .Simple:
            titleLabel.isHidden = false
            titleLabel.font = .systemFont(ofSize: 32.0, weight: .bold)
            titleLabel.snp.removeConstraints()
            titleLabel.snp.makeConstraints{
                $0.leading.trailing.equalToSuperview().inset(10)
                $0.centerY.equalToSuperview().offset(-20)
            }
            
            scrollView.isHidden = false
            
        case .AllTextData:
            titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
            titleLabel.snp.removeConstraints()
            scrollView.isHidden = true
            addSubview(titleLabel)
            titleLabel.snp.makeConstraints{
                $0.leading.top.equalToSuperview().inset(10)
            }
            tableView.isHidden = false
            addSubview(tableView)
            tableView.snp.makeConstraints{
                $0.top.equalTo(modeButton.snp.bottom).offset(8)
                $0.leading.trailing.bottom.equalToSuperview().inset(10)
            }
            
           
        case .price3Chart:
            tableView.isHidden = true
        }
    }
    private func layout(){
        [ modeButton, titleLabel, scrollView ].forEach{ addSubview($0)}
        
        modeButton.snp.makeConstraints{
            $0.top.trailing.equalToSuperview().inset(6)
            $0.height.equalTo(30)
            $0.width.equalTo("simple".size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10, weight: .regular)]).width + 20)
        }
        
        titleLabel.snp.makeConstraints{
//            $0.top.equalTo(modeButton.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview().offset(-20)
            
        }
        scrollView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(26)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(6)
        }
        scrollView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }

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

