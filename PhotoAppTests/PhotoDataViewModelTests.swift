///**
/*
 FileName : PhotoDataViewModelTests
 Description : Tests for the Photo App Model class
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 01/22/19
 =============================================================================
 */

import XCTest
import Alamofire
@testable import PhotoApp

class PhotoDataViewModelTests: XCTestCase {

    var apiRequest: Networking!
    var photoDataModel: PhotoDataViewModel!

    struct URLConstants {
        static let devUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        static let failUrl = "https://dl.dropboxusercontent.com/s/2iodh/facts.json"
    }

    override func setUp() {
        apiRequest = Networking()
        photoDataModel = PhotoDataViewModel(apiRequester: apiRequest)
    }

    override func tearDown() {
        apiRequest = nil
        photoDataModel = nil
    }

    ///This will run true if the fetch photos is success : actual service call
    func testFetchPhotosSuccessStatus() {
        let waitValue = expectation(description: "FetchPhotosSuccess")
        photoDataModel.fetchPhotos(APIConfig.baseURL, { (isSuccess, _) in
            XCTAssertTrue(isSuccess)
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
            if !isSuccess {
                waitValue.fulfill()
            }
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
        XCTAssertEqual(APIConfig.baseURL, URLConstants.devUrl)
    }
    ///To check whether the Struture initialization works well with the data or not
    func testPhotoStructInitilization() {
        let rowData = Rows(title: "title", description: "desc", imageHref: "link")
        let photoStruct = PhotoData(title: "My City",
                                       rows: [rowData])
        XCTAssertEqual(photoStruct.title, "My City")
        if let title = self.photoDataModel.screenTitle() {
            XCTAssertEqual(title, "About Canada")
        }
    }
    ///to test the number of rows being returned for the particular device
    func testRowsCount() {
        if UIDevice.current.model == Constants.DeviceType.iPhoneType {
            XCTAssertEqual(photoDataModel.getCellPerRow(), 1)
        } else if UIDevice.current.model == Constants.DeviceType.iPad {
                XCTAssertEqual(photoDataModel.getCellPerRow(), 2)
        }
    }
}
