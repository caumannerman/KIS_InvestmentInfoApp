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
        
        self.register( MarketCollectionViewCell.self, forCellWithReuseIdentifier: "MarketCollectionViewCell")
        self.showsHorizontalScrollIndicator = true
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.backgroundColor = .magenta
        self.isPagingEnabled = true
        self.dataSource = self
        self.delegate = self
        self.dragDelegate = self
        self.dropDelegate = self
        self.dragInteractionEnabled = true
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
        switch indexPath.row {
        case 0:
            return CGSize(width: ( UIScreen.main.bounds.width - 40 ) / 3, height: ( UIScreen.main.bounds.width - 40 ) / 3)
            
        case 1:
            return CGSize(width: ( UIScreen.main.bounds.width * 2 / 3 - 50 / 3 ) , height: ( UIScreen.main.bounds.width - 40 ) / 3)
        case 2, 3, 4:
            return CGSize(width: ( UIScreen.main.bounds.width - 40 ) / 3, height: ( UIScreen.main.bounds.width - 40 ) / 6)
        case 6:
            return CGSize(width: ( UIScreen.main.bounds.width - 40 ) / 3, height: ( UIScreen.main.bounds.width - 40 ) / 3)
        case 5:
            return CGSize(width: ( UIScreen.main.bounds.width - 40 ) / 3, height: ( UIScreen.main.bounds.width - 40 ) / 3)
        default:
            return CGSize(width: ( UIScreen.main.bounds.width - 40 ) / 3, height: ( UIScreen.main.bounds.width - 40 ) / 3)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(contents[indexPath.row])
        print("Clicked CV cell")
    }
}


extension MarketCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        true
    }
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
}

extension MarketCollectionView: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
            var destinationIndexPath: IndexPath
            if let indexPath = coordinator.destinationIndexPath {
                destinationIndexPath = indexPath
            } else {
                let row = collectionView.numberOfItems(inSection: 0)
                destinationIndexPath = IndexPath(item: row - 1, section: 0)
            }
            
            if coordinator.proposal.operation == .move {
                reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
            if collectionView.hasActiveDrag {
                return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
            return UICollectionViewDropProposal(operation: .forbidden)
        }
        
        private func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
            if
                let item = coordinator.items.first,
                let sourceIndexPath = item.sourceIndexPath {
                collectionView.performBatchUpdates({
                    let temp = contents[sourceIndexPath.item]
                    contents.remove(at: sourceIndexPath.item)
                    contents.insert(temp, at: destinationIndexPath.item)
                    collectionView.deleteItems(at: [sourceIndexPath])
                    collectionView.insertItems(at: [destinationIndexPath])
                }) { done in
                    //
                }
                coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
            }
        }
}

extension MarketCollectionView: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return []
    }
}
