/**
 FileName : APIManager.swift
 Description :
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 01/23/19
 =============================================================================
 */
import Foundation

import Alamofire

typealias ResponseHandler = (AnyObject?, NSError?) -> Void

class APIManager {
    
    // Class Stored Properties
    static let sharedInstance = APIManager()
    // Avoid initialization
    fileprivate init() {
    }
    
    static let rootKey = "Root";
    
    // MARK : Initialize API Request
    func initiateRequest(_ apiObject: APIBase,
                         apiRequestCompletionHandler:@escaping ResponseHandler) {
        var urlString = apiObject.urlForRequest()
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let request = Alamofire.request(urlString, method: apiObject.requestType(),
                                        parameters: apiObject.requestParameter(),
                                        encoding: ((apiObject.isJSONRequest() == true) ? JSONEncoding.default : URLEncoding.default), headers: apiObject.customHTTPHeaders())
        
        self.requestCompleted(request, apiObject: apiObject,apiRequestCompletionHandler: apiRequestCompletionHandler)
        
    }
    
    
    
    // MARK: Request Completion Logic
    func requestCompleted(_ request: DataRequest?,
                          apiObject: APIBase,
                          apiRequestCompletionHandler:@escaping ResponseHandler) {
        if let request = request {
            
            // Mannual parsing
            request.responseData { [unowned self] response in
                if let data = response.result.value {
                    self.serializeAPIResponse(apiObject, response: data as Data?,
                                              apiRequestCompletionHandler: apiRequestCompletionHandler) {
                        [unowned self, request, apiObject] responseDictionary in
                    }
                } else {
                    if (response.error as NSError?) != nil {
                        if apiObject.shouldThowHttpPopUP == true {
                            
                            let msg = response.error?.localizedDescription ?? "Some error occured. Please try again later."
                            apiObject.showHttpErrorAlert(message: msg )
                        }
                    }
                    apiRequestCompletionHandler(nil,response.error as NSError?)
                }
            }
        } else {
            let error = NSError(domain: apiObject.urlForRequest(), code: 404, userInfo: nil)
            apiRequestCompletionHandler(nil,error)
        }
    }
    
    
    // MARK: Response serializer
    func serializeAPIResponse(_ apiObject: APIBase, response: Data?, apiRequestCompletionHandler:ResponseHandler, serializerCompletionHandler: ((Dictionary<String, AnyObject>) -> Void)?) {
        if let data = response {
            do {
                
                // Check if it is Dictionary
                let datastring = NSString(data: data, encoding: String.Encoding.isoLatin1.rawValue)
                let data = datastring?.data(using:String.Encoding.utf8.rawValue)
                
                if let jsonDictionary = try JSONSerialization.jsonObject(with: data as! Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, AnyObject> {
                    apiObject.parseAPIResponse(response: jsonDictionary)
                    apiRequestCompletionHandler(jsonDictionary as AnyObject?, nil)
                    if let _ = serializerCompletionHandler {
                        serializerCompletionHandler!(jsonDictionary)
                    }
                } else if let jsonArray = try JSONSerialization.jsonObject(with: data as! Data, options:
                    JSONSerialization.ReadingOptions.mutableContainers) as? Array<AnyObject> {
                    // Check if it is Array of Dictionary/String
                    let jsonDictionary = [APIManager.rootKey : jsonArray]
                    apiObject.parseAPIResponse(response: jsonDictionary as Dictionary<String, AnyObject>?)
                    apiRequestCompletionHandler(jsonDictionary as AnyObject?, nil)
                    if let _ = serializerCompletionHandler {
                        serializerCompletionHandler!(jsonDictionary as Dictionary<String, AnyObject>)
                    }
                } else {
                    apiRequestCompletionHandler(nil, nil)
                }
                
            } catch let error as NSError {
                if apiObject.shouldThowHttpPopUP == true {
                    
                    let msg = error.localizedDescription
                    apiObject.showHttpErrorAlert(message: msg )
                }
                apiRequestCompletionHandler(nil, error)
            }
        }
    }
}
