//
//  APIKeys.swift
//  PhotoApp
//
//  Created by CTS_MacBookPro on 23/01/19.
//  Copyright © 2019 Cognizant. All rights reserved.
//

import Foundation
struct APIConfig {
    struct  Server{
        static let Development = "Development"
    }
    
    //Base URL
    static var DevelopmentURL : String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    
    static var BaseURL: String {
     return DevelopmentURL
    }

}


