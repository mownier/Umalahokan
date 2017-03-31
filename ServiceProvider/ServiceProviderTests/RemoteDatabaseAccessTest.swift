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
        let expectation1 = expectation(description: ".denied, .credentialNotFound, .errorCodeUserNotFound")
        access1.login(email: "you@you.com", password: "12345qwertzxcvb") { result in
            switch result {
            case .denied(let error):
                switch error {
                case .credentialNotFound:
                    XCTAssertTrue(error.detailedError?._code == FIRAuthErrorCode.errorCodeUserNotFound.rawValue)
                
                default:
                    XCTFail()
                }
                
            default:
                XCTFail()
            }
            
            expectation1.fulfill()
        }
        
        let access2 = RemoteDatabaseAccess(firebaseAuth: auth)!
        let expectation2 = expectation(description: ".denied, .credentialNotFound, .errorCodeInvalidEmail")
        access2.login(email: "invalid@email.com", password: "12345qwertzxcvb") { result in
            switch result {
            case .denied(let error):
                switch error {
                case .credentialNotFound:
                    XCTAssertTrue(error.detailedError?._code == FIRAuthErrorCode.errorCodeInvalidEmail.rawValue)
                    
                default:
                    XCTFail()
                }

                
            default:
                XCTFail()
            }
            
            expectation2.fulfill()
        }
        
        let access3 = RemoteDatabaseAccess(firebaseAuth: auth)!
        let expectation3 = expectation(description: ".denied, .invalidCredential .errorCodeWrongPassword")
        access3.login(email: "me@me.com", password: "wrong12345password") { result in
            switch result {
            case .denied(let error):
                switch error {
                case .invalidCredential:
                    XCTAssertTrue(error.detailedError?._code == FIRAuthErrorCode.errorCodeWrongPassword.rawValue)
                    
                default:
                    XCTFail()
                }
                
            default:
                XCTFail()
            }
            
            expectation3.fulfill()
        }
        
        let access4 = RemoteDatabaseAccess(firebaseAuth: auth)!
        let expectation4 = expectation(description: ".denied, .invalidCredential, .errorCodeWrongPassword, email found but password is incorrect")
        access4.login(email: "me@me.com", password: "123213213") { result in
            switch result {
            case .denied(let error):
                switch error {
                case .invalidCredential:
                    XCTAssertTrue(error.detailedError?._code == FIRAuthErrorCode.errorCodeWrongPassword.rawValue)
                    
                default:
                    XCTFail()
                }
                
            default:
                XCTFail()
            }
            
            expectation4.fulfill()
        }
        
        waitForExpectations(timeout: timeout)
    }
    
    func testLoginHasAnAcceptedResult() {
        let context = "Login has an accepted result"
        let auth = FIRAuthMock(context: context)
        let access = RemoteDatabaseAccess(firebaseAuth: auth)!
        let expectation1 = expectation(description: context)
        access.login(email: "me@me.com", password: "abcde12345qwert") { result in
            switch result {
            case .accepted(let data):
                XCTAssertNotNil(data.accessToken)
                XCTAssertFalse(data.accessToken!.isEmpty)
                XCTAssertNotNil(data.userId)
                XCTAssertFalse(data.userId!.isEmpty)
                
            default:
                XCTFail()
            }
            expectation1.fulfill()
        }
        waitForExpectations(timeout: timeout)
    }
    
    func testGetAccessTokenWithDeniedResult() {
        let context = "Get access token with .denied result"
        let auth = FIRAuthMock(context: context)
        
        let access1 = RemoteDatabaseAccess(firebaseAuth: auth)!
        let expectation1 = expectation(description: ".denied, .unauthorized, FIRUser is nil")
        access1.getAccessToken(user: nil) { result in
            switch result {
            case .denied(let error):
                switch error {
                case .unauthorized:
                    break
                
                default:
                    XCTFail()
                }
            default:
                XCTFail()
            }
            expectation1.fulfill()
        }
        
        let user2 = FIRUserMock(context: context)
        let access2 = RemoteDatabaseAccess(firebaseAuth: auth)!
        let expectation2 = expectation(description: ".denied, .tokenUnavailable, FIRUser is not nil")
        user2.hasError = true
        access2.getAccessToken(user: user2) { result in
            switch result {
            case .denied(let error):
                switch error {
                case .tokenUnavailable:
                    break
                    
                default:
                    XCTFail()
                }
                
            default:
                XCTFail()
            }
            expectation2.fulfill()
        }
        
        let user3 = FIRUserMock(context: context)
        let access3 = RemoteDatabaseAccess(firebaseAuth: auth)!
        let expectation3 = expectation(description: ".denied, .tokenUnavailable, FIRUser is not nil but access token is nil")
        access3.getAccessToken(user: user3) { result in
            switch result {
            case .denied(let error):
                switch error {
                case .tokenUnavailable:
                    break
                    
                default:
                    XCTFail()
                }
                
            default:
                XCTFail()
            }
            expectation3.fulfill()
        }
        
        let user4 = FIRUserMock(context: context)
        let access4 = RemoteDatabaseAccess(firebaseAuth: auth)!
        let expectation4 = expectation(description: ".denied, .unauthorized, FIRUser is not nil, access token is not nil, but empty uid")
        user4.accessToken = "accessToken"
        user4.expectedId = ""
        access4.getAccessToken(user: user4) { result in
            switch result {
            case .denied(let error):
                switch error {
                case .unauthorized:
                    break
                    
                default:
                    XCTFail()
                }
                
            default:
                XCTFail()
            }
            expectation4.fulfill()
        }
        
        waitForExpectations(timeout: timeout)
    }
    
    func testGetAccessTokenWithAcceptedResult() {
        let context = "Get access token with .accepted result"
        let auth = FIRAuthMock(context: context)
        let access = RemoteDatabaseAccess(firebaseAuth: auth)!
        let expectation1 = expectation(description: context)
        let user = FIRUserMock(context: context)
        user.hasError = false
        user.accessToken = "accessToken"
        user.expectedId = "userid"
        access.getAccessToken(user: user) { result in
            switch result {
            case .accepted(let data):
                XCTAssertNotNil(data.accessToken)
                XCTAssertFalse(data.accessToken!.isEmpty)
                XCTAssertNotNil(data.userId)
                XCTAssertFalse(data.userId!.isEmpty)
                
            default:
                XCTFail()
            }
            expectation1.fulfill()
        }
        waitForExpectations(timeout: timeout)
    }
}
