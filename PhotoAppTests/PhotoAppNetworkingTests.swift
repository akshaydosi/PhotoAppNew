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

    struct URLConstants {
        static let devUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg/facts.json"
    }

    ///for successful call with correct url
    func testNetworkingCallSuccess() {
        let waitValue = expectation(description: "NetworkingCall")

        Networking.initiateRequestFrom(APIConfig.baseURL) {(responseDict, _) in
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
    ///for failure call with incorrect end point url
    func testNetworkingCallFailure() {
        let waitValue = expectation(description: "NetworkingCall")
        Networking.initiateRequestFrom(URLConstants.devUrl) {(responseDict, _) in
            XCTAssertNil(responseDict)
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
