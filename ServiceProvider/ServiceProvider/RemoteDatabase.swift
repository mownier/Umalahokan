//
//  RemoteDatabase.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 28/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Core
import Firebase

public class RemoteDatabase: DatabaseProtocol {
    
    private var source: RemoteDatabaseSourceProtocol
    
    public required init?(source: RemoteDatabaseSourceProtocol?) {
        guard source != nil else { return nil }
        
        self.source = source!
    }
    
    public func fetchUsers(ids: [String], completion: (([User]) -> Void)?) {
        let path: String
        if ids.count == 1 {
            path = UsersResource.singleUser(ids[0]).path
        } else {
            path = UsersResource.allUsers.path
        }
        
        source.get(path) { snapshot in
            guard snapshot.exists() else {
                completion?([User]())
                return
            }
            
            var user = User()
            user.parse(data: snapshot)
            completion?([user])
        }
    }
}
