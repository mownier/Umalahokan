//
//  LoginInteractorOutputMock.swift
//  Login
//
//  Created by Mounir Ybanez on 01/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Core
import Login

class LoginInteractorOutputMock: LoginInteractorOutput {

    var error: AuthServiceError?
    
    func didLogin(error serviceError: AuthServiceError?) {
        error = serviceError
    }
}
