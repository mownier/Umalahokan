//
//  FIRUserMock.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 27/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Firebase

class FIRUserMock: FIRUser {
    
    var context: String?
    
    init(context: String?) {
        self.context = context
    }
    
    override var refreshToken: String? {
        return "refreshToken123456789"
    }
    
    override func getTokenWithCompletion(_ completion: FIRAuthTokenCallback? = nil) {
        completion?("accessToken123456789", nil)
    }
}
