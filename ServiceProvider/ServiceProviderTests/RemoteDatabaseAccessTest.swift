//
//  RemoteDatabaseAccessTest.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 28/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest
@testable import ServiceProvider
import Firebase

class RemoteDatabaseAccessTest: XCTestCase {
    
    let timeout: TimeInterval = 10
    
    override func setUp() {
        FirebaseHelper.configureApp()
    }
    
    func testInitialization() {
        FirebaseHelper.clearApp()
        var auth = FirebaseHelper.createAuth()
        var access = RemoteDatabaseAccess(firebaseAuth: auth)
        XCTAssertNil(access)
        
        FirebaseHelper.configureApp()
        auth = FirebaseHelper.createAuth()
        access = RemoteDatabaseAccess(firebaseAuth: auth)
        XCTAssertNotNil(access)
    }
    
    func testLoginHasADeniedResult() {
        let auth = FIRAuthMock(context: "Login has a denied result")
        let access = RemoteDatabaseAccess(firebaseAuth: auth)!
        
        let expectation1 = expectation(description: ".denied, .errorCodeUserNotFound")
        access.login(email: "you@you.com", password: "12345qwertzxcvb") { result in
            switch result {
            case .denied:
                break
                
            default:
                XCTFail()
            }
            
            expectation1.fulfill()
        }
        
        waitForExpectations(timeout: timeout)
    }
}
