//
//  FIRDataSnapshotExtensionTest.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 01/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest
@testable import ServiceProvider

class FIRDataSnapshotExtensionTest: XCTestCase {
    
    func testGetValue() {
        let mock = FIRDataSnapshotMock()
        mock.childDictionary = ["id": "me12345", "price": 120.23, "info": [1:123.45]]
        
        let id: String? = mock.getValue("id")
        XCTAssertNotNil(id)
        XCTAssertEqual(id, "me12345")
        
        let price: Double? = mock.getValue("price")
        XCTAssertNotNil(price)
        XCTAssertEqual(price, 120.23)
        
        let info: [Int: Double]? = mock.getValue("info")
        XCTAssertNotNil(info)
        XCTAssertEqual(info!, [1:123.45])
        
        let nonExisting: Int? = mock.getValue("non_existing")
        XCTAssertNil(nonExisting)
    }
}
