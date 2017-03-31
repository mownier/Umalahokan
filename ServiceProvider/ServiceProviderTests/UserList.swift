//
//  UserList.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 31/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Core

var userList: [User] = {
    var data = [User]()
    
    var user = User()
    user.id = "me12345"
    user.firstName = "me"
    user.lastName = "me"
    user.userName = "meishere"
    data.append(user)
    
    user.id = "you12345"
    user.firstName = "you"
    user.lastName = "you"
    user.userName = "youishere"
    data.append(user)
    
    user.id = "multipleuser12345"
    user.firstName = "multiple"
    user.lastName = "user"
    user.userName = "mutipleuserishere"
    data.append(user)
    
    user.id = "multipleuser12345"
    user.firstName = "multiple"
    user.lastName = "user"
    user.userName = "mutipleuserishere"
    data.append(user)
    
    return data
}()

extension User {
    
    var dictionary: [String: String] {
        return [
            "id": id,
            "first_name": firstName,
            "last_name": lastName,
            "user_name": userName
        ]
    }
}

func snapshotForUser(_ id: String) -> FIRDataSnapshotMock? {
    guard let index = userList.index(where: { user -> Bool in
        return user.id == id
    }) else {
        return nil
    }
    
    let user = userList[index]
    let snapshot = FIRDataSnapshotMock()
    snapshot.childDictionary = user.dictionary
    return snapshot
}
