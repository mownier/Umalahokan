//
//  DatabaseAccessErrorExtension.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 30/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Core
import Firebase

extension DatabaseAccessError {

    init(detailedError: Error) {
        switch detailedError._code {
        case FIRAuthErrorCode.errorCodeInvalidEmail.rawValue,
             FIRAuthErrorCode.errorCodeUserNotFound.rawValue:
            self = .credentialNotFound(detailedError)
            
        case FIRAuthErrorCode.errorCodeWrongPassword.rawValue,
             FIRAuthErrorCode.errorCodeInvalidCredential.rawValue,
             FIRAuthErrorCode.errorCodeUserMismatch.rawValue:
            self = .invalidCredential(detailedError)
        
        case FIRAuthErrorCode.errorCodeInvalidCustomToken.rawValue,
             FIRAuthErrorCode.errorCodeInvalidUserToken.rawValue,
             FIRAuthErrorCode.errorCodeUserTokenExpired.rawValue,
             FIRAuthErrorCode.errorCodeCustomTokenMismatch.rawValue:
            self = .tokenUnavailable(detailedError)
        
        default:
            self = .unknown(detailedError)
        }
    }
}
