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

class PhotoDataViewModel: NSObject {
    var model = PhotoData()

    ///fetches the photos from the networking class and gets the filtered data from
    ///the function to be returned to the UI
    func fetchPhotos(_ completion: @escaping (Bool,String?) -> Void){
        Networking.getJSONData{ (responseDict, error) in
            Spinner.hide()
            guard (error == nil) else{
                return completion(false,error?.localizedDescription);
            }
            
            guard let photoDict = responseDict as? NSDictionary else{
                return completion(false,"Unable to Parse Data");
            }
            
            let filterData = self.filterData(photoDict: photoDict)
            
            if let _ = filterData{
                 completion(true,nil);
            }else{
                completion(false,"Unable to Parse Data");
            }
        }
    }
    
    ///returns the title of the Screen
    func screenTitle() -> String? {
        return model.titleStr
    }
    
    //returns the count of the items to be displayed in the collectionview
    func picturesToDisplay(in section: Int) -> Int {
        return model.rowsData?.count ?? 0
    }
    
    
    ///filters the response
    private func filterData(photoDict: NSDictionary)-> PhotoData?{
        var array = [RowsData]()

        model.titleStr = photoDict[Constants.mainTitle] as? String ?? ""
        if let rowArray = photoDict[Constants.rowsKey] as? [[String:Any]]{
            for obj in rowArray{
                var rowModel = RowsData()
                rowModel.titleStr = obj[Constants.title] as? String ?? ""
                rowModel.descriptionStr = obj[Constants.description] as? String ?? ""
                rowModel.linkStr = obj[Constants.imageRef] as? String ?? ""
                array.append(rowModel)
                
            }
            ///Filter the data : remove nil values from dictionaries
            let filterData = array.filter {($0.titleStr! != "") ||
                ($0.descriptionStr! != "") ||
                ($0.linkStr! != "")}
            model.rowsData = filterData
        }
        
        return model
    }
    
}


