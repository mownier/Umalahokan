//
//  FIRAuthMock.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 27/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Firebase

class FIRAuthMock: FIRAuth {
    
    var expectedError: FIRAuthErrorCode?
    var context: String?
    
    init(context: String?) {
        self.context = context
    }
    
    override func signIn(withEmail email: String, password: String, completion: FIRAuthResultCallback? = nil) {
        let queue = DispatchQueue(label: "\(self)")
        queue.async { [unowned self] in
            if let code = self.expectedError?.rawValue {
                let error = NSError(domain: FIRAuthErrorDomain, code: code, userInfo: nil)
                completion?(nil, error)
                return
            }
            
            let user = FIRUserMock(context: self.context)
            completion?(user, nil)
        }
    }
}
