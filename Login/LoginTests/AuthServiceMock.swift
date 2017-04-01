//
//  AuthServiceMock.swift
//  Login
//
//  Created by Mounir Ybanez on 01/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Core

class AuthServiceMock: AuthService {
    
    let queue = DispatchQueue(label: "AuthServiceMock")
    
    func login(email: String, password: String, completion: ((AuthServiceResult) -> Void)?) {
        queue.async {
            completion?(.fail(.userNotFound))
        }
    }
    
    func register(email: String, password: String, completion: ((AuthServiceResult) -> Void)?) {
        
    }
    
    func resetPassword(email: String, completion: ((AuthServiceResult) -> Void)?) {
        
    }
}
