//
//  AuthServiceErrorExtension.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 27/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Core
import Firebase

public extension AuthServiceError {
    
    init(code: Int) {
        switch code {
        case FIRAuthErrorCode.errorCodeWrongPassword.rawValue: self = .wrongPassword
        case FIRAuthErrorCode.errorCodeInvalidEmail.rawValue: self = .invalidEmail
        case FIRAuthErrorCode.errorCodeUserNotFound.rawValue: self = .userNotFound
        default: self = .unknown
        }
    }
}
