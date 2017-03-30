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
        FirebaseHelper.clearApp()
        var ref = FirebaseHelper.createReference()
        var source = RemoteDatabaseSource(reference: ref)
        var database = RemoteDatabase(source: source)
        var auth = FirebaseHelper.createAuth()
        var access = RemoteDatabaseAccess(firebaseAuth: auth)
        var service = AuthRemoteService(access: access, database: database)
        XCTAssertNil(service)
        
        FirebaseHelper.configureApp()
        ref = FirebaseHelper.createReference()
        source = RemoteDatabaseSource(reference: ref)
        database = RemoteDatabase(source: source)
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
            case .fail(let info) where info == .wrongPassword:
                break
                
            default:
                XCTFail()
            }
            expectation1.fulfill()
        }
        
        let expectation2 = expectation(description: "Existing email and empty password")
        service.login(email: "me@me.com", password: "") { result in
            switch result {
            case .fail(let info) where info == .wrongPassword:
                break
                
            default:
                XCTFail()
            }
            expectation2.fulfill()
        }
        
        let expectation3 = expectation(description: "Existing email and mismatched password")
        service.login(email: "me@me.com", password: "abcdef12345678") { result in
            switch result {
            case .fail(let info) where info == .wrongPassword:
                break
                
            default:
                XCTFail()
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
        service.login(email: "abcde12334qwert", password: "123456789abcde") { result in
            switch result {
            case .fail(let info) where info == .invalidEmail:
                break
                
            default:
                XCTFail()
            }
            expectation1.fulfill()
        }
        
        let expectation2 = expectation(description: "Invalid email format having @ at the end")
        service.login(email: "you@", password: "123456789abcde") { result in
            switch result {
            case .fail(let info) where info == .invalidEmail:
                break
                
            default:
                XCTFail()
            }
            expectation2.fulfill()
        }
        
        let expectation3 = expectation(description: "Invalid email format having @ at the beginning")
        service.login(email: "@you.com", password: "123456789abcde") { result in
            switch result {
            case .fail(let info) where info == .invalidEmail:
                break
                
            default:
                XCTFail()
            }
            expectation3.fulfill()
        }
        
        let expectation4 = expectation(description: "Invalid email format having @ at the end and beginning")
        service.login(email: "@you@", password: "123456789abcde") { result in
            switch result {
            case .fail(let info) where info == .invalidEmail:
                break
                
            default:
                XCTFail()
            }
            expectation4.fulfill()
        }
        
        let expectation5 = expectation(description: "Invalid email format with all @")
        service.login(email: "@@@@@@", password: "123456789abcde") { result in
            switch result {
            case .fail(let info) where info == .invalidEmail:
                break
                
            default:
                XCTFail()
            }
            expectation5.fulfill()
        }
        
        let expectation6 = expectation(description: "Invalid email format with two @ in between")
        service.login(email: "you@me@we", password: "123456789abcde") { result in
            switch result {
            case .fail(let info) where info == .invalidEmail:
                break
                
            default:
                XCTFail()
            }
            expectation6.fulfill()
        }
        
        waitForExpectations(timeout: timeout)
    }
    
    func testLoginHasErrorResultWithUserNotFound() {
        let access = RemoteDatabaseAccessMock()
        let database = RemoteDatabaseMock()
        let service = AuthRemoteService(access: access, database: database)!
        
        access.expectedErrorCode = .errorCodeUserNotFound
        
        let expectation1 = expectation(description: "Valid email but non-existing and non-empty password")
        service.login(email: "you@you.com", password: "123456789abcde") { result in
            switch result {
            case .fail(let info) where info == .userNotFound:
                break
                
            default:
                XCTFail()
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
        
        service.login(email: "me@me.com", password: "abcde12345qwert") { result in
            switch result {
            case .success(let info):
                XCTAssertNotNil(info.accessToken)
                XCTAssertFalse(info.accessToken!.isEmpty)
                XCTAssertNotNil(info.user)
                XCTAssertFalse(info.user!.id.isEmpty)
                
            default:
                XCTFail()
            }
            expectation1.fulfill()
        }
        
        waitForExpectations(timeout: timeout)
    }
    
    func testLoginHasBeenAcceptedButUserIdIsNil() {
        let access = RemoteDatabaseAccessMock()
        let database = RemoteDatabaseMock()
        let service = AuthRemoteService(access: access, database: database)!
        
        access.userIdShouldBeEmpty = true
        
        let expectation1 = expectation(description: "The returned userId is nil")
        service.login(email: "me@me.com", password: "abcde12345qwert") { result in
            switch result {
            case .fail(let error) where error == .userIdUndefined:
                break
                
            default:
                XCTFail()
            }
            expectation1.fulfill()
        }
        
        waitForExpectations(timeout: timeout)
    }
    
    func testLoginHasBeenAcceptedButUserIdIsEmpty() {
        let access = RemoteDatabaseAccessMock()
        let database = RemoteDatabaseMock()
        let service = AuthRemoteService(access: access, database: database)!
        
        access.userIdShouldBeNil = true
        
        let expectation1 = expectation(description: "The returned userId is nil")
        service.login(email: "me@me.com", password: "abcde12345qwert") { result in
            switch result {
            case .fail(let error) where error == .userIdUndefined:
                break
                
            default:
                XCTFail()
            }
            expectation1.fulfill()
        }
        
        waitForExpectations(timeout: timeout)
    }
    
    func testLoginHasBeenAcceptedButNoUserInformationRetrieved() {
        let access = RemoteDatabaseAccessMock()
        let database = RemoteDatabaseMock()
        let service = AuthRemoteService(access: access, database: database)!
        
        database.userCount = 0
        
        let expectation1 = expectation(description: "User not found")
        service.login(email: "me@me.com", password: "abcde12345qwert") { result in
            switch result {
            case .fail(let error) where error == .noUserInfo:
                break
                
            default:
                XCTFail()
            }
            expectation1.fulfill()
        }
        
        waitForExpectations(timeout: timeout)
    }

    func testLoginHasBeenAcceptedButMultipleUserInformationRetrieved() {
        let access = RemoteDatabaseAccessMock()
        let database = RemoteDatabaseMock()
        let service = AuthRemoteService(access: access, database: database)!
        
        database.userCount = 4
        
        let expectation1 = expectation(description: "User not found")
        service.login(email: "me@me.com", password: "abcde12345qwert") { result in
            switch result {
            case .fail(let error) where error == .multipleUserInfo:
                break
                
            default:
                XCTFail()
            }
            expectation1.fulfill()
        }
        
        waitForExpectations(timeout: timeout)
    }
}
