/*
 FileName : PhotoCollectionViewCell.swift
 Description : Custom CollectionView Cell for Title/Image and Descirption
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 01/23/19
 =============================================================================
 */
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    let photoTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let photoImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let photoDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    let topSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bottomSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PhotoCollectionViewCell{
    func addViews(){
        backgroundColor = UIColor.white
        
        
        addSubview(photoDescription)
        addSubview(photoImgView)
        addSubview(photoTitle)
        addSubview(topSeparatorView)
        
        photoTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        photoTitle.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 0).isActive = true
        photoTitle.rightAnchor.constraint(equalTo: self.rightAnchor,constant: 0).isActive = true
        
        photoImgView.topAnchor.constraint(equalTo: photoTitle.bottomAnchor, constant: 10).isActive = true
        photoImgView.leftAnchor.constraint(equalTo:  self.leftAnchor,constant: 0).isActive = true
        photoImgView.rightAnchor.constraint(equalTo: self.rightAnchor,constant: 0).isActive = true
        photoImgView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        photoDescription.topAnchor.constraint(equalTo: photoImgView.bottomAnchor, constant: 10).isActive = true
        photoDescription.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 0).isActive = true
        photoDescription.rightAnchor.constraint(equalTo: self.rightAnchor,constant: 0).isActive = true
        
        
        topSeparatorView.topAnchor.constraint(equalTo: photoDescription.bottomAnchor, constant: 10).isActive = true
        topSeparatorView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        topSeparatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        topSeparatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}
