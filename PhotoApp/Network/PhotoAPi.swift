///**
/*
 FileName : PhotoAPi
 Description : 
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 01/22/19
 =============================================================================
 */
import UIKit
import Alamofire

class PhotoAPi: APIBase {
    var model = PhotoData()
    var errormessage: String?
    
    // MARK: URL
    override func urlForRequest() -> String {
        let urlString : String? = APIConfig.BaseURL
        
        return urlString!
    }
    
    override func isJSONRequest() -> Bool {
        return true
    }
    // MARK: HTTP method type
    override func requestType() -> Alamofire.HTTPMethod {
        return Alamofire.HTTPMethod.get
    }
    
    // MARK: API parameters
    override func requestParameter() -> [String : Any]?{
        return nil
    }
    // MARK: Response parser
    override func parseAPIResponse(response: Dictionary<String, AnyObject>?) {
        //print(response)
        
        super.parseAPIResponse(response: response)
        
        var array = [RowsData]()
        guard   (response != nil ) else{
            return;
        }
        let dict = response
        model.titleStr = dict![Constants.mainTitle] as? String ?? ""
        if let rowArray = dict![Constants.rowsKey] as? [[String:Any]]{
            for obj in rowArray{
                var rowModel = RowsData()
                rowModel.titleStr = obj[Constants.title] as? String ?? ""
                rowModel.descriptionStr = obj[Constants.description] as? String ?? ""
                rowModel.linkStr = obj[Constants.imageRef] as? String ?? ""
                array.append(rowModel)
                
            }
            
            let filterData = array.filter {($0.titleStr! != "") ||
                                            ($0.descriptionStr! != "") ||
                                            ($0.linkStr! != "")
            }
            model.rowsData = filterData
        }
    }
}


