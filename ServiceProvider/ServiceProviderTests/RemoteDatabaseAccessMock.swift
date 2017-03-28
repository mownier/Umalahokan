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
    
    func login(email: String, password: String, completion: ((DatabaseAccessResult) -> Void)?) {
        let queue = DispatchQueue(label: "RemoteDatabaseAccessMock")
        queue.async { [unowned self] in
            if let errorCode = self.expectedErrorCode {
                let error = NSError(domain: "", code: errorCode.rawValue, userInfo: nil)
                completion?(.denied(error))
                
            } else {
                var data = DatabaseAccessData()
                data.accessToken = "adsfdasfsadf"
                data.userId = "123213213"
                completion?(.accepted(data))
            }
        }
    }
}
