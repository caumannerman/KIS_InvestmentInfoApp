//
//  SearchPartCollectionView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/24.
//

import UIKit
import SnapKit

class SearchPartCollectionView: UICollectionView {
    
    private var title: [String] = ["1", "2", "#", "4", "5", "6"]
    private var subtitle: [String] = ["1", "22", "333", "44444", "55555", "666666"]
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)

        bind()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind(){
    
    }
    
    private func attribute(){
        
        self.register( SearchPartCollectionViewCell.self, forCellWithReuseIdentifier: "SearchPartCollectionViewCell")
        self.showsVerticalScrollIndicator = true
        self.layer.borderWidth = 0
 
        self.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)

        self.dataSource = self
        self.delegate = self
    }
}

extension SearchPartCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return title.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchPartCollectionViewCell", for: indexPath) as? SearchPartCollectionViewCell else { return UICollectionViewCell() }
        // indexPath.rowrk 0부터 시작함
        cell.setup(title: title[indexPath.row], subtitle: subtitle[indexPath.row])
        return cell
    }
}

extension SearchPartCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (UIScreen.main.bounds.width - 40 ) / 3, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(title[indexPath.row])
    }
}

