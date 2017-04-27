//
//  LoginModuleTest.swift
//  UserInterface
//
//  Created by Mounir Ybanez on 27/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest
import Login
import ServiceProvider
@testable import UserInterface

class LoginModuleTest: XCTestCase {
    
    func testInitialization() {
        FirebaseHelper.configureApp()
        let module = LoginModule()
        XCTAssertTrue(module.scene is LoginViewController)
        
        let vc = module.scene as! LoginViewController
        XCTAssertNotNil(vc.presenter)
        XCTAssertTrue(vc.presenter is LoginPresenter)
        
        let presenter: LoginPresenter! = vc.presenter as! LoginPresenter!
        XCTAssertTrue(module.presenter === presenter)
    }
}
