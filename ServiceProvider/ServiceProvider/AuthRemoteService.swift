//
//  AuthRemoteService.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 23/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Core
import Firebase

open class AuthRemoteService: AuthService {

    private(set) var auth: FIRAuth?
    
    init(auth firebaseAuth: FIRAuth? = FIRAuth.auth()) {
        auth = firebaseAuth
    }
    
    public func login(email: String, password: String, completion: ((_ result: AuthServiceResult) -> Void)?) {
        
    }
    
    public func register(email: String, password: String, completion: ((_ result: AuthServiceResult) -> Void)?) {
        
    }
    
    public func resetPassword(email: String, completion: ((_ result: AuthServiceResult) -> Void)?) {
        
    }
}
