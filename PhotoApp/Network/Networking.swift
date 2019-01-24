///**
/**
 FileName : Networking.swift
 Description : Service layer to fetch the data
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 01/23/19
 =============================================================================
 */
import Foundation
import Alamofire
import SwiftyJSON

public class Networking:NSObject{

 /*   //Private
    private struct Keys {
        static let statusCode = "StatusCode"
    }
    
    public struct ServiceKeys {
        static let facts = "facts"
    }
    
    private static let ServerPaths = [
        ServiceKeys.facts: serviceEndpoint(for: "facts"),
    ]
        
    private static let version = "s"
    private static let module = "PhotoApp"
    

    //--------------------------------------------------------------------------
    // MARK:  Request Methods
    //--------------------------------------------------------------------------
    
    public static func performGetRequest(_ key: String, parameters: [String]?, headers: [String: String]? = nil, requireToken: Bool = true, parse: @escaping (JSON) -> Any?, completion: ((Result<Any?>) -> Void)?) {
        performRequest(.get, key: key, parameters: parameters, headers: headers, requireToken: requireToken, postBody: nil, parse: parse, completion: completion)
    }
    
    private static func performRequest(_ method: Alamofire.HTTPMethod, key: String, parameters: [String]?, headers: [String: String]? = nil, requireToken: Bool = true, postBody: Data?, parse: @escaping (JSON) -> Any?, completion: ((Result<Any?>) -> Void)?) {
        
            guard let url = getURLFor(key, parameters: parameters) else {
                completion?(.failure(NSError(domain: module, code: 99, userInfo: nil)))
                return
            }
            print(url)
            
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            #if DEBUG
            request.timeoutInterval = 30
            #endif
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        
            if let httpHeaders = request.allHTTPHeaderFields {
                print("HTTP METHOD:  \(request.httpMethod ?? "NA")")
                print("HEADERS: \n \(httpHeaders)")
            }
            
            Alamofire.request(request)
                .validate()
                .responseJSON { response in
                    // #if DEBUG
                    if let statusCode = response.response?.statusCode {
                        print("STATUS CODE: \(statusCode)")
                    }
                    print("URL: \(request.url?.absoluteString ?? "NA")\n RESPONSE:\n\(response)")
                    // #endif
                    
                    switch response.result {
                        
                    case .success:
                        if let value = response.result.value {
                            let json = JSON(value)
                            let results = parse(json)
                            completion?(.success(results))
                            break
                        }
                        
                    case .failure:
                        if let responseData =  response.data {
                            print("SERVICE RESPONSE:\(String(describing: String(data: responseData, encoding: .utf8)))")
                        }
                    }
            }
    }
}

private extension Networking{
    
    static func hostUrl() -> String {
            guard let urlString = Bundle.main.infoDictionary?[Constants.baseUrl] as? String else {
                fatalError("urlString should not be nil")
            }
            return  String(format: "https://%@", urlString)
    }
    
    static func getURLFor(_ key: String, parameters: [String]?) -> URL? {
        
        guard let urlString = urlWithKey(key, parameters: parameters) else {
            return nil
        }
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        return url
    }
    
    static func urlWithKey(_ key: String, parameters: [String]? = nil) -> String? {
        
        let encodedParamters = parameters?.compactMap{ $0.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) }
        
        guard let parameters = pathAndQueryWithKey(key, parameters: encodedParamters) else {
            return nil
        }
        
        switch key {
        case ServiceKeys.facts:
            fallthrough
        default:
            return hostUrl() + parameters
        }
        
    }
    
    static func pathAndQueryWithKey(_ key: String, parameters: [String]?) -> String? {
        
        var pathAndQuery: String?
        var pathDictonary = ServerPaths
        
        if let baseURLString = pathDictonary[key] {
            if let parameters = parameters {
                
                var tempString = baseURLString
                
                for param in parameters {
                    
                    if tempString.contains("%@") {
                        tempString = tempString.replacingCharacters(in: tempString.range(of: "%@")!, with: param)
                    } else {
                        tempString = String(format: "%@&%@", tempString, param)
                    }
                    
                }
                
                pathAndQuery = tempString
            }
            else {
                pathAndQuery = baseURLString
            }
        }
        
        return pathAndQuery
    }
    
    static func serviceEndpoint(for key: String) -> String {
        return String(format: "/%@/2iodh4vg0eortkl/%@.json", version, key)
    }*/
}
