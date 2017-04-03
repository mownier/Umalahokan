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
    
    func testLoginHasAFailResult() {
        let service = AuthServiceMock()
        let interactor = LoginInteractor(authService: service)!
        let output = LoginInteractorOutputMock()
        interactor.output = output
        interactor.login(email: "me@me.com", password: "12345")
        XCTAssertEqual(output.error, .wrongPassword)
        XCTAssertNil(output.data)
        
        interactor.login(email: "user@notfound.com", password: "12345")
        XCTAssertEqual(output.error, .userNotFound)
        XCTAssertNil(output.data)
    }
    
    func testLoginHasASuccessResult() {
        let service = AuthServiceMock()
        let interactor = LoginInteractor(authService: service)!
        let output = LoginInteractorOutputMock()
        interactor.output = output
        interactor.login(email: "me@me.com", password: "abcde12345qwert")
        XCTAssertNil(output.error)
        XCTAssertNotNil(output.data)
        XCTAssertNotNil(output.data!.accessToken)
        XCTAssertFalse(output.data!.accessToken!.isEmpty)
        XCTAssertNotNil(output.data!.user)
        XCTAssertFalse(output.data!.user!.id.isEmpty)
    }
}
