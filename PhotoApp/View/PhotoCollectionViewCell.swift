/*
 FileName : PhotoCollectionViewCell.swift
 Description : Custom CollectionView Cell for Title/Image and Descirption
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 01/23/19
 =============================================================================
 */
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    lazy var cellContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var containerView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .clear
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var photoTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var photoImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    lazy var photoDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.backgroundColor = .clear
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

extension PhotoCollectionViewCell{
    func addViews(){
        backgroundColor = UIColor.white
        addSubview(cellContainerView)
        cellContainerView.addSubview(photoImgView)
        cellContainerView.addSubview(containerView)
        containerView.addSubview(photoTitle)
        containerView.addSubview(photoDescription)
 
        ///Main Container View
        cellContainerView.customAnchors(top:  self.topAnchor, left:self.leftAnchor,
                                        bottom: self.bottomAnchor, right:self.rightAnchor, paddingTop: 10,
                                        paddingLeft: 0, paddingBottom: 10, paddingRight: 5,
                                        width: 0, height: 0, enableInsets: true)
        
        ///Constraints for ImageView of the Photo
        photoImgView.customAnchors(top: cellContainerView.topAnchor, left: cellContainerView.leftAnchor,
                                   bottom: nil, right: nil, paddingTop: 10, paddingLeft: 5,
                                   paddingBottom: 0, paddingRight: 0, width: 120,
                                   height: 120, enableInsets: false)
        
        ///Constraints for inside cell in terms of container view
        containerView.customAnchors(top: cellContainerView.topAnchor, left: self.photoImgView.rightAnchor,
                                    bottom: cellContainerView.bottomAnchor,right:self.cellContainerView.rightAnchor, paddingTop: 10, paddingLeft: 5, paddingBottom: 0, paddingRight: 0,
                                    width: 0, height: 0, enableInsets: false)
        ///Constraints for PhotoTitle of the Photo in terms of container view
        photoTitle.customAnchors(top: self.containerView.topAnchor, left: self.containerView.leftAnchor,
                                 bottom: nil, right: self.containerView.rightAnchor, paddingTop: 0,
                                 paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                                 width: 0, height: 0, enableInsets: false)
        ///Constraints for Description of the Photo in terms of Title and Container view
        photoDescription.customAnchors(top: photoTitle.bottomAnchor, left: self.containerView.leftAnchor,
                                       bottom: nil, right: self.containerView.rightAnchor, paddingTop: 5,
                                       paddingLeft: 0, paddingBottom: 0, paddingRight: -5,
                                       width: 0, height: 0, enableInsets: false)

        
    }
    
}
