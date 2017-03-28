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
    
    func testInitialization() {
        let database = RemoteDatabase()
        
        FirebaseHelper.clearApp()
        var auth = FirebaseHelper.createAuth()
        var access = RemoteDatabaseAccess(firebaseAuth: auth)
        var service = AuthRemoteService(access: access, database: database)
        XCTAssertNil(service)
        
        FirebaseHelper.configureApp()
        auth = FirebaseHelper.createAuth()
        access = RemoteDatabaseAccess(firebaseAuth: auth)
        service = AuthRemoteService(access: access, database: database)
        XCTAssertNotNil(service)
    }
    
    func testLoginHasErrorResultWithWrongPassword() {
        let access = RemoteDatabaseAccessMock()
        let database = RemoteDatabaseMock()
        let service = AuthRemoteService(access: access, database: database)!
        
        access.expectedErrorCode = .errorCodeWrongPassword
        
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
        let access = RemoteDatabaseAccessMock()
        let database = RemoteDatabaseMock()
        let service = AuthRemoteService(access: access, database: database)!
        
        access.expectedErrorCode = .errorCodeInvalidEmail
        
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
        let access = RemoteDatabaseAccessMock()
        let database = RemoteDatabaseMock()
        let service = AuthRemoteService(access: access, database: database)!
        
        access.expectedErrorCode = .errorCodeUserNotFound
        
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
        let access = RemoteDatabaseAccessMock()
        let database = RemoteDatabaseMock()
        let service = AuthRemoteService(access: access, database: database)!
        
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
