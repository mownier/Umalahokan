//
//  RemoteDatabaseAccess.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 28/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Core
import Firebase

public class RemoteDatabaseAccess: DatabaseAccess {

    private var auth: FIRAuth
    
    public required init?(firebaseAuth: FIRAuth? = FIRAuth.auth()) {
        guard firebaseAuth != nil else { return nil }
        
        auth = firebaseAuth!
    }
    
    public func login(email: String, password: String, completion: ((DatabaseAccessResult) -> Void)?) {
        auth.signIn(withEmail: email, password: password) { user, error in
            guard let user = user, error == nil else {
                completion?(.denied(error!))
                return
            }
            
            user.getTokenWithCompletion() { token, error in
                guard let token = token, error == nil else {
                    completion?(.denied(error!))
                    return
                }
                
                var data = DatabaseAccessData()
                data.accessToken = token
                data.refreshToken = user.refreshToken
                
                completion?(.accepted(data))
            }
        }
    }
}
