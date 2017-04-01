//
//  LoginInteractorTest.swift
//  Login
//
//  Created by Mounir Ybanez on 01/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest
import Core
@testable import Login

class LoginInteractorTest: XCTestCase {
    
    let timeout: TimeInterval = 10
    
    func testInitialization() {
        var interactor = LoginInteractor(authService: nil)
        XCTAssertNil(interactor)
        
        let service = AuthServiceMock()
        interactor = LoginInteractor(authService: service)
        XCTAssertNotNil(interactor)
    }
    
    func testLoginWithError() {
        let expectation1 = expectation(description: "Login")
        let service = AuthServiceMock()
        let interactor = LoginInteractor(authService: service)!
        let output = LoginInteractorOutputMock()
        output.loginWithErrorBlock = { error in
            switch error {
            case .userNotFound: break
            default: XCTFail()
            }
            expectation1.fulfill()
        }
        output.loginWithDataBlock = { data in
            XCTFail()
            expectation1.fulfill()
        }
        interactor.output = output
        interactor.login(email: "you@you.com", password: "me12345")
        waitForExpectations(timeout: timeout)
    }
}
