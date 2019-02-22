/*
 FileName : PhotoCollectionDataSource.swift
 Description : Seperating the datasource methods for the collection view
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 02/21/19
 =============================================================================
 */

import Foundation
import UIKit

class PhotoCollectionDataSource:NSObject, UICollectionViewDataSource{
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

