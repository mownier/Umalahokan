//
//  RemoteDatabaseAccessTests.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 28/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest
@testable import ServiceProvider

class RemoteDatabaseAccessTests: XCTestCase {
    
    func testInitialization() {
        FirebaseHelper.clearApp()
        var access = RemoteDatabaseAccess()
        XCTAssertNil(access)
        
        FirebaseHelper.configureApp()
        access = RemoteDatabaseAccess()
        XCTAssertNotNil(access)
    }
}
