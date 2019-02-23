/*
 FileName : PhotoCollectionViewFlowLayout.swift
 Description : GridLayout setting
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 01/23/19
 =============================================================================
 */

import UIKit

class PhotoCollectionViewFlowLayout: UICollectionViewFlowLayout {
    let innerSpace: CGFloat = 1.0
    let numberOfCellsOnRow: CGFloat = 3
   
    override init() {
        super.init()
        self.minimumLineSpacing = innerSpace
        self.minimumInteritemSpacing = innerSpace
        self.scrollDirection = .vertical
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func itemWidth() -> CGFloat {
        return (collectionView!.frame.size.width/self.numberOfCellsOnRow)-self.innerSpace
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width:Constants.CellFrames.width,
                                   height:Constants.CellFrames.height)
        }
        get {
            let sizes = CGSize(width:Constants.CellFrames.width,
                               height:Constants.CellFrames.height)
            return sizes
        }
    
    }
   
}
