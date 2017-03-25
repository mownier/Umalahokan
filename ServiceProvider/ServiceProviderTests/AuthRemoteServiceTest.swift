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
    
    func testInitializationHasNilFirebaseAuth() {
        let service = AuthRemoteService()
        XCTAssertNil(service.auth, "")
    }
    
    func testLoginHasErrorResult() {
        let resultExpectation = expectation(description: "Login result")
        let service = AuthRemoteService()
        service.login(email: "", password: "") { result in
            switch result {
            case .error : break
            default     : break
            }
            XCTFail()
            resultExpectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
}
