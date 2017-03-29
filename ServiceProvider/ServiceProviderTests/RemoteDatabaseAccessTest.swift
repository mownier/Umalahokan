//
//  RemoteDatabaseAccessTest.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 28/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest
@testable import ServiceProvider

class RemoteDatabaseAccessTest: XCTestCase {
    
    func testInitialization() {
        FirebaseHelper.clearApp()
        var auth = FirebaseHelper.createAuth()
        var access = RemoteDatabaseAccess(firebaseAuth: auth)
        XCTAssertNil(access)
        
        FirebaseHelper.configureApp()
        auth = FirebaseHelper.createAuth()
        access = RemoteDatabaseAccess(firebaseAuth: auth)
        XCTAssertNotNil(access)
    }
}
