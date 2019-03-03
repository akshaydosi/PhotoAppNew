/**
 FileName : Networking.swift
 Description : Main class to call the Alamofire request with the URL
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 01/23/19
 =============================================================================
 */

import Foundation
import Alamofire

class Networking: NSObject {

    /// Adds a handler to be called once the request has finished.
    ///
    /// - parameter endPointURL : the URL from where data has to be accessed
    ///             apiRequestCompletionHandler: The code to be executed once the request has finished.
    ///
    /// - returns: The request.

    public static func getJSONData(_ endPointURL: String,
                                   _ apiRequestCompletionHandler:@escaping ResponseHandler) {

        guard let endPointURL = URL(string: endPointURL) else {
            print("Error unwrapping URL "); return }

        ///Create the Alamofire request by passing the Get Request and the URL from where to fetch the same.
        let request = Alamofire.request(endPointURL,
                                        method: Alamofire.HTTPMethod.get,
                                        parameters: nil,
                                        encoding: JSONEncoding.default,
                                        headers: nil)
        ///handle the response from the request
        request.responseData(completionHandler: {(response) in
            switch response.result {
            case .success:
                if let responseData = response.result.value {
                    let dataString = String(data: responseData, encoding: String.Encoding.isoLatin1)
                    guard let modifiedData = dataString?.data(using: String.Encoding.utf8) else {
                        print("could not convert data to UTF-8 format")
                        return
                    }
                    do {///since struct is decodable, we are decoding our json with the model
                        let jsonDecoder = JSONDecoder()
                        var decodedData = PhotoData()
                        decodedData = try jsonDecoder.decode(PhotoData.self, from: modifiedData)
                        apiRequestCompletionHandler(decodedData as AnyObject?, nil)
                    } catch let error as NSError {
                        //Error handling
                        apiRequestCompletionHandler(nil, error)
                    }
                }
            case .failure(let error as NSError):
                apiRequestCompletionHandler(nil, error)
            }
        })
    }
}
