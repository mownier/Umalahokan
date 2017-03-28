//
//  RemoteDatabaseMock.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 28/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Core

class RemoteDatabaseMock: DatabaseProtocol {
    
    func fetchUsers(ids: [String], completion: (([User]) -> Void)?) {
        let queue = DispatchQueue(label: "Fetch users")
        queue.async {
            var user = User()
            user.id = "jk891203weiuiqwe1239"
            completion?([user])
        }
    }
}
