//
//  AuthRemoteServiceTest.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 23/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest
import Core
@testable import ServiceProvider

class AuthRemoteServiceTest: XCTestCase {
    
    let timeout: TimeInterval = 10
    
    override func setUp() {
        FirebaseHelper.configureApp()
    }
    
    func testInitialization() {
        FirebaseHelper.clearApp()
        var service = AuthRemoteService()
        XCTAssertNil(service, "CONTEXT: FIRApp is not yet configured,\nMESSAGE: 'service' MUST be nil")
        
        FirebaseHelper.configureApp()
        service = AuthRemoteService()
        XCTAssertNotNil(service, "CONTEXT: FIRApp is already configured,\nMESSAGE: 'service' must NOT be nil")
        
        let auth = FirebaseHelper.createAuth()
        service = AuthRemoteService(auth: auth)
        if auth == nil {
            XCTAssertNil(service, "CONTEXT: 'auth' is nil,\nMESSAGE: 'service' MUST be nil")
        
        } else {
            XCTAssertNotNil(service, "CONTEXT: 'auth' is NOT nil,\nMESSAGE: 'service' must NOT be nil")
        }
    }
    
    func testLoginHasErrorResultWithWrongPassword() {
        let auth = FIRAuthMock(context: nil)
        auth.expectedError = .errorCodeWrongPassword
        let service = AuthRemoteService(auth: auth)!
        
        let expectation1 = expectation(description: "Empty email and password")
        service.login(email: "", password: "") { result in
            switch result {
            case .fail(let info):
                switch info {
                case .wrongPassword : break
                default : XCTFail("Error 'info' is not of type '.wrongPassword'")
                }
                
            default:
                XCTFail("'result' is not of type '.fail'")
            }
            expectation1.fulfill()
        }
        
        let expectation2 = expectation(description: "Existing email and empty password")
        service.login(email: "me@me.com", password: "") { result in
            switch result {
            case .fail(let info):
                switch info {
                case .wrongPassword : break
                default : XCTFail("Error 'info' is not of type '.wrongPassword'")
                }
                
            default:
                XCTFail("'result' is not of type '.fail'")
            }
            expectation2.fulfill()
        }
        
        let expectation3 = expectation(description: "Existing email and mismatched password")
        service.login(email: "me@me.com", password: "kkJDKFj213898pr") { result in
            switch result {
            case .fail(let info):
                switch info {
                case .wrongPassword : break
                default : XCTFail("Error 'info' is not of type '.wrongPassword'")
                }
                
            default:
                XCTFail("'result' is not of type '.fail'")
            }
            expectation3.fulfill()
        }
        
        waitForExpectations(timeout: timeout)
    }
    
    func testLoginHasErroResultWithInvalidEmailFormat() {
        let auth = FIRAuthMock(context: nil)
        auth.expectedError = .errorCodeInvalidEmail
        let service = AuthRemoteService(auth: auth)!
        
        let expectation1 = expectation(description: "Invalid email format having no @ and non-empty password")
        service.login(email: "afdsafsafdsf", password: "kkJDKFj213898pr") { result in
            switch result {
            case .fail(let info):
                switch info {
                case .invalidEmail : break
                default : XCTFail("Error 'info' is not of type '.invalidEmail'")
                }
                
            default:
                XCTFail("'result' is not of type '.fail'")
            }
            expectation1.fulfill()
        }
        
        let expectation2 = expectation(description: "Invalid email format having @ at the end")
        service.login(email: "123adkl213@", password: "kkJDKFj213898pr") { result in
            switch result {
            case .fail(let info):
                switch info {
                case .invalidEmail : break
                default : XCTFail("Error 'info' is not of type '.invalidEmail'")
                }
                
            default:
                XCTFail("'result' is not of type '.fail'")
            }
            expectation2.fulfill()
        }
        
        let expectation3 = expectation(description: "Invalid email format having @ at the beginning")
        service.login(email: "@123jkjsdf", password: "kkJDKFj213898pr") { result in
            switch result {
            case .fail(let info):
                switch info {
                case .invalidEmail : break
                default : XCTFail("Error 'info' is not of type '.invalidEmail'")
                }
                
            default:
                XCTFail("'result' is not of type '.fail'")
            }
            expectation3.fulfill()
        }
        
        let expectation4 = expectation(description: "Invalid email format having @ at the end and beginning")
        service.login(email: "@123jkjsdf@", password: "kkJDKFj213898pr") { result in
            switch result {
            case .fail(let info):
                switch info {
                case .invalidEmail : break
                default : XCTFail("Error 'info' is not of type '.invalidEmail'")
                }
                
            default:
                XCTFail("'result' is not of type '.fail'")
            }
            expectation4.fulfill()
        }
        
        let expectation5 = expectation(description: "Invalid email format with all @")
        service.login(email: "@@@@@@", password: "kkJDKFj213898pr") { result in
            switch result {
            case .fail(let info):
                switch info {
                case .invalidEmail : break
                default : XCTFail("Error 'info' is not of type '.invalidEmail'")
                }
                
            default:
                XCTFail("'result' is not of type '.fail'")
            }
            expectation5.fulfill()
        }
        
        let expectation6 = expectation(description: "Invalid email format with two @ in between")
        service.login(email: "asdfadsf@kjksadjf@jdskf", password: "kkJDKFj213898pr") { result in
            switch result {
            case .fail(let info):
                switch info {
                case .invalidEmail : break
                default : XCTFail("Error 'info' is not of type '.invalidEmail'")
                }
                
            default:
                XCTFail("'result' is not of type '.fail'")
            }
            expectation6.fulfill()
        }
        
        waitForExpectations(timeout: timeout)
    }
    
    func testLoginHasErrorResultWithEmailNotFound() {
        let auth = FIRAuthMock(context: nil)
        auth.expectedError = .errorCodeUserNotFound
        let service = AuthRemoteService(auth: auth)!
        
        let expectation1 = expectation(description: "Valid email but non-existing and non-empty password")
        service.login(email: "kasjdkf@kjsdkfjk", password: "kkJDKFj213898pr") { result in
            switch result {
            case .fail(let info):
                switch info {
                case .userNotFound : break
                default : XCTFail("Error 'info' is not of type '.emailNotFound'")
                }
                
            default:
                XCTFail("'result' is not of type '.fail'")
            }
            expectation1.fulfill()
        }
        
        waitForExpectations(timeout: timeout)
    }
    
    func testLoginHasSuccessfulResult() {
        let auth = FIRAuthMock(context: nil)
        let service = AuthRemoteService(auth: auth)!
        service.database = RemoteDatabaseMock()
        
        let expectation1 = expectation(description: "Login result")
        
        service.login(email: "me@me.com", password: "123456789") { result in
            switch result {
            case .success(let info):
                XCTAssertNotNil(info.accessToken, "'accessToken' must NOT be nil")
                XCTAssertFalse(info.accessToken!.isEmpty, "'accessToken' must NOT be empty")
                XCTAssertNotNil(info.user, "'user' must NOT be nil")
                XCTAssertFalse(info.user!.id.isEmpty, "'user.id' must NOT be empty")
            default:
                XCTFail("Result is not of type '.success'")
            }
            expectation1.fulfill()
        }
        
        waitForExpectations(timeout: timeout)
    }
}
