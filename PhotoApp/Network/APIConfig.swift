/*
 FileName : APIConfig.swift
 Description : This is a structure that is for the configuration part
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 01/23/19
 =============================================================================
 */

import Foundation

struct APIConfig {
    static var baseURL: String {
        return endPoint
    }
    static var endPoint: String {
            if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
                if let dict = NSDictionary(contentsOfFile: path) {
                    return dict[Constants.apiBaseURL] as? String ?? ""
                }
            }
            return ""
    }
}
