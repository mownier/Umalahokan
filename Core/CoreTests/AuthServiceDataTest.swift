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
        XCTAssertNotNil(data.accessToken, "'accessToken' must NOT be nil")
        XCTAssert(data.accessToken.isEmpty, "'accessToken' MUST be empty")
        XCTAssertNotNil(data.refreshToken, "'refreshToken' must NOT be nil")
        XCTAssert(data.refreshToken.isEmpty, "'refreshToken' MUST be empty")
    }
}
