//
//  UserExtensionTest.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 01/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest
import Core
@testable import ServiceProvider

class UserExtensionTest: XCTestCase {
    
    func testParseSnapshotDataWithNonNilChildValues() {
        let snapshot = FIRDataSnapshotMock()
        snapshot.childDictionary = ["id": "me12345", "first_name": "me", "last_name": "me", "user_name": "meishere", "email": "me@me.com"]
        
        var userExpected = User()
        var userBefore = User()
        var userAfter = User()
        
        userBefore = userAfter
        userAfter.parse(data: snapshot)
        userExpected.parse(data: snapshot)
        XCTAssertNotEqual(userBefore, userAfter)
        XCTAssertEqual(userAfter, userExpected)
        
        userExpected = User()
        userBefore = User()
        userAfter = User()
        userBefore = userAfter
        userAfter.parse(data: snapshot, exceptions: "id", "first_name")
        userExpected.parse(data: snapshot)
        userExpected.id = ""
        userExpected.firstName = ""
        XCTAssertNotEqual(userBefore, userAfter)
        XCTAssertEqual(userAfter, userExpected)
        
        userExpected = User()
        userBefore = User()
        userAfter = User()
        userBefore = userAfter
        userAfter.parse(data: snapshot, exceptions: "id", "first_name", "last_name", "user_name")
        userExpected.parse(data: snapshot)
        userExpected.id = ""
        userExpected.firstName = ""
        userExpected.lastName = ""
        userExpected.userName = ""
        XCTAssertEqual(userBefore, userAfter)
        XCTAssertEqual(userAfter, userExpected)
    }
    
    func testParseSnapshotDataThatIsNotExisting() {
        let snapshot = FIRDataSnapshotMock()
        snapshot.isExisting = false
        var userExpected = User()
        var userBefore = User()
        var userAfter = User()
        userBefore = userAfter
        userAfter.parse(data: snapshot)
        userExpected.parse(data: snapshot)
        XCTAssertEqual(userBefore, userAfter)
        XCTAssertEqual(userAfter, userExpected)
    }
    
    func testParseSnapshotDataWithNilChildValues() {
        let snapshot = FIRDataSnapshotMock()
        snapshot.childDictionary = ["id": nil, "first_name": nil, "last_name": nil, "me:": nil, "user_name": nil, "email": nil]
        var userExpected = User()
        var userBefore = User()
        var userAfter = User()
        userBefore = userAfter
        userAfter.parse(data: snapshot)
        userExpected.parse(data: snapshot)
        XCTAssertEqual(userBefore, userAfter)
        XCTAssertEqual(userAfter, userExpected)
    }
    
    func testParseSnpahostDataWithMismatchChildValueDataTypes() {
        let snapshot = FIRDataSnapshotMock()
        snapshot.childDictionary = ["id": 1, "first_name": [1:2], "last_name": 1.2, "me:": [1,2], "user_name": ["1": "2"], "email": ["1", "2"]]
        var userExpected = User()
        var userBefore = User()
        var userAfter = User()
        userBefore = userAfter
        userAfter.parse(data: snapshot)
        userExpected.parse(data: snapshot)
        XCTAssertEqual(userBefore, userAfter)
        XCTAssertEqual(userAfter, userExpected)
    }
}
