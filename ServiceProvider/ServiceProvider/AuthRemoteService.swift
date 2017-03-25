//
//  AuthRemoteService.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 23/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Core
import Firebase

final class AuthRemoteService: AuthService {
    
    private var auth: FIRAuth
    
    required public init?(auth firebaseAuth: FIRAuth? = FIRAuth.auth()) {
        guard firebaseAuth != nil else { return nil }
        
        auth = firebaseAuth!
    }
    
    public func login(email: String, password: String, completion: ((_ result: AuthServiceResult) -> Void)?) {
        auth.signIn(withEmail: email, password: password) { user, error in
            guard error == nil else {
                var info: AuthServiceError = .unknown
                if let errorName = (error! as NSError).userInfo["error_name"] as? String {
                    switch errorName {
                    case "ERROR_WRONG_PASSWORD" : info = .wrongPassword
                    case "ERROR_INVALID_EMAIL"  : info = .invalidEmail
                    case "ERROR_USER_NOT_FOUND" : info = .emailNotFound
                    default : break
                    }
                }
                completion?(.error(info))
                return
            }
        }
    }
    
    public func register(email: String, password: String, completion: ((_ result: AuthServiceResult) -> Void)?) {
        
    }
    
    public func resetPassword(email: String, completion: ((_ result: AuthServiceResult) -> Void)?) {
        
    }
}
