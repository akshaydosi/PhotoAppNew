/**
 FileName : APIBase.swift
 Description : 
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 01/23/19
 =============================================================================
 */

import Foundation
import Alamofire


class APIBase: NSObject {
    var statusCode : Int? = 0
    var otherErrorMessage : String? = ""
    var errorMessage : String? = ""
    var responseDictionary : Dictionary<String,AnyObject>? = nil
    var responseArray : Array<AnyObject>?
    var responseString : String?
    var shouldThowHttpPopUP : Bool = true
    // MARK: URL
    func urlForRequest() -> String {
        return ""
    }
    
    // MARK: HTTP method type
    func requestType() -> Alamofire.HTTPMethod {
        return Alamofire.HTTPMethod.get
    }
    
    // MARK: API parameters
    func requestParameter() -> [String : Any]?{
        return nil
    }
    
    // MARK: Response parser
    func parseAPIResponse(response: Dictionary<String, AnyObject>?) {
        if response != nil {
        }
        else{
            ///Handle the Parse error
        }
    }
    
    // Add custom headers
    func customHTTPHeaders() -> Alamofire.HTTPHeaders? {
       return nil
    }
    
    // Enable true if it is JSON request (application/json)
    func isJSONRequest() -> Bool {
        return false
    }
    
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
