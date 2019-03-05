/*
 FileName : PhotoCollectionViewDataSource
 Description : Seperating the datasource methods for the collection view
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 02/21/19
 =============================================================================
 */

import Foundation
import UIKit
import SDWebImage

class PhotoCollectionViewDataSource: NSObject, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    let inset: CGFloat = 20.0
    var viewModel: PhotoDataViewModel

    init(viewModel: PhotoDataViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.rowCount(in: section)
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // Configure the cell
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier,
                                                         for: indexPath) as? PhotoCollectionViewCell {
            if let rowModel = viewModel.model.rows?[indexPath.row] {
                ///adding the photo title to the title of cell
                cell.photoTitle.text = rowModel.title
                ///Assigning the Description and ImageUrls
                cell.photoImgView.sd_setImage(with: URL(string: rowModel.imageHref ?? ""),
                                              placeholderImage: UIImage(named: Constants.placeHolderImage))
                cell.photoDescription.text = rowModel.description
                cell.backgroundColor = .clear
                cell.layoutIfNeeded()
                return cell
            }
        }
        return UICollectionViewCell()
    }
}

// MARK: - COLLECTION VIEW
extension PhotoCollectionViewDataSource {
    ///Dynamic text size for the Title and Description
    func estimateFrameForText(text: String, font: UIFont, collectionView: UICollectionView) -> CGRect {
        let noOfCellInRow = viewModel.getCellPerRow()
        var marginsAndInsets = 0.0
        if #available(iOS 11.0, *) {
            marginsAndInsets = Double(Int((inset + collectionView.safeAreaInsets.left
                + collectionView.safeAreaInsets.right
                + Constants.CollectionViewPaddings.insetsPadding)))

        } else {
            marginsAndInsets = Double((inset + Constants.CollectionViewPaddings.insetsPadding))
        }

        let boundsWidth = Double(collectionView.bounds.size.width )
        let divideValue = Double((CGFloat(noOfCellInRow)).rounded(.down))
        let itemWidth = ((boundsWidth - marginsAndInsets) / divideValue)
        let size = CGSize(width: itemWidth - Double(Constants.CollectionViewPaddings.imgHeight),
                          height: Constants.CellFrames.height)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: font]

        return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        guard  let rowModel = viewModel.model.rows?[indexPath.row] else {
            return CGSize(width: 0, height: 0)
        }
        let noOfCellInRow = viewModel.getCellPerRow()
        var titleHeight = 2.0///arbitary values
        var detailHeight = 2.0///arbitary values
        //estimate each cell's height
        if let titleText = rowModel.title {
            titleHeight = Double(estimateFrameForText(text: titleText,
                                                      font: .boldSystemFont(ofSize: Constants.FontSizes.medium),
                                                      collectionView: collectionView).height)
        }
        if let detailText = rowModel.description {
            detailHeight = Double(estimateFrameForText(text: detailText,
                                                       font: .systemFont(ofSize: Constants.FontSizes.small),
                                                       collectionView: collectionView).height)
        }
        var totalHeight = titleHeight + detailHeight  + Constants.CollectionViewPaddings.imgPadding
        if totalHeight < Constants.CellFrames.imgHeight {
            //Take atleast image height
            totalHeight = Constants.CellFrames.imgHeight
        }
        var marginsAndInsets: CGFloat = 0.0

        if #available(iOS 11.0, *) {
            marginsAndInsets = CGFloat(inset + collectionView.safeAreaInsets.left
                + collectionView.safeAreaInsets.right + Constants.CollectionViewPaddings.insetsPadding )
        } else {
            // Fallback on earlier versions
            marginsAndInsets = CGFloat(inset + Constants.CollectionViewPaddings.insetsPadding)
        }
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(noOfCellInRow)).rounded(.down)

        return CGSize(width: Double(itemWidth), height: totalHeight )

    }
}
