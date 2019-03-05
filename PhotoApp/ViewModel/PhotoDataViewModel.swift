///**
/*
 FileName : PhotoDataViewModel
 Description : Model calls the webservice and also filters the data
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 01/22/19
 =============================================================================
 */
import UIKit
import Alamofire

private enum CollectionViewCellConstants {
    static let cellPerRowIPhone = 1
    static let cellPerRowIPad = 2
}

class PhotoDataViewModel: NSObject {
    var model = PhotoData()

    ///fetches the photos from the networking class and gets the filtered data from
    ///the function to be returned to the UI
    func fetchPhotos(_ endPointURL: String,
                     _ completion: @escaping (Bool, String?) -> Void) {
        Networking.getJSONData(endPointURL, {(decodedData, error) in
            Spinner.hide()
            guard error == nil else {
                return completion(false, error?.localizedDescription)
            }

            guard let parsedData = decodedData as? PhotoData else {
                return completion(false, Constants.CommonErrorMsgs.generalMessage)
            }
            ///filter the empty dictionaries
            self.filterParsed(data: parsedData)

            if self.model.rows != nil {
                 completion(true, nil)
            } else {
                completion(false, Constants.CommonErrorMsgs.generalMessage)
            }
        })
    }

    ///returns the title of the Screen
    func screenTitle() -> String? {
        return model.title
    }

    //returns the count of the items to be displayed in the collectionview
    func rowCount(in section: Int) -> Int {
        return model.rows?.count ?? 0
    }

    ///for setting the number of items in the row - 1 for iPhone
    ///2 for iPad
    func getCellPerRow() -> (Int) {
        var cellsPerRow = 0
        if UIDevice.current.model == Constants.DeviceType.iPhoneType {
            cellsPerRow = CollectionViewCellConstants.cellPerRowIPhone
        } else {
            cellsPerRow = CollectionViewCellConstants.cellPerRowIPad
        }
        return cellsPerRow
    }

    ///set the main title and the rows (filters the empty dict also)
    private func filterParsed(data: PhotoData) {
        model.title = data.title ?? Constants.noTitle
        ///Filter the data : remove nil values from dictionaries
        if let rowArray = data.rows {
                    let filterData = rowArray.filter {($0.title != nil) ||
                        ($0.description != nil) ||
                        ($0.imageHref != nil)}
                    model.rows = filterData
                } else {
            model.rows = nil///the rowsArray is with correupted data or wrong key was used
        }
    }
}
