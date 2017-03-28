//
//  AuthServiceTest.swift
//  Core
//
//  Created by Mounir Ybanez on 23/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest
@testable import Core

class AuthServiceTest: XCTestCase {

    func testLoginHasAnErrorResult() {
        let loginResult = expectation(description: "Login result")
        
        let service = AuthServiceProvider()
        service.hasError = true
        service.login(email: "", password: "") { (result) in
            switch result {
            case .fail : break
            case .success  : XCTFail("Result is not of type '.error'")
            }
            
            loginResult.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error, "Expectation Timeout with error: \(error)")
        }
    }
    
    func testLoginHasDataResult() {
        let loginResult = expectation(description: "Login result")
        
        let service = AuthServiceProvider()
        service.hasError = false
        service.login(email: "", password: "") { (result) in
            switch result {
            case .fail : XCTFail("Result is not of type '.data'")
            case .success  : break
            }
            
            loginResult.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error, "Expectation Timeout with error: \(error)")
        }
    }
    
    func testRegisterHasErrorResult() {
        let registerResult = expectation(description: "Register result")
        
        let service = AuthServiceProvider()
        service.hasError = true
        service.register(email: "", password: "") { result in
            switch result {
            case .fail : break
            case .success  : XCTFail("Result is not of type '.error'")
            }
            
            registerResult.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error, "Expectation Timeout with error: \(error)")
        }
    }
    
    func testRegisterHasDataResult() {
        let registerResult = expectation(description: "Register result")
        
        let service = AuthServiceProvider()
        service.hasError = false
        service.register(email: "", password: "") { result in
            switch result {
            case .fail : XCTFail("Result is not of type '.data'")
            case .success  : break
            }
            
            registerResult.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error, "Expectation Timeout with error: \(error)")
        }
    }
    
    func testResetPasswordHasErrorResult() {
        let resetPasswordResult = expectation(description: "Reset password result")
        
        let service = AuthServiceProvider()
        service.hasError = true
        service.resetPassword(email: "") { result in
            switch result {
            case .fail : break
            case .success  : XCTFail("Result is not of type '.error'")
            }
            
            resetPasswordResult.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error, "Expectation Timeout with error: \(error)")
        }
    }
    
    func testResetPasswordHasDataResult() {
        let resetPasswordResult = expectation(description: "Reset password result")
        
        let service = AuthServiceProvider()
        service.hasError = false
        service.resetPassword(email: "") { result in
            switch result {
            case .fail : XCTFail("Result is not of type '.data'")
            case .success  : break
            }
            
            resetPasswordResult.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error, "Expectation Timeout with error: \(error)")
        }
    }
}

class AuthServiceProvider: AuthService {
    
    var hasError = false
    var queue = DispatchQueue(label: "AuthServiceProvider")
    
    func login(email: String, password: String, completion: ((AuthServiceResult) -> Void)?) {
        processQueue(completion)
    }
    
    func register(email: String, password: String, completion: ((AuthServiceResult) -> Void)?) {
        processQueue(completion)
    }
    
    func resetPassword(email: String, completion: ((AuthServiceResult) -> Void)?) {
        processQueue(completion)
    }
    
    private func processQueue(_ completion: ((AuthServiceResult) -> Void)?) {
        queue.async {
            DispatchQueue.main.async { [unowned self] in
                self.processResult(completion)
            }
        }
    }
    
    private func processResult(_ completion: ((AuthServiceResult) -> Void)?) {
        let result: AuthServiceResult
        
        if hasError {
            let info = AuthServiceError.unknown
            result = .fail(info)
            
        } else {
            let info = AuthServiceData()
            result = .success(info)
        }
        
        completion?(result)
    }
}
