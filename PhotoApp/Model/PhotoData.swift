///**
/**
 FileName : PhotoData.swift
 Description : Modal data for the Photo Data response
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 01/23/19
 =============================================================================
 */

import Foundation

struct PhotoData: Decodable {
    var title: String?
    var rows: [Rows]?
}

struct Rows: Decodable {
    var title: String?
    var description: String?
    var imageHref: String?
}
