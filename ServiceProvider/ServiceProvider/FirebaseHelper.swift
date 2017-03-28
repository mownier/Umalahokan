//
//  FirebaseHelper.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 25/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Core
import Firebase

class FirebaseHelper {
    
    class func configureApp() {
        if FIRApp.defaultApp() == nil {
            FIRApp.configure()
        }
    }
    
    class func clearApp() {
        guard let app = FIRApp.defaultApp() else { return }
        
        app.delete { _ in }
    }
    
    class func createAuth() -> FIRAuth? {
        guard let app = FIRApp.defaultApp() else { return nil }
        
        return FIRAuth(app: app)
    }
}
