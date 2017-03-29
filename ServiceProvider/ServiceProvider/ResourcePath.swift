//
//  ResourcePath.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 28/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

public enum UsersResource {
    
    case allUsers
    case singleUser(String)
    
    var path: String {
        switch self {
        case .allUsers:
            return "users"
            
        case .singleUser(let id):
            var relativePath = UsersResource.allUsers.path
            relativePath.append("/\(id)")
            return relativePath
        }
    }
}
