///**
/*
 FileName : PhotoAPi
 Description : The main entry point for the application
 Copyright : Copyright © 2018 Cognizant. All rights reserved.
 Created Date : 01/22/19
 =============================================================================
 */
import UIKit
import Alamofire

let mainTitle = "title"
let title = "title"
let description = "description"
let imageRef = "imageHref"


class PhotoAPi: APIBase {
    var model = CityModel()
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
        print(response)
        
        super.parseAPIResponse(response: response)
        
        var array = [RowsData]()
        print("error")
        guard   (response != nil ) else{
            return;
        }
        let dict = response
        model.titleStr = dict!["title"] as? String ?? ""
        if let rowArray = dict!["rows"] as? [[String:Any]]{
            for obj in rowArray{
                var rowModel = RowsData()
                rowModel.titleStr = obj["title"] as? String ?? ""
                rowModel.descriptionStr = obj["description"] as? String ?? ""
                rowModel.linkStr = obj["imageHref"] as? String ?? ""
                array.append(rowModel)
                
            }
            model.rowsData = array
        }
    }
    
    
    
}


