//
//  RemoteDatabaseSourceTest.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 29/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest
@testable import ServiceProvider

class RemoteDatabaseSourceTest: XCTestCase {
    
    let timeout: TimeInterval = 10
    
    override func setUp() {
        FirebaseHelper.configureApp()
    }
    
    func testInitilization() {
        FirebaseHelper.clearApp()
        var ref = FirebaseHelper.createReference()
        var source = RemoteDatabaseSource(reference: ref)
        XCTAssertNil(source)
        
        FirebaseHelper.configureApp()
        ref = FirebaseHelper.createReference()
        source = RemoteDatabaseSource(reference: ref)
        XCTAssertNotNil(source)
    }
    
    func testGetPathForAllUsersShouldExist() {
        let expectation1 = expectation(description: "Get for allUsers path")
        let ref = FIRDatabaseReferenceMock()
        let source = RemoteDatabaseSource(reference: ref)!
        let path = UsersResource.allUsers.path
        source.get(path) { snapshot in
            XCTAssert(snapshot.exists())
            expectation1.fulfill()
        }
        waitForExpectations(timeout: timeout)
    }
    
    func testGetPathForSingleUserHavingAnExistingId() {
        let expectation1 = expectation(description: "Get for singleUser path")
        let id = "abcde12345qwert"
        let ref = FIRDatabaseReferenceMock()
        let source = RemoteDatabaseSource(reference: ref)!
        let path = UsersResource.singleUser(id).path
        ref.id = id
        source.get(path) { snapshot in
            XCTAssert(snapshot.exists())
            expectation1.fulfill()
        }
        waitForExpectations(timeout: timeout)
    }
    
    func testGetPathForSingleUserHavingNonExistingId() {
        let expectation1 = expectation(description: "Get for singleUser path")
        let id = "ghihk67890zxcvb"
        let ref = FIRDatabaseReferenceMock()
        let source = RemoteDatabaseSource(reference: ref)!
        let path = UsersResource.singleUser(id).path
        ref.id = id
        source.get(path) { snapshot in
            XCTAssertFalse(snapshot.exists())
            expectation1.fulfill()
        }
        waitForExpectations(timeout: timeout)
    }
}
