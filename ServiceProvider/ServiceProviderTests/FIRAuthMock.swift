//
//  FIRAuthMock.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 29/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Firebase

class FIRAuthMock: FIRAuth {
    
    private var credentials = credentialList
    private var context: String
    
    required init(context: String) {
        self.context = context
    }
    
    override func signIn(withEmail email: String, password: String, completion: FirebaseAuth.FIRAuthResultCallback? = nil) {
        var credential = Credential()
        credential.email = email
        credential.password = password
        
        let isEmailAndPasswordMatched = credentials.contains(credential)
        let isEmailFound: Bool = credentials.index { (credential) -> Bool in
            return credential.email == email
        } == nil ? false : true
        
        let queue = DispatchQueue(label: context)
        queue.async { [unowned self] in
            guard email != "invalid@email.com" else {
                let code = FIRAuthErrorCode.errorCodeInvalidEmail.rawValue
                let error = NSError(domain: "", code: code, userInfo: nil)
                completion?(nil, error)
                return
            }
            
            guard password != "wrong12345password" else {
                let code = FIRAuthErrorCode.errorCodeWrongPassword.rawValue
                let error = NSError(domain: "", code: code, userInfo: nil)
                completion?(nil, error)
                return
            }
            
            guard isEmailFound else {
                let code: Int = FIRAuthErrorCode.errorCodeUserNotFound.rawValue
                let error = NSError(domain: "", code: code, userInfo: nil)
                completion?(nil, error)
                return
            }
            
            guard isEmailAndPasswordMatched else {
                let code = FIRAuthErrorCode.errorCodeWrongPassword.rawValue
                let error = NSError(domain: "", code: code, userInfo: nil)
                completion?(nil, error)
                return
            }
            
            let user = FIRUserMock(context: self.context)
            user.accessToken = "accesstoken"
            completion?(user, nil)
        }
    }
}
