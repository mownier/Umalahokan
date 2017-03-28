//
//  AuthServiceDataTest.swift
//  Core
//
//  Created by Mounir Ybanez on 23/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest
@testable import Core

class AuthServiceDataTest: XCTestCase {
    
    func testInitialization() {
        let data = AuthServiceData()
        
        XCTAssertNil(data.user, "'user' MUST be nil")
        XCTAssertNil(data.refreshToken, "'refreshToken' MUST be nil")
        XCTAssertNil(data.accessToken, "'accessToken' MUST be nil")
    }
}
