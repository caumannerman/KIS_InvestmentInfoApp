//
//  ButtonListViewCell.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/02.
//

import UIKit
import SnapKit

final class ButtonListViewCell: UITableViewCell{
    
    private var buttonElementsArr: [String] = ["1","2","3","4","5","6","7","1","2","3","4","5","6","7"]
    
//    private var collectionView = UICollectionView()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ButtonListViewCellCell.self, forCellWithReuseIdentifier: "ButtonListViewCellCell")
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = true

        collectionView.backgroundColor = .lightGray
//        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
        
//        let layout = UICollectionViewFlowLayout()
//        //layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
//        layout.minimumLineSpacing = 10
//        layout.minimumInteritemSpacing = 10
//        layout.scrollDirection = .horizontal
//
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.register(ButtonListViewCellCell.self, forCellWithReuseIdentifier: "ButtonListViewCellCell")
//        collectionView.dataSource = self
//        collectionView.delegate = self
////        collectionView.isPagingEnabled = true
//        collectionView.showsHorizontalScrollIndicator = true
//
//        collectionView.backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
//        setupLayout()
//        titleLabel.setTitle(title, for: .normal)
    }
    
    func setupLayout(){
        [ collectionView].forEach{ addSubview($0)}
        
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.height.equalTo(30)
        }
    }
}

extension ButtonListViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        buttonElementsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonListViewCellCell", for: indexPath) as? ButtonListViewCellCell else { return UICollectionViewCell() }
        
        cell.setup(title: buttonElementsArr[indexPath.row])
        
        return cell
    }

}

extension ButtonListViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: 26)
    }
    
}
extension ButtonListViewCell: UICollectionViewDelegate{

}


