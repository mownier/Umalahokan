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
            case .error : break
            case .data  : XCTFail("Result is not of type '.error'")
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
            case .error : XCTFail("Result is not of type '.data'")
            case .data  : break
            }
            
            loginResult.fulfill()
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
        queue.async {
            DispatchQueue.main.async { [unowned self] in
                self.processResult(completion)
            }
        }
    }
    
    func register(email: String, password: String, completion: ((AuthServiceResult) -> Void)?) {
        
    }
    
    func resetPassword(email: String, completion: ((AuthServiceResult) -> Void)?) {
        
    }
    
    private func processResult(_ completion: ((AuthServiceResult) -> Void)?) {
        let result: AuthServiceResult
        
        if hasError {
            let info = NSError(domain: "", code: 0, userInfo: nil)
            result = .error(info)
            
        } else {
            let info = AuthServiceData()
            result = .data(info)
        }
        
        completion?(result)
    }
}
