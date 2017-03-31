//
//  RemoteDatabaseMock.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 28/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Core

class RemoteDatabaseMock: DatabaseProtocol {
    
    let queue = DispatchQueue(label: "RemoteDatabaseMock")
    var users = userList
    
    func fetchUsers(ids: [String], completion: (([User]) -> Void)?) {
        queue.async { [unowned self] in
            var data = [User]()
            for id in ids {
                data.append(contentsOf: self.usersForId(id))
            }
            completion?(data)
        }
    }
    
    private func usersForId(_ id: String) -> [User] {
        return users.filter({ user -> Bool in
            return user.id == id
        })
    }
}
