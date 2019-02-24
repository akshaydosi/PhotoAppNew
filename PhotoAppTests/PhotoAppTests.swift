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

    var apiRequest:Networking!
    var photoDataModel:PhotoDataViewModel!

    struct URLConstants{
        static let devUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
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
    ///will execute false case in case response/url is incorrect
    func testFetchPhotosStatus(){
        let waitValue = expectation(description: "FetchPhotosSuccess")
        
        photoDataModel.fetchPhotos({ (isSuccess, response) in
            
            switch(isSuccess){
            case true:
                XCTAssert(true, "ViewModel got successful response")
            case false:
                XCTAssertTrue(false, "DATA INPUT OR RESPONSE IS INCORRECT - NOT EXPECTED RESULT")
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
    func testRequestURL(){
        XCTAssertEqual(APIConfig.BaseURL, URLConstants.devUrl)
    }

}
