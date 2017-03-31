//
//  DatabaseAccessErrorTest.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 31/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest
import Core
@testable import ServiceProvider
import Firebase

class DatabaseAccessErrorTest: XCTestCase {
    
    func testInitialization() {
        var code = FIRAuthErrorCode.errorCodeInvalidUserToken.rawValue
        var detailedError = NSError(domain: "", code: code, userInfo: nil)
        var error = DatabaseAccessError(detailedError: detailedError)
        switch error {
        case .tokenUnavailable: break
        default: XCTFail()
        }
        
        code = FIRAuthErrorCode.errorCodeUserTokenExpired.rawValue
        detailedError = NSError(domain: "", code: code, userInfo: nil)
        error = DatabaseAccessError(detailedError: detailedError)
        switch error {
        case .tokenUnavailable: break
        default: XCTFail()
        }
        
        code = FIRAuthErrorCode.errorCodeInvalidCustomToken.rawValue
        detailedError = NSError(domain: "", code: code, userInfo: nil)
        error = DatabaseAccessError(detailedError: detailedError)
        switch error {
        case .tokenUnavailable: break
        default: XCTFail()
        }
        
        code = FIRAuthErrorCode.errorCodeCustomTokenMismatch.rawValue
        detailedError = NSError(domain: "", code: code, userInfo: nil)
        error = DatabaseAccessError(detailedError: detailedError)
        switch error {
        case .tokenUnavailable: break
        default: XCTFail()
        }
        
        code = FIRAuthErrorCode.errorCodeKeychainError.rawValue
        detailedError = NSError(domain: "", code: code, userInfo: nil)
        error = DatabaseAccessError(detailedError: detailedError)
        switch error {
        case .unknown: break
        default: XCTFail()
        }
        
        code = FIRAuthErrorCode.errorCodeUserNotFound.rawValue
        detailedError = NSError(domain: "", code: code, userInfo: nil)
        error = DatabaseAccessError(detailedError: detailedError)
        switch error {
        case .credentialNotFound: break
        default: XCTFail()
        }
        
        code = FIRAuthErrorCode.errorCodeInvalidEmail.rawValue
        detailedError = NSError(domain: "", code: code, userInfo: nil)
        error = DatabaseAccessError(detailedError: detailedError)
        switch error {
        case .credentialNotFound: break
        default: XCTFail()
        }
        
        code = FIRAuthErrorCode.errorCodeUserMismatch.rawValue
        detailedError = NSError(domain: "", code: code, userInfo: nil)
        error = DatabaseAccessError(detailedError: detailedError)
        switch error {
        case .invalidCredential: break
        default: XCTFail()
        }
        
        code = FIRAuthErrorCode.errorCodeWrongPassword.rawValue
        detailedError = NSError(domain: "", code: code, userInfo: nil)
        error = DatabaseAccessError(detailedError: detailedError)
        switch error {
        case .invalidCredential: break
        default: XCTFail()
        }
        
        code = FIRAuthErrorCode.errorCodeInvalidCredential.rawValue
        detailedError = NSError(domain: "", code: code, userInfo: nil)
        error = DatabaseAccessError(detailedError: detailedError)
        switch error {
        case .invalidCredential: break
        default: XCTFail()
        }
    }
}
