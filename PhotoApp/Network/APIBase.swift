//
//  APIBase.swift
//  PhotoApp
//
//  Created by CTS_MacBookPro on 23/01/19.
//  Copyright © 2019 Cognizant. All rights reserved.
//


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
            //errorMessage = NSLocalizedString(Localization.UnKnownError, comment: "")
            //statusCode = APIConstants.ErrorCode.UnknownErrorCode
        }
        
        validateErrorCode()
    }
    func validateErrorCode ()
    {
//        if ((statusCode == APIConstants.ErrorCode.InvalidSession)||(statusCode == APIConstants.ErrorCode.UnauthorizedError)){
//            
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.showAlertForLoginIfRequired(msg: errorMessage)
//        }
    }
    // MARK: Is Multipart Request
    func isMultipartRequest() -> Bool {
        return false
    }
    
    // MARK: MultipartData
    func multipartData(multipartData : MultipartFormData?) {
        
    }
    
    // MARK: Object Mapper Logic
    func enableCacheControl() -> Bool {
        return false
    }
    
    // MARK: Object Mapper Logic
    func cacheKey() -> String? {
        return nil
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
