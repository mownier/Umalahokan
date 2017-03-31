//
//  RemoteDatabaseTest.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 28/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest
@testable import ServiceProvider

class RemoteDatabaseTest: XCTestCase {
    
    let timeout: TimeInterval = 10
    
    override func setUp() {
        FirebaseHelper.configureApp()
    }
    
    func testInitialization() {
        FirebaseHelper.clearApp()
        var ref = FirebaseHelper.createReference()
        var source = RemoteDatabaseSource(reference: ref)
        var database = RemoteDatabase(source: source)
        XCTAssertNil(database)
        
        FirebaseHelper.configureApp()
        ref = FirebaseHelper.createReference()
        source = RemoteDatabaseSource(reference: ref)
        database = RemoteDatabase(source: source)
        XCTAssertNotNil(database)
    }
    
    func testFetchUsersWithEmptyUserIds() {
        let source = RemoteDatabaseSourceMock()
        let database = RemoteDatabase(source: source)!
        let expectation1 = expectation(description: "Fetch users with empty user ids")
        database.fetchUsers(ids: [String]()) { users in
            XCTAssertTrue(users.isEmpty)
            expectation1.fulfill()
        }
        waitForExpectations(timeout: timeout)
    }
    
    func testFetchUsersWithNonEmptyUserIds() {
        let source = RemoteDatabaseSourceMock()
        let database = RemoteDatabase(source: source)!
        
        let expectation1 = expectation(description: "Fetch users with exsiting, non-empty user id")
        database.fetchUsers(ids: ["me12345"]) { users in
            XCTAssertEqual(users.count, 1)
            if users.count == 1 {
                let user = users[0]
                XCTAssertEqual(user.id, "me12345")
                XCTAssertEqual(user.firstName, "me")
                XCTAssertEqual(user.lastName, "me")
                XCTAssertEqual(user.userName, "meishere")
            }
            expectation1.fulfill()
        }
        
        let expectation2 = expectation(description: "Fetch users with non-existing, non-empty user id")
        database.fetchUsers(ids: ["nonexisting"]) { users in
            XCTAssertEqual(users.count, 0)
            expectation2.fulfill()
        }
        waitForExpectations(timeout: timeout)
    }
    
    func testFetchUsersWithAMixOfNonExisitingAndExistingUserIds() {
        let source = RemoteDatabaseSourceMock()
        let database = RemoteDatabase(source: source)!
        
        let expectation1 = expectation(description: "Fetch users with a mix of non-exisiting and existing user ids")
        database.fetchUsers(ids: ["me12345", "you12345", "non-existing-me", "non-existing-you"]) { users in
            XCTAssertEqual(users.count, 2)
            if users.count == 2 {
                let user1 = users[0]
                XCTAssertEqual(user1.id, "me12345")
                XCTAssertEqual(user1.firstName, "me")
                XCTAssertEqual(user1.lastName, "me")
                XCTAssertEqual(user1.userName, "meishere")
                
                let user2 = users[1]
                XCTAssertEqual(user2.id, "you12345")
                XCTAssertEqual(user2.firstName, "you")
                XCTAssertEqual(user2.lastName, "you")
                XCTAssertEqual(user2.userName, "youishere")
            }
            expectation1.fulfill()
        }
        
        waitForExpectations(timeout: timeout)
    }
}
