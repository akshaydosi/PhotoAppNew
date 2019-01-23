///**
/**
 FileName : PhotoData.swift
 Description : Modal data for the Photo Data response
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 01/23/19
 =============================================================================
 */

import Foundation
import SwiftyJSON

struct PhotoData:Codable {
    
    private struct Keys {
        static let mainTitle = "title"
        static let title = "title"
        static let description = "description"
        static let imageRef = "imageHref"
    }
    
}
