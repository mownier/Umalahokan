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
        
        let access1 = RemoteDatabaseAccess(firebaseAuth: auth)!
        let expectation1 = expectation(description: ".denied, .errorCodeUserNotFound")
        access1.login(email: "you@you.com", password: "12345qwertzxcvb") { result in
            switch result {
            case .denied(let error) where error._code == FIRAuthErrorCode.errorCodeUserNotFound.rawValue:
                break
                
            default:
                XCTFail()
            }
            
            expectation1.fulfill()
        }
        
        let access2 = RemoteDatabaseAccess(firebaseAuth: auth)!
        let expectation2 = expectation(description: ".denied, .errorCodeInvalidEmail")
        access2.login(email: "invalid@email.com", password: "12345qwertzxcvb") { result in
            switch result {
            case .denied(let error) where error._code == FIRAuthErrorCode.errorCodeInvalidEmail.rawValue:
                break
                
            default:
                XCTFail()
            }
            
            expectation2.fulfill()
        }
        
        let access3 = RemoteDatabaseAccess(firebaseAuth: auth)!
        let expectation3 = expectation(description: ".denied, .errorCodeWrongPassword")
        access3.login(email: "me@me.com", password: "wrong12345password") { result in
            switch result {
            case .denied(let error) where error._code == FIRAuthErrorCode.errorCodeWrongPassword.rawValue:
                break
                
            default:
                XCTFail()
            }
            
            expectation3.fulfill()
        }
        
        let access4 = RemoteDatabaseAccess(firebaseAuth: auth)!
        let expectation4 = expectation(description: ".denied, .errorCodeWrongPassword, email found but password is incorrect")
        access4.login(email: "me@me.com", password: "123213213") { result in
            switch result {
            case .denied(let error) where error._code == FIRAuthErrorCode.errorCodeWrongPassword.rawValue:
                break
                
            default:
                XCTFail()
            }
            
            expectation4.fulfill()
        }
        
        waitForExpectations(timeout: timeout)
    }
}
