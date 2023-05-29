//
//  MarketView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/12.
//

import UIKit
import SnapKit

class MarketCollectionView: UICollectionView {
    
    private let hcoms = HomeContentsData.getInstance()
//    private var contents: [String] = HomeContentsData.getContentsTitle()
//    private var contentsSubtitle: [String] = HomeContentsData.getContentsSubtitle()
    
    private var cellSize: Array<(Int, Int)> = [(1,1), (1,1), (1,1), (2,2), (1,1), (1,1), (1,1), (1,1)]
    private final let UNIT_WIDTH: Int = Int(( UIScreen.main.bounds.width - 40 ) / 3)
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        bind()
        attribute()
        NotificationCenter.default.addObserver(self, selector: #selector(addNewItemOnMarketCV(_:)), name: .AddNewItemOnMarketCV, object: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addNewItemOnMarketCV(_ notification: Notification){
////        guard let now_dict = notification.userInfo as? Dictionary<String, Any> else { return }
        print("addNewItemOnMarketCV신호 받음!!!")
//        contents = HomeContentsData.getContentsTitle()
//        contentsSubtitle = HomeContentsData.getContentsSubtitle()
//        cellSize.append((1,1))
////        print(now_dict)
////        guard let now_item = now_dict["item"] as? String else { return }
//
////        contents.append(now_item)
////        cellSize.append((1, 1))
        ///
        let hcoms: HomeContentsData = HomeContentsData.getInstance()
//        print(hcoms.contentsTitle)
//        print(hcoms.contentsSubtitle)
//        print(hcoms.contentsUrl)
        self.reloadData()
    }
    
    private func bind(){
    
    }
    
    private func attribute(){
        
        self.register( MarketCollectionViewCell.self, forCellWithReuseIdentifier: "MarketCollectionViewCell")
        self.showsHorizontalScrollIndicator = true
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        self.isPagingEnabled = true
        self.dataSource = self
        self.delegate = self
//        self.dragDelegate = self
//        self.dropDelegate = self
        self.dragInteractionEnabled = true
        
        //gesture Recognizer 추가
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_: )))
        self.addGestureRecognizer(gesture)
    }
}

extension MarketCollectionView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hcoms.getContentsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketCollectionViewCell", for: indexPath) as? MarketCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setup(title: hcoms.itemTitle[indexPath.row], subtitle: hcoms.itemSubTitle[indexPath.row])
        return cell
    }
    
}

extension MarketCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let now_width: Int = cellSize[indexPath.row].0
        let now_height: Int = cellSize[indexPath.row].1
        
        return CGSize(width: now_width * UNIT_WIDTH + 10 * (now_width - 1), height: now_height * 120 + 10 * (now_height - 1))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("현재 클릭한 cell")
        print(hcoms.itemTitle[indexPath.row])
        print(hcoms.itemSubTitle[indexPath.row])
        print(hcoms.itemSection[indexPath.row])
        print(hcoms.itemSubSection[indexPath.row])

        print("Clicked CV cell")
   
        NotificationCenter.default.post(name:.DidTapMarketInfoCell, object: .none, userInfo: ["title": hcoms.itemTitle[indexPath.row], "subTitle": hcoms.itemSubTitle[indexPath.row], "section": hcoms.itemSection[indexPath.row], "subSection": hcoms.itemSubSection[indexPath.row]])
    }
}


extension MarketCollectionView: UICollectionViewDelegate {
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


extension MarketCollectionView{

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
