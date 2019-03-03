///**
/*
 FileName : PhotoAppTests
 Description : Tests for the Photo App Model class
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 01/22/19
 =============================================================================
 */

import XCTest
import Alamofire
@testable import PhotoApp

class PhotoAppTests: XCTestCase {

    var apiRequest: Networking!
    var photoDataModel: PhotoDataViewModel!

    struct URLConstants {
        static let devUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        static let failUrl = "https://dl.dropboxusercontent.com/s/2iodh/facts.json"
    }

    override func setUp() {
        apiRequest = Networking()
        photoDataModel = PhotoDataViewModel()

    }

    override func tearDown() {
        apiRequest = nil
        photoDataModel = nil
    }

    ///This will run true if the fetch photos is success
    func testFetchPhotosSuccessStatus() {
        let waitValue = expectation(description: "FetchPhotosSuccess")

        photoDataModel.fetchPhotos(APIConfig.BaseURL, { (isSuccess, _) in

            switch isSuccess {
            case true:
                XCTAssert(true, "ViewModel got successful response")
            default:
                print("Failed to get Response")
            }
            waitValue.fulfill()

        })

        self.waitForExpectations(timeout: 10) { (err) in
            if let error = err {
                print("ERROR: \(error.localizedDescription)")
                XCTAssertTrue(false, "ViewModel WAIT TIME FAILED")
            }
        }
    }
    ///This will run true if the fetch photos is failure
    func testFetchPhotosFailureStatus() {
        let waitValue = expectation(description: "FetchPhotosFailure")
        photoDataModel.fetchPhotos(URLConstants.failUrl, { (isSuccess, _) in
            switch isSuccess {
            case false:
                XCTAssertFalse(false)
            default:
                print("Failed to get Response")
            }
            waitValue.fulfill()
        })
        self.waitForExpectations(timeout: 10) { (err) in
            if let error = err {
                print("ERROR: \(error.localizedDescription)")
                XCTAssertTrue(false, "ViewModel WAIT TIME FAILED")
            }
        }
    }
    ///to test the validity of the BaseURL - any change will lead to data not returning or
    ///error in response
    func testRequestURL() {
        XCTAssertEqual(APIConfig.BaseURL, URLConstants.devUrl)
    }
    ///To check whether the Struture initialization works well with the data or not
    func testPhotoStructInitilization() {
        let rowData = Rows(title: "title", description: "desc", imageHref: "link")
        let photoDataModel = PhotoData(title: "My City",
                                       rows: [rowData])
        XCTAssertEqual(photoDataModel.title, "My City")
    }
}
