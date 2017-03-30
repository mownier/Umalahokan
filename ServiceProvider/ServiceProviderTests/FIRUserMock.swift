//
//  FIRUserMock.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 30/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Firebase

class FIRUserMock: FIRUser {
    
    private var context: String
    
    var expectedId: String = "userid"
    var accessToken: String?
    var hasError: Bool = false
    
    init(context: String) {
        self.context = context
    }
    
    override var uid: String {
        return expectedId
    }
    
    override func getTokenWithCompletion(_ completion: FIRAuthTokenCallback? = nil) {
        let queue = DispatchQueue(label: context)
        queue.async { [unowned self] in
            guard !self.hasError else {
                let error = NSError(domain: "", code: 1, userInfo: nil)
                completion?(nil, error)
                return
            }
            
            completion?(self.accessToken, nil)
        }
    }
}
