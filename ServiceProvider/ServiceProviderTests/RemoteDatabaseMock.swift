//
//  RemoteDatabaseMock.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 28/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Core

class RemoteDatabaseMock: DatabaseProtocol {
    
    var userCount: Int = 1
    
    func fetchUsers(ids: [String], completion: (([User]) -> Void)?) {
        let queue = DispatchQueue(label: "Fetch users")
        queue.async { [unowned self] in
            var users = [User]()
            for _ in 0..<self.userCount {
                var user = User()
                user.id = "\(Date().timeIntervalSince1970)"
                users.append(user)
            }
            completion?(users)
        }
    }
}
