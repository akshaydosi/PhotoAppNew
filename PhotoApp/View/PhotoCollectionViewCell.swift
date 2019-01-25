//
//  PhotoCollectionViewCell.swift
//  PhotoApp
//
//  Created by CTS_MacBookPro on 23/01/19.
//  Copyright © 2019 Cognizant. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
   /*
   // var imageView:UIImageView!
    var title:String?
    var imgDescription: String?
    
    let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .red
        imgView.layer.cornerRadius = 4.0
        imgView.clipsToBounds = true
        return imgView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "424 likes"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        return label
    }()
    let imageDescription: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "424 description"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = .red
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       // imageView = UIImageView()
        //imageView.contentMode = .scaleAspectFill
        //        imageView.isUserInteractionEnabled = false
        //contentView.addSubview(imageView)///will lead to a crash if imageview is returned as nil.
        //addSubview(titleLabel)
        //addSubview(imageDescription)
       // addSubview(imageView)
        handleConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       // addViews()
//        var frame = imageView.frame
//        /
//        frame.size.width = self.frame.size.width
//        // frame.origin.x = 0
//        // frame.origin.y = 0
//        imageView.frame = frame
        
        print("imageView.frame \(imageView.frame)")
        print("titleLabel \(titleLabel.frame)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  /*  func addViews(){
        
        let width = NSLayoutConstraint(item: titleLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        let centerX = NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self., attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        
        self.contentView.addConstraints([width, centerX, centerY])
        
        
        
//        titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 5).isActive = true
//        titleLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -8).isActive = true
//        titleLabel.rightAnchor.constraint(equalTo: imageView.leftAnchor).isActive = true
        
     //   titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        //titleLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
      
         titleLabel.bottomAnchor.constraint(equalTo: imageDescription.topAnchor, constant: 10).isActive = true
        
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 5).isActive = true
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.backgroundColor = .blue
        titleLabel.sizeToFit()
        
      /*  imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
       // titleLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -8).isActive = true
        imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 5).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        //   imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5).isActive = true
        imageView.backgroundColor = .red
      */
        imageDescription.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        imageDescription.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        //imageDescription.heightAnchor.constraint(equalToConstant: 36).isActive = true
       // imageDescription.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        imageDescription.rightAnchor.constraint(equalTo: rightAnchor, constant: 5).isActive = true
         imageDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        imageDescription.backgroundColor = .green
      
        imageDescription.numberOfLines = 0
        imageDescription.lineBreakMode = .byWordWrapping
        imageDescription.backgroundColor = .red
        imageDescription.sizeToFit()
        
        
       // contentView.bottomAnchor.constraint(equalTo:imageView.bottomAnchor, constant:10).isActive = true
    }*/
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ self.titleLabel,self.imageView,self.imageDescription])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 2.0
        return stackView
    }()
    func handleConstraints() {
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(verticalStackView)
        
        verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }

    */
  /*  let profileImageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        button.setImage(UIImage(named: "phone"), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.text = "Bob Lee"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "30000 miles"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pricePerHourLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "$40/hour"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "4.9+"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
//    let showCaseImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.backgroundColor = UIColor.white
//        imageView.image = UIImage(named: "Profile")
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    let showCaseImageView: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        button.setImage(UIImage(named: "phone"), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "424 likes ABCD EFGH IJKL MNOP 424 likes ABCD EFGH IJKL MNOP 424 likes ABCD EFGH IJKL MNOP 424 likes ABCD EFGH IJKL MNOP"
        label.numberOfLines = 0
          label.lineBreakMode = .byWordWrapping
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let showCaseImageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.green
        imageView.image = UIImage(named: "phone")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let likesLabel1: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = " Description 424 likes ABCD EFGH IJKL MNOP 424 likes ABCD EFGH IJKL MNOP 424 likes ABCD EFGH IJKL MNOP 424 likes ABCD EFGH IJKL MNOP"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Like", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let hireButton: UIButton = {
        let button = UIButton()
        button.setTitle("Hire", for: .normal)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let messageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Message", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis  = NSLayoutConstraint.Axis.horizontal
        sv.alignment = UIStackView.Alignment.center
        sv.distribution = UIStackView.Distribution.fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false;
        return sv
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
    }
    
    
    
    
    func addViews(){
        backgroundColor = UIColor.black
        
        addSubview(profileImageButton)
        addSubview(nameLabel)
        addSubview(distanceLabel)
        addSubview(pricePerHourLabel)
        addSubview(ratingLabel)
        addSubview(showCaseImageView)
        addSubview(likesLabel1)
         addSubview(showCaseImageView1)
        addSubview(likesLabel)
        
        addSubview(topSeparatorView)
        addSubview(bottomSeparatorView)
        
        // Stack View
        addSubview(likeButton)
        addSubview(messageButton)
        addSubview(hireButton)
        addSubview(stackView)
        
        
        profileImageButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        profileImageButton.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        profileImageButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        profileImageButton.widthAnchor.constraint(equalToConstant: 36).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: profileImageButton.rightAnchor, constant: 5).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: profileImageButton.centerYAnchor, constant: -8).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: pricePerHourLabel.leftAnchor).isActive = true
        
        distanceLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        distanceLabel.centerYAnchor.constraint(equalTo: profileImageButton.centerYAnchor, constant: 8).isActive = true
        distanceLabel.widthAnchor.constraint(equalToConstant: 300)
        
        pricePerHourLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        pricePerHourLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
        
        // Distance depeneded on the priceLabel and distance Label
        ratingLabel.rightAnchor.constraint(equalTo: pricePerHourLabel.rightAnchor).isActive = true
        ratingLabel.centerYAnchor.constraint(equalTo: distanceLabel.centerYAnchor).isActive = true
        
        showCaseImageView.topAnchor.constraint(equalTo: profileImageButton.bottomAnchor, constant: 10).isActive = true
        showCaseImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        showCaseImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
        
        
        
        likesLabel.topAnchor.constraint(equalTo: showCaseImageView.bottomAnchor, constant: 10).isActive = true
        likesLabel.leftAnchor.constraint(equalTo: profileImageButton.leftAnchor).isActive = true
        likesLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        showCaseImageView1.topAnchor.constraint(equalTo: likesLabel.bottomAnchor, constant: 10).isActive = true
        showCaseImageView1.leftAnchor.constraint(equalTo:  profileImageButton.leftAnchor).isActive = true
        showCaseImageView1.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        
        likesLabel1.topAnchor.constraint(equalTo: showCaseImageView1.bottomAnchor, constant: 10).isActive = true
        likesLabel1.leftAnchor.constraint(equalTo: profileImageButton.leftAnchor).isActive = true
        likesLabel1.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        
        topSeparatorView.topAnchor.constraint(equalTo: likesLabel1.bottomAnchor, constant: 10).isActive = true
        topSeparatorView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        topSeparatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        stackView.addArrangedSubview(likeButton)
        stackView.addArrangedSubview(hireButton)
        stackView.addArrangedSubview(messageButton)
        
        stackView.topAnchor.constraint(equalTo: topSeparatorView.bottomAnchor, constant: 4).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        bottomSeparatorView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 4).isActive = true
        bottomSeparatorView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        bottomSeparatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
*/

    let photoTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        //label.text = "424 likes ABCD EFGH IJKL MNOP 424 likes ABCD EFGH IJKL MNOP 424 likes ABCD EFGH IJKL MNOP 424 likes ABCD EFGH IJKL MNOP"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        //label.backgroundColor = .orange
        
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
       // label.text = " Description 424 likes ABCD EFGH IJKL MNOP 424 likes ABCD EFGH IJKL MNOP 424 likes ABCD EFGH IJKL MNOP 424 likes ABCD EFGH IJKL MNOP"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        //label.backgroundColor = .black
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
    
    
    
    
    func addViews(){
        backgroundColor = UIColor.white
        
//        addSubview(profileImageButton)
//        addSubview(nameLabel)
//        addSubview(distanceLabel)
//        addSubview(pricePerHourLabel)
//        addSubview(ratingLabel)
//        addSubview(showCaseImageView)
      
        
        addSubview(photoDescription)
        addSubview(photoImgView)
        addSubview(photoTitle)
        
        addSubview(topSeparatorView)
//        addSubview(bottomSeparatorView)
        
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
        
        /*
        
        topSeparatorView.topAnchor.constraint(equalTo: likesLabel1.bottomAnchor, constant: 10).isActive = true
        topSeparatorView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        topSeparatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        stackView.addArrangedSubview(likeButton)
        stackView.addArrangedSubview(hireButton)
        stackView.addArrangedSubview(messageButton)
        
        stackView.topAnchor.constraint(equalTo: topSeparatorView.bottomAnchor, constant: 4).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        bottomSeparatorView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 4).isActive = true
        bottomSeparatorView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        bottomSeparatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true*/
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
}
