//
//  RequestProtocol.swift
//  PhotoApp
//
//  Created by CTS_MacBookPro on 09/03/19.
//  Copyright © 2019 Cognizant. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestProtocol {
    func initiateRequestFrom(_ endPointURL: String,
                             _ apiRequestCompletionHandler:@escaping (Result<PhotoData>) -> Void)
}
