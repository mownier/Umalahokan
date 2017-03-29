//
//  RemoteDatabaseTest.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 28/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest
@testable import ServiceProvider

class RemoteDatabaseTest: XCTestCase {
    
    func testInitialization() {
        FirebaseHelper.clearApp()
        var ref = FirebaseHelper.createReference()
        var source = RemoteDatabaseSource(reference: ref)
        var database = RemoteDatabase(source: source)
        XCTAssertNil(database)
        
        FirebaseHelper.configureApp()
        ref = FirebaseHelper.createReference()
        source = RemoteDatabaseSource(reference: ref)
        database = RemoteDatabase(source: source)
        XCTAssertNotNil(database)
    }
}
