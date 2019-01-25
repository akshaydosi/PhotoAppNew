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

class PhotoCollectionCollectionViewController: UIViewController {
    var gridLayout: PhotoCollectionViewFlowLayout!
    var refreshControl:UIRefreshControl!
    var model : PhotoData?
    var collectionView: UICollectionView!
    
    let inset: CGFloat = 10
    let minimumLineSpacing: CGFloat = 5
    let minimumInteritemSpacing: CGFloat = 5
    var cellsPerRow = 2
    
    
    //MARK:- VIEW LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        gridLayout = PhotoCollectionViewFlowLayout()
        // Uncomment the following line to preserve selection between presentations
        addControls()

        let model = UIDevice.current.model
        if(model == "iPhone"){
            cellsPerRow = 1
        }
        else{
            cellsPerRow = 3
        }
        getAlbums()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    
    ///MARK:- Orientation Support
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let rect = self.view.frame.size
        let width = rect.width - (ItemSpacing * 2)
        
        let frame =   CGRect(x: ItemSpacing, y: 0, width:width , height: UIScreen.main.bounds.size.height)
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

    

extension PhotoCollectionCollectionViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    
    private func estimateFrameForText(text: String, font : UIFont) -> CGRect {
        //we make the height arbitrarily large so we don't undershoot height in calculation
        let height: Double = 1000
        var marginsAndInsets = 0.0
        if #available(iOS 11.0, *) {
            marginsAndInsets = Double(Int((inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1))))

        }else{
            marginsAndInsets = Double((inset * 2 + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)))
        }
        
        let boundsWidth = Double(collectionView.bounds.size.width)
        let divideValue = Double((CGFloat(cellsPerRow)).rounded(.down))
        let itemWidth = ((boundsWidth - marginsAndInsets) / divideValue)
        let size = CGSize(width: itemWidth, height: height)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: font]
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard  let rowModel = self.model?.rowsData?[indexPath.row] else{
             return CGSize(width: 0, height: 0)
        }
        
        let padding: CGFloat = 0
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
        var marginsAndInsets : CGFloat = 0.0
        if #available(iOS 11.0, *) {
            marginsAndInsets = CGFloat(inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1))
        } else {
            // Fallback on earlier versions
            marginsAndInsets = CGFloat(inset * 2 +  minimumInteritemSpacing * CGFloat(cellsPerRow - 1))
        }
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        return CGSize(width: Double(itemWidth), height: totalHeight)
    }
    
    // MARK:- UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model?.rowsData?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Configure the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        guard let rowModel = self.model?.rowsData?[indexPath.row] else {
            return cell
        }
        
        cell.photoTitle.text = rowModel.titleStr
        
        let urlstr = rowModel.linkStr
        cell.photoImgView.sd_setImage(with: URL(string:  urlstr!), placeholderImage: UIImage(named: "placeholderImage"))
        cell.photoDescription.text = rowModel.descriptionStr
        return cell
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
//            guard let _ = self else {
//                return
//            }
//
            guard  error == nil else{
                return
            }
            if  (photoAPI.errorMessage == ""){
                //print("data received successfully")
                //print("title is \(photoAPI.model.titleStr) \(photoAPI.model.rowsData?.count)")
                self?.model = photoAPI.model
                self?.setControls()
            }else{
                //strongSelf.showAlertView(storeListAPI.errorMessage!)
                //print("error came")
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
        getAlbums()
        //print("Called Pull To Refresh")
        stopRefresher()
    }
    
    func stopRefresher() {
        self.refreshControl.endRefreshing()
    }
    
    func addControls(){
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: gridLayout)
        self.collectionView!.dataSource = self
        self.collectionView!.delegate = self
        self.collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.backgroundColor = UIColor.white
        

        self.view.addSubview(self.collectionView)
    }
}
