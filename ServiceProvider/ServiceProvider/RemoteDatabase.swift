//
//  RemoteDatabase.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 28/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Core
import Firebase

class RemoteDatabase: DatabaseProtocol {
    
    var rootRef: FIRDatabaseReference = FIRDatabase.database().reference()
    
    public func fetchUsers(ids: [String], completion: (([User]) -> Void)?) {
        if ids.count == 1 {
            let path = UsersResource.singleUser(ids[0]).path
            rootRef.child(path).observeSingleEvent(of: .value, with: { snapshot in
                guard snapshot.exists() else {
                    completion?([User]())
                    return
                }
                
                var user = User()
                user.parse(data: snapshot)
                completion?([user])
            })
        }
    }
}
