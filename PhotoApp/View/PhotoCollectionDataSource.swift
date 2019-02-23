/*
 FileName : PhotoCollectionDataSource.swift
 Description : Seperating the datasource methods for the collection view
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 02/21/19
 =============================================================================
 */

import Foundation
import UIKit

enum CollectionViewCellConstants{
    static let cellPerRowIPhone = 1
    static let cellPerRowIPad = 2
}

class PhotoCollectionDataSource:NSObject, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    
    let inset: CGFloat = 10
    let minimumLineSpacing: CGFloat = 0
    let minimumInteritemSpacing: CGFloat = 0
    var viewModel : PhotoDataViewModel
    
    init(viewModel: PhotoDataViewModel) {
        self.viewModel = viewModel
        
    }
    
    // MARK:- UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.picturesToDisplay(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Configure the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier,
                                                      for: indexPath) as! PhotoCollectionViewCell
        
        guard let rowModel = viewModel.model.rowsData?[indexPath.row] else {
            return cell
        }
        ///The main screen title
        cell.photoTitle.text = rowModel.titleStr
        
        ///Assigning the Description and ImageUrls
        let urlstr = rowModel.linkStr
        cell.photoImgView.sd_setImage(with: URL(string:  urlstr!),
                                      placeholderImage: UIImage(named: Constants.placeHolderImage))
        cell.photoDescription.text = rowModel.descriptionStr
        cell.backgroundColor = .clear
        cell.layoutIfNeeded()
        return cell
    }
}


//MARK:- COLLECTION VIEW
extension PhotoCollectionDataSource{
    
    
    func estimateFrameForText(text: String, font : UIFont, collectionView: UICollectionView) -> CGRect {
        let noOfCellInRow = viewModel.getCellPerRow()
        var marginsAndInsets = 0.0
        if #available(iOS 11.0, *) {
            marginsAndInsets = Double(Int((inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right +  25 + minimumInteritemSpacing * CGFloat(noOfCellInRow - 1))))
            
        }else{
            marginsAndInsets = Double((inset * 2 + 25 + minimumInteritemSpacing * CGFloat(noOfCellInRow - 1)))
        }
        
        let boundsWidth = Double(collectionView.bounds.size.width )
        let divideValue = Double((CGFloat(noOfCellInRow)).rounded(.down))
        let itemWidth = ((boundsWidth - marginsAndInsets) / divideValue)
        let size = CGSize(width: itemWidth - 120, height: Constants.CellFrames.height)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: font]
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard  let rowModel = viewModel.model.rowsData?[indexPath.row] else{
            return CGSize(width: 0, height: 0)
        }
         let noOfCellInRow = viewModel.getCellPerRow()
        let padding: CGFloat = 0
        var titleHeight = 2.0
        var detailHeight = 2.0
        //estimate each cell's height
        if let titleText = rowModel.titleStr {
            titleHeight = Double(estimateFrameForText(text: titleText,
                                                      font: UIFont.boldSystemFont(ofSize:18), collectionView: collectionView).height + padding)
        }
        if let detailText = rowModel.descriptionStr {
            detailHeight = Double(estimateFrameForText(text: detailText,
                                                       font: UIFont.systemFont(ofSize: 14), collectionView: collectionView).height + padding)
        }
        var totalHeight = titleHeight + detailHeight  + Constants.CollectionViewPaddings.imgPadding
        if (totalHeight < Constants.CellFrames.imgHeight)
        {
            //Take atleast image height
            totalHeight = Constants.CellFrames.imgHeight
        }
        var marginsAndInsets : CGFloat = 0.0
        
        if #available(iOS 11.0, *) {
            marginsAndInsets = CGFloat(inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + Constants.CollectionViewPaddings.insetsPadding + minimumInteritemSpacing * CGFloat(noOfCellInRow - 1))
        } else {
            // Fallback on earlier versions
            // marginsAndInsets = CGFloat(inset * 2 +  minimumInteritemSpacing * CGFloat(cellsPerRow - 1) + 25)
            marginsAndInsets = CGFloat(inset * 2 +  minimumInteritemSpacing * CGFloat(noOfCellInRow - 1) + Constants.CollectionViewPaddings.insetsPadding)
        }
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(noOfCellInRow)).rounded(.down)
        
        return CGSize(width: Double(itemWidth), height: totalHeight )
        
    }
    
}
