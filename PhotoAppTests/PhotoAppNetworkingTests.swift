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

    var apiRequest: Networking!

    struct URLConstants {
        static let devUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg/facts.json"
    }

    override func setUp() {
        apiRequest = Networking()
    }

    override func tearDown() {
        apiRequest = nil
    }

    ///for successful call with correct url
    func testNetworkingCallSuccess() {
        let waitValue = expectation(description: "NetworkingCall")

        apiRequest.initiateRequestFrom(APIConfig.baseURL) {(response) in
            switch response {
            case .success:
                XCTAssertTrue(true)
                if let value = response.value {
                    XCTAssertNotNil(value)
                    XCTAssertTrue(value.title == "About Canada")
                }
            default:
                break
            }
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
        apiRequest.initiateRequestFrom(URLConstants.devUrl) {(response) in
            switch response {
            case .failure(let error as NSError):
                XCTAssertFalse(false, error.localizedDescription)
                if let value = response.value {
                    XCTAssertNil(value)
                }
            default:
                break
            }
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
