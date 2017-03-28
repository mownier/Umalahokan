//
//  UserService.swift
//  Core
//
//  Created by Mounir Ybanez on 28/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

public protocol UserService {

    func fetchUsers(ids: [String], completion: ((UserServiceFetchResult) -> Void)?)
}

public enum UserServiceFetchResult {
    
    case fail(UserServiceError)
    case success([User])
}

public enum UserServiceError {
    
    case unknown
    case noUsersFound
}
