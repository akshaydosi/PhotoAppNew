///**
/*
 FileName : PhotoCollectionCollectionViewController
 Description : The main controller for the Collection View Images and data
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 01/23/19
 =============================================================================
 */

import UIKit
import SDWebImage
import AlamofireImage
import Alamofire
let ItemSpacing : CGFloat = 10.0
private let reuseIdentifier = "Cell"

class PhotoCollectionCollectionViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    var gridLayout: PhotoCollectionViewFlowLayout!
    var refreshControl:UIRefreshControl!
    var model : PhotoData?
    var collectionView: UICollectionView!
    //MARK:- VIEW LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        gridLayout = PhotoCollectionViewFlowLayout()
        // Uncomment the following line to preserve selection between presentations
        addControls()
       // self.collectionView.collectionViewLayout = gridLayout
        // Register cell classes
        //self.collectionView!.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        //self.collectionView!.dataSource = self
        //self.collectionView!.delegate = self
        // Do any additional setup after loading the view.
       // collectionView.backgroundColor = .clear
        //self.title = "Photos"
        
//        self.refreshControl = UIRefreshControl()
//        //self.collectionView!.alwaysBounceVertical = true
//        self.refreshControl.tintColor = UIColor.red
//        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
//        self.refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
//        collectionView!.addSubview(refreshControl)
//        self.view.backgroundColor = .white
        getAlbums()
    }
    
    func addControls(){
        // Create an instance of UICollectionViewFlowLayout since you cant
        // Initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.itemSize = CGSize(width: view.frame.width, height: 700)
        let rect = self.view.frame.size
        let width = rect.width - (ItemSpacing * 2)
        
        let frame =   CGRect(x: ItemSpacing, y: 60, width:width , height: UIScreen.main.bounds.size.height-60)
        self.collectionView = UICollectionView(frame: frame, collectionViewLayout: gridLayout)
        self.collectionView!.dataSource = self
        self.collectionView!.delegate = self
        self.collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK:- UICollectionViewDataSource
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.model?.rowsData?.count ?? 1
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // Configure the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        guard let rowModel = self.model?.rowsData?[indexPath.row] else {
            return cell
        }
        
        cell.likesLabel.text = rowModel.titleStr
//

        let urlstr = rowModel.linkStr
        cell.showCaseImageView1.sd_setImage(with: URL(string:  urlstr!), placeholderImage: UIImage(named: "phone.png"))
        cell.likesLabel1.text = rowModel.descriptionStr
        print("title is \(rowModel.titleStr)")
//        cell.likesLabel.text = "ABCD"
        
//        let urlstr = rowModel!.linkStr
//        cell.showCaseImageView1.sd_setImage(with: URL(string:  urlstr!), placeholderImage: UIImage(named: "phone.png"))
//        cell.likesLabel1.text = rowModel!.descriptionStr
        cell.backgroundColor = .red

//cell.layoutIfNeeded()
        return cell
        
    }
    private func estimateFrameForText(text: String, font : UIFont) -> CGRect {
        //we make the height arbitrarily large so we don't undershoot height in calculation
        let height: CGFloat = 1000
        
        let size = CGSize(width: self.view.frame.size.width - 20 , height: height)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: font]
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 1000
        guard  let rowModel = self.model?.rowsData?[indexPath.row] else{
             return CGSize(width: 0, height: 0)
        }
        
        //we are just measuring height so we add a padding constant to give the label some room to breathe!
        var padding: CGFloat = 0
        var titleHeight = 2.0
        var detailHeight = 2.0
        //estimate each cell's height
        if let titleText = rowModel.titleStr {
            titleHeight = Double(estimateFrameForText(text: titleText, font: UIFont.boldSystemFont(ofSize:18)).height + padding)
        }
        if let detailText = rowModel.descriptionStr {
            detailHeight = Double(estimateFrameForText(text: detailText, font: UIFont.systemFont(ofSize: 14)).height + padding)
        }
        
        
        let totalHeight = titleHeight + detailHeight + 120 + 40 
        print("totalHeight of indexpath \(totalHeight) \(indexPath.row)")
        let w = self.collectionView.frame.size.width
        return CGSize(width: Double(w), height: totalHeight)
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
//    ///MARK:- TO Support Orientation
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        gridLayout.estimatedItemSize = CGSize(width: view.bounds.size.width, height: 10)
//        super.traitCollectionDidChange(previousTraitCollection)
//    }
//
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        gridLayout.estimatedItemSize = CGSize(width: view.bounds.size.width, height: 10)
//        gridLayout.invalidateLayout()
//        super.viewWillTransition(to: size, with: coordinator)
//    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let rect = self.view.frame.size
        let width = rect.width - (ItemSpacing * 2)
        
         let frame =   CGRect(x: ItemSpacing, y: 60, width:width , height: UIScreen.main.bounds.size.height-60)
        self.collectionView.frame = frame
        self.gridLayout.invalidateLayout()
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }

}

//MARK:- METHODS
extension PhotoCollectionCollectionViewController{
    func getAlbums() {
           Spinner.show()
        //  showBusyView(localizedString(Localization.LoaderText), shouldShowOnWindow: true)
        
        let photoAPI = PhotoAPi()
        APIManager.sharedInstance.initiateRequest(photoAPI) { [weak self] (response, error) in
            Spinner.hide()
            guard let _ = self else {
                return
            }
            
            guard  error == nil else{
                return
            }
            
            //            if  ((photoAPI.errorMessage == "")&&(photoAPI.statusCode == 200))
            if  (photoAPI.errorMessage == "")
            {
                print("data received successfully")
                print("title is \(photoAPI.model.titleStr) \(photoAPI.model.rowsData?.count)")
                self?.model = photoAPI.model
                self?.setControls()
            }
            else{
                //strongSelf.showAlertView(storeListAPI.errorMessage!)
                print("error came")
                
            }
            
            
            
        }
    }
    
    func setControls(){
        self.title = self.model?.titleStr///Dynamic Title
        self.collectionView.reloadData()
      
    }
    
    @objc func refresh(sender:AnyObject)
    {
        //DO
        print("Called Pull To Refresh")
        stopRefresher()
    }
    
    func stopRefresher() {
        self.refreshControl.endRefreshing()
    }
}
