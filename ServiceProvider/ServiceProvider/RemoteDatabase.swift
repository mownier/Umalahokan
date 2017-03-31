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
        guard !ids.isEmpty else {
            completion?([User]())
            return
        }
        
        var completionCount: Int = 0
        var users = [User]()
        for id in ids {
            source.getUserInfo(id) { snapshot in
                completionCount += 1
                
                if snapshot.exists() {
                    var user = User()
                    user.parse(data: snapshot)
                    users.append(user)
                }
                
                if completionCount == ids.count {
                    completion?(users)
                }
            }
        }
    }
}
