//
//  LoginWireframeTest.swift
//  Login
//
//  Created by Mounir Ybanez on 03/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest
import Viper
@testable import Login

class LoginWireframeTest: XCTestCase {
    
    func testInitialization() {
        let loginWireframe = LoginWireframe()
        XCTAssertEqual(loginWireframe.style, .root)
        XCTAssertTrue(loginWireframe.animated)
        XCTAssertNil(loginWireframe.completion)
        XCTAssertNil(loginWireframe.viewController)
    }
}
