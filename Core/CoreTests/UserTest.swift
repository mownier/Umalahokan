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
    
    func testEquality() {
        var user1 = User()
        var user2 = User()
        
        XCTAssertEqual(user1, user2)
        
        user1.firstName = "firstName"
        user2.id = "userId"
        XCTAssertNotEqual(user1, user2)
        
        user1.id = "userId"
        user2.firstName = "firstName"
        XCTAssertEqual(user1, user2)
        
        user1.lastName = "lastName"
        user2.lastName = "last_name"
        XCTAssertNotEqual(user1, user2)
        
        user1.userName = "userName"
        user2.lastName = "lastName"
        user2.userName = "userName"
        XCTAssertEqual(user1, user2)
    }
}
