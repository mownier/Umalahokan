//
//  AuthRemoteServiceTest.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 23/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest
@testable import ServiceProvider

class AuthRemoteServiceTest: XCTestCase {
    
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
        guard let service = AuthRemoteService() else {
            XCTFail("AuthRemoteService instance must NOT be nil")
            return
        }
        
        let expectation1 = expectation(description: "Empty email and password")
        service.login(email: "", password: "") { result in
            switch result {
            case .error(let info):
                switch info {
                case .wrongPassword : break
                default : XCTFail("Error 'info' is not of type '.wrongPassword'")
                }
                
            default:
                XCTFail("'result' is not of type '.error'")
            }
            expectation1.fulfill()
        }
        
        let expectation2 = expectation(description: "Existing email and empty password")
        service.login(email: "me@me.com", password: "") { result in
            switch result {
            case .error(let info):
                switch info {
                case .wrongPassword : break
                default : XCTFail("Error 'info' is not of type '.wrongPassword'")
                }
                
            default:
                XCTFail("'result' is not of type '.error'")
            }
            expectation2.fulfill()
        }
        
        let expectation3 = expectation(description: "Existing email and mismatched password")
        service.login(email: "me@me.com", password: "kkJDKFj213898pr") { result in
            switch result {
            case .error(let info):
                switch info {
                case .wrongPassword : break
                default : XCTFail("Error 'info' is not of type '.wrongPassword'")
                }
                
            default:
                XCTFail("'result' is not of type '.error'")
            }
            expectation3.fulfill()
        }
        
        waitForExpectations(timeout: 3)
    }
    
    func testLoginHasErroResultWithInvalidEmailFormat() {
        guard let service = AuthRemoteService() else {
            XCTFail("AuthRemoteService instance must NOT be nil")
            return
        }
        
        let expectation1 = expectation(description: "Invalid email format having no @ and non-empty password")
        service.login(email: "afdsafsafdsf", password: "kkJDKFj213898pr") { result in
            switch result {
            case .error(let info):
                switch info {
                case .invalidEmail : break
                default : XCTFail("Error 'info' is not of type '.invalidEmail'")
                }
                
            default:
                XCTFail("'result' is not of type '.error'")
            }
            expectation1.fulfill()
        }
        
        let expectation2 = expectation(description: "Invalid email format having @ at the end")
        service.login(email: "123adkl213@", password: "kkJDKFj213898pr") { result in
            switch result {
            case .error(let info):
                switch info {
                case .invalidEmail : break
                default : XCTFail("Error 'info' is not of type '.invalidEmail'")
                }
                
            default:
                XCTFail("'result' is not of type '.error'")
            }
            expectation2.fulfill()
        }
        
        let expectation3 = expectation(description: "Invalid email format having @ at the beginning")
        service.login(email: "@123jkjsdf", password: "kkJDKFj213898pr") { result in
            switch result {
            case .error(let info):
                switch info {
                case .invalidEmail : break
                default : XCTFail("Error 'info' is not of type '.invalidEmail'")
                }
                
            default:
                XCTFail("'result' is not of type '.error'")
            }
            expectation3.fulfill()
        }
        
        let expectation4 = expectation(description: "Invalid email format having @ at the end and beginning")
        service.login(email: "@123jkjsdf@", password: "kkJDKFj213898pr") { result in
            switch result {
            case .error(let info):
                switch info {
                case .invalidEmail : break
                default : XCTFail("Error 'info' is not of type '.invalidEmail'")
                }
                
            default:
                XCTFail("'result' is not of type '.error'")
            }
            expectation4.fulfill()
        }
        
        let expectation5 = expectation(description: "Invalid email format with all @")
        service.login(email: "@@@@@@", password: "kkJDKFj213898pr") { result in
            switch result {
            case .error(let info):
                switch info {
                case .invalidEmail : break
                default : XCTFail("Error 'info' is not of type '.invalidEmail'")
                }
                
            default:
                XCTFail("'result' is not of type '.error'")
            }
            expectation5.fulfill()
        }
        
        let expectation6 = expectation(description: "Invalid email format with two @ in between")
        service.login(email: "asdfadsf@kjksadjf@jdskf", password: "kkJDKFj213898pr") { result in
            switch result {
            case .error(let info):
                switch info {
                case .invalidEmail : break
                default : XCTFail("Error 'info' is not of type '.invalidEmail'")
                }
                
            default:
                XCTFail("'result' is not of type '.error'")
            }
            expectation6.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
    
    func testLoginHasErrorResultWithEmailNotFound() {
        guard let service = AuthRemoteService() else {
            XCTFail("AuthRemoteService instance must NOT be nil")
            return
        }
        
        let expectation1 = expectation(description: "Valid email but non-existing and non-empty password")
        service.login(email: "kasjdkf@kjsdkfjk", password: "kkJDKFj213898pr") { result in
            switch result {
            case .error(let info):
                switch info {
                case .emailNotFound : break
                default : XCTFail("Error 'info' is not of type '.emailNotFound'")
                }
                
            default:
                XCTFail("'result' is not of type '.error'")
            }
            expectation1.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
}
