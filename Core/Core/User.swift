//
//  User.swift
//  Core
//
//  Created by Mounir Ybanez on 23/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

public struct User: Equatable {
    
    public var id: String
    public var firstName: String
    public var lastName: String
    public var userName: String
    
    public init() {
        id = ""
        firstName = ""
        lastName = ""
        userName = ""
    }
}

public func ==(lhs: User, rhs: User) -> Bool {
    return lhs.id == rhs.id &&
        lhs.firstName == rhs.firstName &&
        lhs.lastName == rhs.lastName &&
        lhs.userName == rhs.userName
}
