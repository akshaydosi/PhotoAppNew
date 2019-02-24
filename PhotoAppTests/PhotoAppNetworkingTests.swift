///**
/*
 FileName : PhotoAppNetworkingTests
 Description : Tests for the Networking class
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 01/26/19
 =============================================================================
 */

import XCTest
import Alamofire
@testable import PhotoApp

class PhotoAppNetworkingTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    ///run and test the networking call
    func testNetworkingClass() {
        let waitValue = expectation(description: "NetworkingCall")

        Networking.getJSONData{ (responseDict, error) in
            XCTAssertNotNil(responseDict, "Expected non-nil dict")
            waitValue.fulfill()
        }
        
        self.waitForExpectations(timeout: 10) { (err) in
            if let error = err {
                print("ERROR: \(error.localizedDescription)")
                XCTAssertTrue(false, "Networking wait time failed")
            }
        }
    }
}
