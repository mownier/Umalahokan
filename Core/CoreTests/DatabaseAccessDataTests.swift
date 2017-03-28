//
//  DatabaseAccessDataTests.swift
//  Core
//
//  Created by Mounir Ybanez on 28/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest
@testable import Core

class DatabaseAccessDataTests: XCTestCase {
    
    func testInitialization() {
        let data = DatabaseAccessData()
        XCTAssertNil(data.accessToken)
        XCTAssertNil(data.refreshToken)
    }
}
