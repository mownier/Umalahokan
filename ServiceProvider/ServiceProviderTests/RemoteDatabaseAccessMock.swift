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
    
    let queue = DispatchQueue(label: "RemoteDatabaseAccessMock")
    
    var credentials = credentialList
    var expectedErrorCode: FIRAuthErrorCode?
    var userIdShouldBeEmpty: Bool = false
    var userIdShouldBeNil: Bool = false
    
    func login(email: String, password: String, completion: ((DatabaseAccessResult) -> Void)?) {
        let error: Error? = expectedErrorCode == nil ? nil : NSError(domain: "", code: expectedErrorCode!.rawValue, userInfo: nil)
        let credential = Credential(email: email, password: password)
        let isEmailAndPasswordMatched = credentials.contains(credential)
        let isEmailFound = credentials.index { credential -> Bool in
            return credential.email == email
        } == nil ? false : true
        
        queue.async { [unowned self] in
            guard isEmailFound else {
                completion?(.denied(.credentialNotFound(error)))
                return
            }
            
            guard isEmailAndPasswordMatched else {
                completion?(.denied(.invalidCredential(error)))
                return
            }
            
            var data = DatabaseAccessData()
            data.accessToken = "accessToken"
            data.userId = self.userIdShouldBeNil ? nil : self.userIdShouldBeEmpty ? "" : userIdForEmail(email)
            completion?(.accepted(data))
        }
    }
}
