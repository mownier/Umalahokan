//
//  LoginViewControllerTest.swift
//  UserInterface
//
//  Created by Mounir Ybanez on 05/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest
@testable import UserInterface

class LoginViewControllerTest: XCTestCase {
    
    func testInitiliazation() {
        let controller = LoginViewController()
        XCTAssertNil(controller.presenter)
        XCTAssertFalse(controller.isShowingLoadView)
        XCTAssertNil(controller.emailTextField)
        XCTAssertNil(controller.passwordTextField)
        XCTAssertNil(controller.loginButton)
    }
    
    func testLoadView() {
        let controller = LoginViewController()
        controller.loadView()
        XCTAssertEqual(controller.view.frame.size, UIScreen.main.bounds.size)
        XCTAssertNotNil(controller.emailTextField)
        XCTAssertNotNil(controller.passwordTextField)
        XCTAssertNotNil(controller.loginButton)
        XCTAssertTrue(controller.view.subviews.contains(controller.emailTextField))
        XCTAssertTrue(controller.view.subviews.contains(controller.passwordTextField))
        XCTAssertTrue(controller.view.subviews.contains(controller.loginButton))
    }
    
    func testViewDidLayoutSubviews() {
        let controller = LoginViewController()
        controller.loadView()
        
    }
}
