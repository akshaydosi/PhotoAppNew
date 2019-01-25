///**
/**
 FileName : PhotoData.swift
 Description : Modal data for the Photo Data response
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 01/23/19
 =============================================================================
 */

import Foundation

struct PhotoData{
    var titleStr : String?
    var  rowsData : [RowsData]?
}
struct RowsData{
    var titleStr : String?
    var descriptionStr : String?
    var linkStr : String?
}
