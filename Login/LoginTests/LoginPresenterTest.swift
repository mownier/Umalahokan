//
//  LoginPresenterTest.swift
//  Login
//
//  Created by Mounir Ybanez on 03/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest
import Viper
@testable import Login

class LoginPresenterTest: XCTestCase {
    
    func testInitialization() {
        let presenter = LoginPresenter()
        XCTAssertNil(presenter.scene)
        XCTAssertNil(presenter.wireframe)
        XCTAssertNil(presenter.interactor)
    }
    
    func testLoginHasSucceeded() {
        let service = AuthServiceMock()
        let interactor = LoginInteractor(authService: service)!
        let presenter = LoginPresenter()
        let scene = LoginSceneMock()
        scene.presenter = presenter
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.scene = scene
        service.beforeExecution = { () -> Void in
            XCTAssertTrue(scene.isShowingLoadView)
        }
        service.afterExecution = { () -> Void in
            XCTAssertFalse(scene.isShowingLoadView)
            XCTAssertNil(scene.errorMessage)
        }
        presenter.login(email: "me@me.com", password: "abcde12345qwert")
    }
    
    func testLoginHasFailed() {
        let service = AuthServiceMock()
        let interactor = LoginInteractor(authService: service)!
        let presenter = LoginPresenter()
        let scene = LoginSceneMock()
        scene.presenter = presenter
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.scene = scene
        service.beforeExecution = { () -> Void in
            XCTAssertTrue(scene.isShowingLoadView)
        }
        service.afterExecution = { () -> Void in
            XCTAssertFalse(scene.isShowingLoadView)
            XCTAssertNotNil(scene.errorMessage)
            XCTAssertFalse(scene.errorMessage!.isEmpty)
        }
        presenter.login(email: "me@me.com", password: "12345")
    }
}
