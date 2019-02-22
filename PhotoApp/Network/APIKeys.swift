/*
 FileName : APIKeys.swift
 Description : This is a structure that is for the configuration part, Currently defaults
 to only one environment.
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 01/23/19
 =============================================================================
 */

import Foundation

struct APIConfig {
    struct  Server{///We can change this implementation via Schemes in Application with different
        //environments ready
        static let development = "development"
    }
    
    //Base URL
    static var DevelopmentURL : String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    
    static var BaseURL: String {
        return DevelopmentURL
    }

}


