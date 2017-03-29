//
//  FIRAuthMock.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 29/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Firebase

class FIRAuthMock: FIRAuth {

    struct Credential: Equatable {
        
        var email: String
        var password: String
        
        init() {
            email = ""
            password = ""
        }
        
        static func ==(lhs: Credential, rhs: Credential) -> Bool {
            return lhs.email == rhs.email && lhs.password == rhs.password
        }
    }
    
    private var context: String
    private var credentials = [Credential]()
    
    required init(context: String) {
        self.context = context
        var credential = Credential()
        credential.email = "me@me.com"
        credential.password = "abcde12345qwert"
        credentials.append(credential)
    }
    
    override func signIn(withEmail email: String, password: String, completion: FirebaseAuth.FIRAuthResultCallback? = nil) {
        var credential = Credential()
        credential.email = email
        credential.password = password
        
        let isFound = credentials.contains(credential)
        
        let queue = DispatchQueue(label: context)
        queue.async {
            guard isFound else {
                let code = FIRAuthErrorCode.errorCodeUserNotFound.rawValue
                let error = NSError(domain: "", code: code, userInfo: nil)
                completion?(nil, error)
                return
            }
        }
    }
}
