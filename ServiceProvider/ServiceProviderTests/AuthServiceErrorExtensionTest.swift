//
//  AuthServiceErrorExtensionTest.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 29/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest
import Core
import Firebase
@testable import ServiceProvider

class AuthServiceErrorExtensionTest: XCTestCase {
    
    func testInitialization() {
        var error = AuthServiceError(code: FIRAuthErrorCode.errorCodeWrongPassword.rawValue)
        XCTAssert(error == .wrongPassword)
        
        error = AuthServiceError(code: FIRAuthErrorCode.errorCodeInvalidEmail.rawValue)
        XCTAssert(error == .invalidEmail)
        
        error = AuthServiceError(code: FIRAuthErrorCode.errorCodeUserNotFound.rawValue)
        XCTAssert(error == .userNotFound)
        
        error = AuthServiceError(code: -873236123)
        XCTAssert(error == .unknown)
    }
}
