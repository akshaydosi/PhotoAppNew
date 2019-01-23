//
//  PhotoAPi.swift
//  PhotoApp
//
//  Created by CTS_MacBookPro on 23/01/19.
//  Copyright © 2019 Cognizant. All rights reserved.
//

import UIKit
import Alamofire

 let mainTitle = "title"
 let title = "title"
 let description = "description"
 let imageRef = "imageHref"


class PhotoAPi: APIBase {
    
    
    var errormessage: String?
    
    // MARK: URL
    override func urlForRequest() -> String {
        var urlString : String? = APIConfig.BaseURL
        
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
        
//        responseArray = response?[APIConstants.GeneralApiKey.APIKeyResponseData] as? Array<AnyObject>
//        if  ((errorMessage == "")&&(statusCode == 200)&&(responseArray != nil)&&(response != nil))
//        {
//            if(((responseArray?.count)!>0)&&(listingType == MenuActions.MenuAction_Country_StoreList)){
//                AppManager.sharedInstance.clearValuesOnCountryChange()
//            }
//            else if(((responseArray?.count)!>0)&&(listingType == MenuActions.MenuAction_SalesArea_StoreList)){
//                AppManager.sharedInstance.clearValuesOnSalesAreaChange()
//            }
//            parseStoreData(responseArray!)
//        }
        
    }
    
    
   
}


