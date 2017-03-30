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
    
    public required init?(firebaseAuth: FIRAuth?) {
        guard firebaseAuth != nil else { return nil }
        
        auth = firebaseAuth!
    }
    
    public func login(email: String, password: String, completion: ((DatabaseAccessResult) -> Void)?) {
        auth.signIn(withEmail: email, password: password) { [unowned self] user, error in
            guard error == nil else {
                let accessError = DatabaseAccessError(detailedError: error!)
                completion?(.denied(accessError))
                return
            }
            
            self.getAccessToken(user: user) { result in
                completion?(result)
            }
        }
    }
    
    public func getAccessToken(user: FIRUser?, completion: ((DatabaseAccessResult) -> Void)?) {
        guard let user = user, !user.uid.isEmpty  else {
            completion?(.denied(.unauthorized(nil)))
            return
        }
        
        user.getTokenWithCompletion() { token, error in
            guard let token = token, error == nil else {
                completion?(.denied(.tokenUnavailable(error)))
                return
            }
            
            var data = DatabaseAccessData()
            data.accessToken = token
            data.refreshToken = user.refreshToken
            data.userId = user.uid
            
            completion?(.accepted(data))
        }
    }
}
