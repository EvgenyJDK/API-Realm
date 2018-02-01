//
//  ColumnsFlowLayout.swift
//  AnimationApp
//
//  Created by Administrator on 01.02.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import Foundation
import UIKit

class ColumnsFlowLayout: UICollectionViewFlowLayout {
    
    @IBInspectable
    dynamic var columnCount: Int = 1 {
        willSet {
            collectionView?.reloadData()
        }
    }
    
    @IBInspectable
    dynamic var itemSpacing: Int = 0 {
        willSet {
            minimumInteritemSpacing = CGFloat(newValue)
            minimumLineSpacing = CGFloat(newValue)
            collectionView?.reloadData()
        }
    }
    
    @IBInspectable
    dynamic var heightWidthRatio: CGFloat = 1.0 {
        willSet {
            collectionView?.reloadData()
        }
    }
    
    override var itemSize: CGSize {
        set {
            
        }
        get {
            guard let width = collectionView?.frame.size.width
                else {
                    return .zero
            }
            let itemWidth = (width - (CGFloat(columnCount) - 1) * CGFloat(itemSpacing))
                / CGFloat(columnCount)
            let itemHeight = heightWidthRatio * itemWidth
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
}
