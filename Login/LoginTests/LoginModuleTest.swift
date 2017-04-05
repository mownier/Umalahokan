//
//  LoginModuleTest.swift
//  Login
//
//  Created by Mounir Ybanez on 05/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest
import ServiceProvider
@testable import Login

class LoginModuleTest: XCTestCase {
    
    func testInitialization() {
        let scene = LoginSceneMock()
        
        FirebaseHelper.clearApp()
        var module = LoginModule(scene: scene)
        XCTAssertNil(module.scene)
        XCTAssertNil(module.interactor)
        XCTAssertNil(module.presenter)
        XCTAssertNil(module.wireframe)
    
        FirebaseHelper.configureApp()
        module = LoginModule(scene: scene)
        XCTAssertNotNil(module.scene)
        XCTAssertNotNil(module.interactor)
        XCTAssertNotNil(module.presenter)
        XCTAssertNotNil(module.wireframe)
    }
}
