//
//  AuthServiceMock.swift
//  Login
//
//  Created by Mounir Ybanez on 01/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Core

class AuthServiceMock: AuthService {
    
    let credentials = credentialList
    let users = userList
    
    func login(email: String, password: String, completion: ((AuthServiceResult) -> Void)?) {
        let credential = Credential(email: email, password: password)
        let isCredentialMatched = credentials.contains(credential)
        if isCredentialMatched {
            let userId = userIdForEmail(email)
            let userIndex = users.index(where: { user -> Bool in
                return user.id == userId
            })!
            var data = AuthServiceData()
            data.accessToken = "accessToken"
            data.user = users[userIndex]
            completion?(.success(data))
        } else {
            let isEmailFound = credentials.contains(where: { credential -> Bool in
                return credential.email == email
            })
            if isEmailFound {
                completion?(.fail(.wrongPassword))
            } else {
                completion?(.fail(.userNotFound))
            }
        }
    }
    
    func register(email: String, password: String, completion: ((AuthServiceResult) -> Void)?) {
        
    }
    
    func resetPassword(email: String, completion: ((AuthServiceResult) -> Void)?) {
        
    }
}
