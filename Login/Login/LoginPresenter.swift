//
//  LoginPresenter.swift
//  Login
//
//  Created by Mounir Ybanez on 03/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Viper
import Core

public class LoginPresenter: Presenter, Interactable {

    public typealias ModuleScene = LoginScene
    public typealias ModuleWireframe = Wireframe
    public typealias ModuleInteractor = LoginInteractorInput
    
    weak public var scene: LoginScene!
    public var wireframe: Wireframe!
    public var interactor: LoginInteractorInput!
    
    weak var arbiter: LoginArbiter!
    weak var interactorOutput: LoginInteractorOutput!
    
    init() {
        scene = nil
        wireframe = nil
        interactor = nil
    }
}

extension LoginPresenter: LoginArbiter {
    
    public func exit() {
        wireframe.exit()
    }
    
    public func login(email: String, password: String) {
        scene.isShowingLoadView = true
        interactor.login(email: email, password: password)
    }
}

extension LoginPresenter: LoginInteractorOutput {
    
    public func didLogin(error: AuthServiceError?) {
        scene.isShowingLoadView = false
        
        guard let error = error else { return }
        
        let message: String
        
        switch error {
        case .wrongPassword: message = "Password not correct"
        case .invalidEmail : message = "Email format not valid"
        case .userNotFound : message = "User not yet registered"
        default            : message = "Something went wrong while signing in"
        }
        
        scene.showLoginError(message: message)
    }
}
