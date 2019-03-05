///**
/*
 FileName : PhotoCollectionViewController
 Description : The main controller for the Collection View Images and data
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 01/23/19
 =============================================================================
 */

import UIKit

enum CollectionViewConstants {
    static let itemSpacing: CGFloat = 10.0
    static let spacingValue: CGFloat = 2.0
}

class PhotoCollectionViewController: UIViewController {
    private var refreshControl = UIRefreshControl()
    private var dataSource: PhotoCollectionViewDataSource!
    private var viewModel = PhotoDataViewModel()
    lazy private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let tempCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return tempCollectionView
    }()

    // MARK: - VIEW LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        configureControls()
        getPhotoAlbums()
    }

    ///MARK:- Orientation Support
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let rect = self.view.frame.size
        let width = rect.width - (CollectionViewConstants.itemSpacing * CollectionViewConstants.spacingValue)
        let frame =   CGRect(x: CollectionViewConstants.itemSpacing, y: 0,
                             width: width,
                             height: UIScreen.main.bounds.size.height)
        collectionView.frame = frame
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
}

// MARK: - General Methods
extension PhotoCollectionViewController {

    ///adds the main controls as subviews
    func configureControls() {
        self.view.backgroundColor = .white
        //let layout = UICollectionViewFlowLayout()

        //collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotoCollectionViewCell.self,
                                     forCellWithReuseIdentifier: Constants.reuseIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        view.addSubview(self.collectionView)

        refreshControl.tintColor = .black
        refreshControl.attributedTitle = NSAttributedString(string: Constants.pullToRefresh)
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        collectionView.addSubview(self.refreshControl)
    }

    ///Called when "Refresh Control" is called
    @objc func refresh(sender: AnyObject) {
        getPhotoAlbums()
        stopRefresher()
    }

    //Stop on successful return from function call
    func stopRefresher() {
        refreshControl.endRefreshing()
    }

    /// Gets the data via the View Model which inturn requests from the network layer .
    ///
    /// - parameter nil:
    ///
    /// - Handles the status and accordingly shows the error message if any
    func getPhotoAlbums() {
        Spinner.show()
        viewModel.fetchPhotos (APIConfig.BaseURL, { [weak self] (status, errorMsg) in
            switch status {
            case true:
                self?.dataSource = PhotoCollectionViewDataSource(viewModel: self?.viewModel ?? PhotoDataViewModel())
                self?.collectionView.dataSource = self?.dataSource
                self?.collectionView.delegate = self?.dataSource
                self?.title = self?.viewModel.screenTitle()///Dynamic Title
                self?.collectionView.reloadData()
            case false:
                self?.showHttpErrorAlert(message: errorMsg ?? Constants.CommonErrorMsgs.generalMessage)
            }
        })
    }

    ///Shows the alert in case of any error being returned from the service or response
    func showHttpErrorAlert(message: String) {
        let action = UIAlertAction(title: Constants.okButton,
                                   style: UIAlertAction.Style.default,
                                   handler: nil)
        let alertController = UIAlertController(title: Constants.errorTitle,
                                                message: message,
                                                preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
