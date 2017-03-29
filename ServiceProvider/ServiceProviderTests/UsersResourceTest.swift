//
//  UsersResourceTest.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 29/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest
@testable import ServiceProvider

class UsersResourceTest: XCTestCase {
    
    func testPathForAllUsersCase() {
        let path = UsersResource.allUsers.path
        XCTAssert(path == "users")
    }
    
    func testPathForSingleUserCase() {
        let id = "123456abcde"
        let path = UsersResource.singleUser(id).path
        XCTAssert(path == "users/\(id)")
    }
}
