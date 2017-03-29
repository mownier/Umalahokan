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
    
    var expectedErrorCode: FIRAuthErrorCode?
    var userIdShouldBeEmpty: Bool = false
    var userIdShouldBeNil: Bool = false
    
    func login(email: String, password: String, completion: ((DatabaseAccessResult) -> Void)?) {
        let queue = DispatchQueue(label: "RemoteDatabaseAccessMock")
        queue.async { [unowned self] in
            if let errorCode = self.expectedErrorCode {
                let error = NSError(domain: "", code: errorCode.rawValue, userInfo: nil)
                completion?(.denied(error))
                
            } else {
                var data = DatabaseAccessData()
                data.accessToken = "adsfdasfsadf"
                data.userId = self.userIdShouldBeNil ? nil : self.userIdShouldBeEmpty ? "" : "123213213"
                completion?(.accepted(data))
            }
        }
    }
}
