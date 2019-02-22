///**
/*
 FileName : PhotoCollectionViewController
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
let cellPerRowIPhone = 1
let cellPerRowIPad = 3

class PhotoCollectionViewController: UIViewController {
    var gridLayout: PhotoCollectionViewFlowLayout!
    var refreshControl:UIRefreshControl!
    fileprivate var dataSource: PhotoCollectionDataSource!

    var viewModel = PhotoDataViewModel()
    var collectionView: UICollectionView!
    
    let inset: CGFloat = 10
    let minimumLineSpacing: CGFloat = 0
    let minimumInteritemSpacing: CGFloat = 0
    var cellsPerRow = 0
    
    
    //MARK:- VIEW LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Spinner.show()
        
        self.view.backgroundColor = .white
        gridLayout = PhotoCollectionViewFlowLayout()
        addControls()
        initializeValues()
        getPhotoAlbums()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    ///MARK:- Orientation Support
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let rect = self.view.frame.size
        let width = rect.width - (ItemSpacing * 2)
        
        let frame =   CGRect(x: ItemSpacing, y: 0, width:width , height: UIScreen.main.bounds.size.height)
        self.collectionView.frame = frame
        self.gridLayout.prepare()
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

    
//MARK:- COLLECTION VIEW
extension PhotoCollectionViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    
    private func estimateFrameForText(text: String, font : UIFont) -> CGRect {
        //we make the height arbitrarily large so we don't undershoot height in calculation
        let height: Double = 1000
        var marginsAndInsets = 0.0
        if #available(iOS 11.0, *) {
            marginsAndInsets = Double(Int((inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right +  25 + minimumInteritemSpacing * CGFloat(cellsPerRow - 1))))
            
        }else{
            marginsAndInsets = Double((inset * 2 + 25 + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)))
        }
        
        let boundsWidth = Double(collectionView.bounds.size.width )
        let divideValue = Double((CGFloat(cellsPerRow)).rounded(.down))
        let itemWidth = ((boundsWidth - marginsAndInsets) / divideValue)
        let size = CGSize(width: itemWidth - 120, height: height)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: font]
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard  let rowModel = viewModel.model.rowsData?[indexPath.row] else{
            return CGSize(width: 0, height: 0)
        }
        
        let padding: CGFloat = 0
        var titleHeight = 2.0
        var detailHeight = 2.0
        //estimate each cell's height
        if let titleText = rowModel.titleStr {
            titleHeight = Double(estimateFrameForText(text: titleText,
                                                      font: UIFont.boldSystemFont(ofSize:18)).height + padding)
        }
        if let detailText = rowModel.descriptionStr {
            detailHeight = Double(estimateFrameForText(text: detailText,
                                                       font: UIFont.systemFont(ofSize: 14)).height + padding)
        }
        var totalHeight = titleHeight + detailHeight  + 40 + 5
        if (totalHeight < 145)
        {
            //Take atleast image height
            totalHeight = 145
        }
        var marginsAndInsets : CGFloat = 0.0
        
        if #available(iOS 11.0, *) {
            marginsAndInsets = CGFloat(inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + 25 + minimumInteritemSpacing * CGFloat(cellsPerRow - 1))
        } else {
            // Fallback on earlier versions
            marginsAndInsets = CGFloat(inset * 2 +  minimumInteritemSpacing * CGFloat(cellsPerRow - 1) + 25)
        }
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        
        return CGSize(width: Double(itemWidth), height: totalHeight )
        
    }
    
}

//MARK:- General Methods
extension PhotoCollectionViewController{
    
    func initializeValues(){
        let model = UIDevice.current.model
        if(model == Constants.DeviceType.iPhoneType){
            cellsPerRow = cellPerRowIPhone
        }
        else{
            cellsPerRow = cellPerRowIPad
        }
    }
    
    func setControls(){
        self.title = viewModel.screenTitle()///Dynamic Title
        self.collectionView.reloadData()
    }
    
    ///adds the main controls as subviews
    func addControls(){
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: gridLayout)
        self.collectionView!.dataSource = dataSource
        self.collectionView!.delegate = self
        self.collectionView.register(PhotoCollectionViewCell.self,
                                     forCellWithReuseIdentifier: Constants.reuseIdentifier)
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.backgroundColor = UIColor.white
        
        self.view.addSubview(self.collectionView)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.tintColor = UIColor.red
        self.refreshControl.attributedTitle = NSAttributedString(string: Constants.pullToRefresh)
        self.refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        collectionView!.addSubview(refreshControl)
    }
    
    ///Called when "Refresh Control" is called
    @objc func refresh(sender:AnyObject){
        //DO
        getPhotoAlbums()
        stopRefresher()
    }
    
    //Stop on successful return from function call
    func stopRefresher() {
        self.refreshControl.endRefreshing()
    }
    
    /// Gets the data via the View Model which inturn requests from the network layer .
    ///
    /// - parameter nil:
    ///
    /// - Handles the status and accordingly shows the error message if any
    func getPhotoAlbums(){
        viewModel.fetchPhotos(){ [weak self] (status,errorMsg) in
            switch(status){
            case true:
                self?.dataSource = PhotoCollectionDataSource(viewModel: self?.viewModel ?? PhotoDataViewModel())
                self?.collectionView.dataSource = self?.dataSource
                //self?.collectionView.reloadData()
                self?.setControls()
            case false:
                self?.showHttpErrorAlert(message: errorMsg ?? Constants.CommonErrorMsgs.generalMessage)
            }
        }
    }
    
    ///Show the alert in case of any error being returned from the service or response
    func showHttpErrorAlert(message : String) {
        let activeVc = UIApplication.shared.keyWindow?.rootViewController
        let action = UIAlertAction(title: NSLocalizedString("OK",comment: ""), style: UIAlertAction.Style.default, handler: nil)
        let alertController = UIAlertController(title: NSLocalizedString("",comment: ""),
                                                message: message,
                                                preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(action)
        activeVc?.present(alertController, animated: true, completion: nil)
    }
}

