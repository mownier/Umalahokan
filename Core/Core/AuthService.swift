//
//  AuthService.swift
//  Core
//
//  Created by Mounir Ybanez on 23/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

public protocol AuthService {
    
    func login(email: String, password: String, completion: ((_ result: AuthServiceResult) -> Void)?)
    func register(email: String, password: String, completion: ((_ result: AuthServiceResult) -> Void)?)
    func resetPassword(email: String, completion: ((_ result: AuthServiceResult) -> Void)?)
}

public enum AuthServiceResult {

    case fail(AuthServiceError)
    case success(AuthServiceData)
}

public struct AuthServiceData {
    
    public var accessToken: String?
    public var refreshToken: String?
    public var user: User?
    
    public init() {
        accessToken = nil
        refreshToken = nil
        user = nil
    }
}

public enum AuthServiceError: Error {
    
    case unknown
    case wrongPassword
    case invalidEmail
    case userNotFound
}
