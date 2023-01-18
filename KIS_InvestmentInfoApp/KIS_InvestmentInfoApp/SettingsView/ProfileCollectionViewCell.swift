//
//  ProfileCollectionViewCell.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/12.
//

import UIKit
import SnapKit

final class ProfileCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView()
    
    func setup(with image: UIImage){
        addSubview(imageView)
        imageView.snp.makeConstraints{ $0.edges.equalToSuperview()}
        
        imageView.image = UIImage(named: "yang")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
}
