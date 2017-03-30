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
    
    case denied(DatabaseAccessError)
    case accepted(DatabaseAccessData)
}

public struct DatabaseAccessData {
    
    public var refreshToken: String?
    public var accessToken: String?
    public var userId: String?
    
    public init() {
        refreshToken = nil
        accessToken = nil
        userId = nil
    }
}

public enum DatabaseAccessError: Error {
    
    case unknown(Error?)
    case invalidCredential(Error?)
    case credentialNotFound(Error?)
    case tokenUnavailable(Error?)
    case unauthorized(Error?)
    
    public var detailedError: Error? {
        switch self {
        case .unknown(let error),
             .invalidCredential(let error),
             .credentialNotFound(let error),
             .tokenUnavailable(let error),
             .unauthorized(let error):
            return error
        }
    }
}
