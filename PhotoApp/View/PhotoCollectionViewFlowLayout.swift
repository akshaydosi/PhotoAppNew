//
//  PhotoCollectionViewFlowLayout.swift
//  PhotoApp
//
//  Created by CTS_MacBookPro on 23/01/19.
//  Copyright © 2019 Cognizant. All rights reserved.
//

import UIKit

class PhotoCollectionViewFlowLayout: UICollectionViewFlowLayout {
    let innerSpace: CGFloat = 1.0
    let numberOfCellsOnRow: CGFloat = 3
   
    override init() {
        super.init()
        self.minimumLineSpacing = innerSpace
        self.minimumInteritemSpacing = innerSpace
        self.scrollDirection = .vertical
        
        //let width = UIScreen.main.bounds.size.width
        
        //self.estimatedItemSize = CGSize(width:width, height:10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    func itemWidth() -> CGFloat {
        
        return (collectionView!.frame.size.width/self.numberOfCellsOnRow)-self.innerSpace
    }
    
    override var itemSize: CGSize {
        set {
            
            self.itemSize = CGSize(width:355, height:1000)
        }
        get {
            let sizes = CGSize(width:355
                ,height:1000)
                print("itemSize \(sizes)")
            return sizes
        }
    
    }
   
}
