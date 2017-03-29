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
    
    private var access: DatabaseAccess
    private var database: DatabaseProtocol
    
    public required init?(access: DatabaseAccess?, database: DatabaseProtocol?) {
        guard access != nil, database != nil else { return nil }
        
        self.access = access!
        self.database = database!
    }
    
    public func login(email: String, password: String, completion: ((_ result: AuthServiceResult) -> Void)?) {
        access.login(email: email, password: password) { [unowned self] result in
            switch result {
            case .denied(let error):
                let info = AuthServiceError(code: error._code)
                completion?(.fail(info))
            
            case .accepted(let data):
                guard let userId = data.userId else {
                    completion?(.fail(.unknown))
                    return
                }
                
                self.database.fetchUsers(ids: [userId], completion: { users in
                    guard users.count == 1 else {
                        completion?(.fail(.unknown))
                        return
                    }
                    
                    var authData = AuthServiceData()
                    authData.accessToken = data.accessToken
                    authData.refreshToken = data.refreshToken
                    authData.user = users[0]
                    completion?(.success(authData))
                })
            }
        }
    }
    
    public func register(email: String, password: String, completion: ((_ result: AuthServiceResult) -> Void)?) {
        
    }
    
    public func resetPassword(email: String, completion: ((_ result: AuthServiceResult) -> Void)?) {
        
    }
}
