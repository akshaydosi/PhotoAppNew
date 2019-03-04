/**
 FileName : Constants.swift
 Description : constants
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 01/23/19
 =============================================================================
 */
import UIKit
import Foundation

typealias ResponseHandler = (AnyObject?, NSError?) -> Void

struct Constants {
    static let apiBaseURL = "API_BASE_URL_ENDPOINT"
    static let reuseIdentifier = "PhotoCell"
    static let pullToRefresh = "Pull to refresh"
    static let placeHolderImage = "placeholderImage"
    static let okButton = "OK"
    static let errorTitle = "Error"
    static let noTitle = "No Title"
    struct DeviceType {
        static let iPhoneType = "iPhone"
    }

    struct CollectionViewPaddings {
        static let top = 10
        static let bottom = 10
        static let left = 10
        static let right = 10
        static let imgPadding: Double = 45.0
        static let insetsPadding: CGFloat = 25.0
        static let marginNInsetsPadding: Int = 25
        static let imgHeight: CGFloat = 120.0

    }

    struct CommonErrorMsgs {
        static let generalMessage = "Some error occured, please try again later."
    }

    struct CellFrames {
        static let height: Double = 1000
        static let width: Double = 355
        static let imgHeight: Double = 145
    }

}
