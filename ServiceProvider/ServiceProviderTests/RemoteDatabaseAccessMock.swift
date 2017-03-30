//
//  RemoteDatabaseAccessMock.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 28/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Core
import Firebase

class RemoteDatabaseAccessMock: DatabaseAccess {
    
    struct Credential: Equatable {

        var email: String = ""
        var password: String = ""
        
        static func ==(lhs: Credential, rhs: Credential) -> Bool {
            return lhs.email == rhs.email && lhs.password == rhs.password
        }
    }
    
    lazy var credentials: [Credential] = {
        var credential = Credential()
        credential.email = "me@me.com"
        credential.password = "abcde12345qwert"
        return [credential]
    }()
    
    var expectedErrorCode: FIRAuthErrorCode?
    var userIdShouldBeEmpty: Bool = false
    var userIdShouldBeNil: Bool = false
    
    func login(email: String, password: String, completion: ((DatabaseAccessResult) -> Void)?) {
        let error: Error? = expectedErrorCode == nil ? nil : NSError(domain: "", code: expectedErrorCode!.rawValue, userInfo: nil)
        let credential = Credential(email: email, password: password)
        let isEmailAndPasswordMached = credentials.contains(credential)
        let isEmailFound = credentials.index { credential -> Bool in
            return credential.email == email
        } == nil ? false : true
        
        let queue = DispatchQueue(label: "RemoteDatabaseAccessMock")
        queue.async { [unowned self] in
            guard isEmailFound else {
                completion?(.denied(.credentialNotFound(error)))
                return
            }
            
            guard isEmailAndPasswordMached else {
                completion?(.denied(.invalidCredential(error)))
                return
            }
            
            var data = DatabaseAccessData()
            data.accessToken = "adsfdasfsadf"
            data.userId = self.userIdShouldBeNil ? nil : self.userIdShouldBeEmpty ? "" : "123213213"
            completion?(.accepted(data))
        }
    }
}
