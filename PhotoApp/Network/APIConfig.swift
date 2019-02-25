/*
 FileName : APIConfig.swift
 Description : This is a structure that is for the configuration part, currently defaults
                to only one environment. Used via Schemes as well
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 01/23/19
 =============================================================================
 */

import Foundation

struct APIConfig {
    //Base URL
    static var DevelopmentURL: String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

    static var BaseURL: String {
        return DevelopmentURL
    }
}
