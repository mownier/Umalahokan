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
    
    func testLoginHasCustomErrorMessageOfWrongPasswordResult() {
        let service = AuthServiceMock()
        let interactor = LoginInteractor(authService: service)!
        let presenter = LoginPresenter()
        let scene = LoginSceneMock()
        scene.presenter = presenter
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.scene = scene
        service.expectedError = .wrongPassword
        service.beforeExecution = { () -> Void in
            XCTAssertTrue(scene.isShowingLoadView)
        }
        service.afterExecution = { () -> Void in
            XCTAssertFalse(scene.isShowingLoadView)
            XCTAssertNotNil(scene.errorMessage)
            XCTAssertFalse(scene.errorMessage!.isEmpty)
            XCTAssertEqual(scene.errorMessage, "Password not correct")
        }
        presenter.login(email: "me@me.com", password: "12345")
    }
    
    func testLoginHasCustomErrorMessageOfInvalidEmailResult() {
        let service = AuthServiceMock()
        let interactor = LoginInteractor(authService: service)!
        let presenter = LoginPresenter()
        let scene = LoginSceneMock()
        scene.presenter = presenter
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.scene = scene
        service.expectedError = .invalidEmail
        service.beforeExecution = { () -> Void in
            XCTAssertTrue(scene.isShowingLoadView)
        }
        service.afterExecution = { () -> Void in
            XCTAssertFalse(scene.isShowingLoadView)
            XCTAssertNotNil(scene.errorMessage)
            XCTAssertFalse(scene.errorMessage!.isEmpty)
            XCTAssertEqual(scene.errorMessage, "Email format not valid")
        }
        presenter.login(email: "me@me.com", password: "12345")
    }
    
    func testLoginHasCustomErrorMessageOfUserNotFoundResult() {
        let service = AuthServiceMock()
        let interactor = LoginInteractor(authService: service)!
        let presenter = LoginPresenter()
        let scene = LoginSceneMock()
        scene.presenter = presenter
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.scene = scene
        service.expectedError = .userNotFound
        service.beforeExecution = { () -> Void in
            XCTAssertTrue(scene.isShowingLoadView)
        }
        service.afterExecution = { () -> Void in
            XCTAssertFalse(scene.isShowingLoadView)
            XCTAssertNotNil(scene.errorMessage)
            XCTAssertFalse(scene.errorMessage!.isEmpty)
            XCTAssertEqual(scene.errorMessage, "User not yet registered")
        }
        presenter.login(email: "me@me.com", password: "12345")
    }
    
    func testLoginHasCustomErrorMessageOfOtherTypeOfAuthServiceError() {
        let service = AuthServiceMock()
        let interactor = LoginInteractor(authService: service)!
        let presenter = LoginPresenter()
        let scene = LoginSceneMock()
        scene.presenter = presenter
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.scene = scene
        
        service.expectedError = .unknown
        service.beforeExecution = { () -> Void in
            XCTAssertTrue(scene.isShowingLoadView)
        }
        service.afterExecution = { () -> Void in
            XCTAssertFalse(scene.isShowingLoadView)
            XCTAssertNotNil(scene.errorMessage)
            XCTAssertFalse(scene.errorMessage!.isEmpty)
            XCTAssertEqual(scene.errorMessage, "Something went wrong while signing in")
        }
        presenter.login(email: "me@me.com", password: "12345")
        
        service.expectedError = .noUserInfo
        service.beforeExecution = { () -> Void in
            XCTAssertTrue(scene.isShowingLoadView)
        }
        service.afterExecution = { () -> Void in
            XCTAssertFalse(scene.isShowingLoadView)
            XCTAssertNotNil(scene.errorMessage)
            XCTAssertFalse(scene.errorMessage!.isEmpty)
            XCTAssertEqual(scene.errorMessage, "Something went wrong while signing in")
        }
        presenter.login(email: "me@me.com", password: "12345")
        
        service.expectedError = .userIdUndefined
        service.beforeExecution = { () -> Void in
            XCTAssertTrue(scene.isShowingLoadView)
        }
        service.afterExecution = { () -> Void in
            XCTAssertFalse(scene.isShowingLoadView)
            XCTAssertNotNil(scene.errorMessage)
            XCTAssertFalse(scene.errorMessage!.isEmpty)
            XCTAssertEqual(scene.errorMessage, "Something went wrong while signing in")
        }
        presenter.login(email: "me@me.com", password: "12345")
        
        service.expectedError = .multipleUserInfo
        service.beforeExecution = { () -> Void in
            XCTAssertTrue(scene.isShowingLoadView)
        }
        service.afterExecution = { () -> Void in
            XCTAssertFalse(scene.isShowingLoadView)
            XCTAssertNotNil(scene.errorMessage)
            XCTAssertFalse(scene.errorMessage!.isEmpty)
            XCTAssertEqual(scene.errorMessage, "Something went wrong while signing in")
        }
        presenter.login(email: "me@me.com", password: "12345")
    }
}
