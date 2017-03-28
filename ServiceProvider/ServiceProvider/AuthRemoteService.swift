//
//  AuthRemoteService.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 23/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Core
import Firebase

public final class AuthRemoteService: AuthService {
    
    private var auth: FIRAuth
    public lazy var database: DatabaseProtocol = RemoteDatabase()
    
    required public init?(auth firebaseAuth: FIRAuth? = FIRAuth.auth()) {
        guard firebaseAuth != nil else { return nil }
        
        auth = firebaseAuth!
    }
    
    public func login(email: String, password: String, completion: ((_ result: AuthServiceResult) -> Void)?) {
        auth.signIn(withEmail: email, password: password) { user, error in
            guard let user = user, error == nil else {
                let info = AuthServiceError(code: error!._code)
                completion?(.fail(info))
                return
            }
            
            user.getTokenWithCompletion() { [unowned self] token, error in
                guard let token = token, error == nil else {
                    let info = AuthServiceError(code: error!._code)
                    completion?(.fail(info))
                    return
                }
                
                self.database.fetchUsers(ids: [user.uid], completion: { users in
                    guard users.count == 1 else {
                        completion?(.fail(.unknown))
                        return
                    }
                    
                    var data = AuthServiceData()
                    data.accessToken = token
                    data.refreshToken = user.refreshToken
                    data.user = users[0]
                    completion?(.success(data))
                })
            }
        }
    }
    
    public func register(email: String, password: String, completion: ((_ result: AuthServiceResult) -> Void)?) {
        
    }
    
    public func resetPassword(email: String, completion: ((_ result: AuthServiceResult) -> Void)?) {
        
    }
}
