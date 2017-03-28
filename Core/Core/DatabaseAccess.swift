//
//  DatabaseAccess.swift
//  Core
//
//  Created by Mounir Ybanez on 28/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

public protocol DatabaseAccess {
    
    func login(email: String, password: String, completion: ((DatabaseAccessResult) -> Void)?)
}

public enum DatabaseAccessResult {
    
    case denied(Error)
    case accepted(DatabaseAccessData)
}

public struct DatabaseAccessData {
    
    public var refreshToken: String?
    public var accessToken: String?
    
    public init() {
        refreshToken = nil
        accessToken = nil
    }
}
