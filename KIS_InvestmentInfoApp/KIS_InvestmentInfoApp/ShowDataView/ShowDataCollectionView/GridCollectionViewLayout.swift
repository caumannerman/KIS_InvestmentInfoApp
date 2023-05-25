//
//  GridCollectionViewLayout.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/09.
//

import UIKit

class GridLayout: UICollectionViewLayout {
    var cellHeight: CGFloat = 22
    var cellWidths: [CGFloat] = [] {
        didSet {
            precondition(cellWidths.filter({ $0 <= 0 }).isEmpty)
            invalidateCache()
        }
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: totalWidth, height: totalHeight)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // When bouncing, rect's origin can have a negative x or y, which is bad.
        let newRect = rect.intersection(CGRect(x: 0, y: 0, width: totalWidth, height: totalHeight))

        var poses = [UICollectionViewLayoutAttributes]()
        let rows = rowsOverlapping(newRect)
        let columns = columnsOverlapping(newRect)
        for row in rows {
            for column in columns {
                let indexPath = IndexPath(item: column, section: row)
                poses.append(pose(forCellAt: indexPath))
            }
        }

        return poses
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return pose(forCellAt: indexPath)
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return false
    }

    private struct CellSpan {
        var minX: CGFloat
        var maxX: CGFloat
    }

    private struct Cache {
        var cellSpans: [CellSpan]
        var totalWidth: CGFloat
    }

    private var _cache: Cache? = nil
    private var cache: Cache {
        if let cache = _cache { return cache }
        var spans = [CellSpan]()
        var x: CGFloat = 0
        for width in cellWidths {
            spans.append(CellSpan(minX: x, maxX: x + width))
            x += width
        }
        let cache = Cache(cellSpans: spans, totalWidth: x)
        _cache = cache
        return cache
    }

    private var totalWidth: CGFloat { return cache.totalWidth }
    private var cellSpans: [CellSpan] { return cache.cellSpans }

    private var totalHeight: CGFloat {
        return cellHeight * CGFloat(collectionView?.numberOfSections ?? 0)
    }

    private func invalidateCache() {
        _cache = nil
        invalidateLayout()
    }

    private func rowsOverlapping(_ rect: CGRect) -> Range<Int> {
        let startRow = Int(floor(rect.minY / cellHeight))
        let endRow = Int(ceil(rect.maxY / cellHeight))
        return startRow ..< endRow
    }

    private func columnsOverlapping(_ rect: CGRect) -> Range<Int> {
        let minX = rect.minX
        let maxX = rect.maxX
        if let start = cellSpans.firstIndex(where: { $0.maxX >= minX }), let end = cellSpans.lastIndex(where: { $0.minX <= maxX }) {
            return start ..< end + 1
        } else {
            return 0 ..< 0
        }
    }

    private func pose(forCellAt indexPath: IndexPath) -> UICollectionViewLayoutAttributes {
        let pose = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let row = indexPath.section
        let column = indexPath.item
        pose.frame = CGRect(x: cellSpans[column].minX, y: CGFloat(row) * cellHeight, width: cellWidths[column], height: cellHeight)
        return pose
    }
}

