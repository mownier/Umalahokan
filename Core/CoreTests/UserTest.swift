//
//  UserTest.swift
//  Core
//
//  Created by Mounir Ybanez on 23/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest
@testable import Core

class UserTest: XCTestCase {
    
    func testInitialization() {
        let user = User()
        
        XCTAssertNotNil(user.id, "User 'id' must NOT be nil")
        XCTAssertNotNil(user.firstName, "User 'firstName' must NOT be nil")
        XCTAssertNotNil(user.lastName, "User 'lastName' must NOT be nil")
        XCTAssertNotNil(user.userName, "User 'userName' must NOT be nil")
    }
}
