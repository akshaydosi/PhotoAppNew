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
    static let ItemSpacing: CGFloat = 10.0
}

class PhotoCollectionViewController: UIViewController {
    private var refreshControl: UIRefreshControl!
    private var dataSource: PhotoCVDataSourceNDelegate!

    private var viewModel = PhotoDataViewModel()
    private var collectionView: UICollectionView!

    // MARK: - VIEW LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        configureControls()
        getPhotoAlbums()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    ///MARK:- Orientation Support
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let rect = self.view.frame.size
        let width = rect.width - (CollectionViewConstants.ItemSpacing * 2)

        let frame =   CGRect(x: CollectionViewConstants.ItemSpacing,
                             y: 0,
                             width: width,
                             height: UIScreen.main.bounds.size.height)
        self.collectionView.frame = frame
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
        let layout = UICollectionViewFlowLayout()

        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView.register(PhotoCollectionViewCell.self,
                                     forCellWithReuseIdentifier: Constants.reuseIdentifier)
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView)

        self.refreshControl = UIRefreshControl()
        self.refreshControl.tintColor = UIColor.red
        self.refreshControl.attributedTitle = NSAttributedString(string: Constants.pullToRefresh)
        self.refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        self.collectionView!.addSubview(self.refreshControl)
    }

    ///Called when "Refresh Control" is called
    @objc func refresh(sender: AnyObject) {
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
    func getPhotoAlbums() {
        Spinner.show()
        viewModel.fetchPhotos (APIConfig.BaseURL, { [weak self] (status, errorMsg) in
            switch status {
            case true:
                self?.dataSource = PhotoCVDataSourceNDelegate(viewModel: self?.viewModel ?? PhotoDataViewModel())
                self?.collectionView.dataSource = self?.dataSource
                self?.collectionView.delegate = self?.dataSource
                self?.setControls()
            case false:
                self?.showHttpErrorAlert(message: errorMsg ?? Constants.CommonErrorMsgs.generalMessage)
            }
        })
    }
    ///for reloading and setting the title on returing of the data from service
    func setControls() {
        self.title = viewModel.screenTitle()///Dynamic Title
        self.collectionView.reloadData()
    }
    ///Shows the alert in case of any error being returned from the service or response
    func showHttpErrorAlert(message: String) {
        let activeVc = UIApplication.shared.keyWindow?.rootViewController
        let action = UIAlertAction(title: Constants.okButton,
                                   style: UIAlertAction.Style.default,
                                   handler: nil)
        let alertController = UIAlertController(title: Constants.errorTitle,
                                                message: message,
                                                preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(action)
        activeVc?.present(alertController, animated: true, completion: nil)
    }
}
