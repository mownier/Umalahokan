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
    
    func testLogin() {
        let service = AuthServiceMock()
        let interactor = LoginInteractor(authService: service)!
        let presenter = LoginPresenter()
        let scene = LoginSceneMock()
        scene.presenter = presenter
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.scene = scene
        presenter.login(email: "me@me.com", password: "abcde12345qwert")
        XCTAssertFalse(scene.isShowingLoadView)
        XCTAssertNil(scene.errorMessage)
    }
}
