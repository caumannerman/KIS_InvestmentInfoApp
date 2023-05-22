//
//  MarketView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/12.
//

import UIKit
import SnapKit

class MarketCollectionView: UICollectionView {
    
    private var contents: [String] = ["항목1", "항목2", "항목3", "항목7", "항목13", "항목14", "항목32", "항목51", "항목61", "항목last"]
    private var cellSize: Array<(Int, Int)> = [(1,1), (1,1), (1,1), (1,1), (1,1), (1,1), (1,1), (1,1), (1,1), (1,1)]
    private final let UNIT_WIDTH: Int = Int(( UIScreen.main.bounds.width - 50 ) / 4)
    
    
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
        guard let now_dict = notification.userInfo as? Dictionary<String, Any> else { return }
        print("신호 받음!!!")
        print(now_dict)
        guard let now_item = now_dict["item"] as? String else { return }
        
        contents.append(now_item)
        cellSize.append((1, 1))
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
        return contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketCollectionViewCell", for: indexPath) as? MarketCollectionViewCell else { return UICollectionViewCell() }
        cell.setup(title: contents[indexPath.row])
        return cell
    }
    
}

extension MarketCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let now_width: Int = cellSize[indexPath.row].0
        let now_height: Int = cellSize[indexPath.row].1
        
        return CGSize(width: now_width * UNIT_WIDTH + 10 * (now_width - 1), height: now_height * UNIT_WIDTH + 10 * (now_height - 1))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(contents[indexPath.row])
        print("Clicked CV cell")
        
        NotificationCenter.default.post(name:.DidTapMarketInfoCell, object: .none, userInfo: ["idx": contents[indexPath.row]])
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



//extension MarketCollectionView: UICollectionViewDropDelegate {
//    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
//            var destinationIndexPath: IndexPath
//            if let indexPath = coordinator.destinationIndexPath {
//                destinationIndexPath = indexPath
//            } else {
//                let row = collectionView.numberOfItems(inSection: 0)
//                destinationIndexPath = IndexPath(item: row - 1, section: 0)
//            }
//
//            if coordinator.proposal.operation == .move {
//                reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
//            }
//        }
//
//        func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
//            if collectionView.hasActiveDrag {
//                return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
//            }
//            return UICollectionViewDropProposal(operation: .forbidden)
//        }
//
//        private func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
//            if
//                let item = coordinator.items.first,
//                let sourceIndexPath = item.sourceIndexPath {
//                collectionView.performBatchUpdates({
//                    let temp = contents[sourceIndexPath.item]
//                    contents.remove(at: sourceIndexPath.item)
//                    contents.insert(temp, at: destinationIndexPath.item)
//                    collectionView.deleteItems(at: [sourceIndexPath])
//                    collectionView.insertItems(at: [destinationIndexPath])
//                }) { done in
//                    //
//                }
//                coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
//            }
//        }
//}
//
//extension MarketCollectionView: UICollectionViewDragDelegate {
//    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//        return []
//    }
//}
