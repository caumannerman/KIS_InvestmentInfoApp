//
//  MarketCVCellCollectionView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/17.
//

import UIKit
import SnapKit

class MarketCVCellCollectionView: UICollectionView {
    
    private var contents: [String] = ["항목1", "항목2", "항목3"]
 
    private final let UNIT_WIDTH: Int = Int(( UIScreen.main.bounds.width - 50 ) / 4)
    
    
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
        
        self.register( MarketCVCellCollectionViewCell.self, forCellWithReuseIdentifier: "MarketCVCellCollectionViewCell")
        self.showsHorizontalScrollIndicator = true
        self.layer.borderWidth = 0
//        self.layer.borderColor = UIColor.lightGray.cgColor
        self.backgroundColor = UIColor(red: 200/255, green: 50/255, blue: 250/255, alpha: 1.0)
        self.isPagingEnabled = true
        
        self.dataSource = self
        self.delegate = self

        self.dragInteractionEnabled = true
        
        //gesture Recognizer 추가
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_: )))
        self.addGestureRecognizer(gesture)
    }
    
}

extension MarketCVCellCollectionView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if contents.count >= 4 {
            return 4
        }
        return contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketCVCellCollectionViewCell", for: indexPath) as? MarketCVCellCollectionViewCell else { return UICollectionViewCell() }
//        cell.setup(title: contents[indexPath.row])
        return cell
    }
    
}

extension MarketCVCellCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: Int((UNIT_WIDTH - 36) / 2), height: Int((UNIT_WIDTH - 36) / 2))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(contents[indexPath.row])
        print("Clicked CVCellCell")
        
//        NotificationCenter.default.post(name:.DidTapMarketInfoCell, object: .none, userInfo: ["idx": contents[indexPath.row]])
    }
}


extension MarketCVCellCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        true
    }
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        print("전 : ", contents)
//        let item = contents.remove(at: sourceIndexPath.row)
//        print("제거중 : ", contents)
//        contents.insert(item, at: destinationIndexPath.row)
//        cellSize[destinationIndexPath.row].0 = 1
//        print("후 : ", contents)
//        print(sourceIndexPath.item.z)
        self.reloadData()
    }
}


extension MarketCVCellCollectionView{

    @objc func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer){
        switch gesture.state {
        case .began:
            guard let targetIndexPath = self.indexPathForItem(at: gesture.location(in: self)) else {
                return
            }
            print(targetIndexPath)
            print("began")
            print("target : ", targetIndexPath.row)
            self.beginInteractiveMovementForItem(at: targetIndexPath)
            
        case .changed:
            self.updateInteractiveMovementTargetPosition(gesture.location(in: self))
            print("changed")
            print("location: ", gesture.location(in: self))
            
        case .ended:
            self.endInteractiveMovement()
            print("end")
        default:
            print("default")
            //취소
            self.cancelInteractiveMovement()
        }
    }
}
