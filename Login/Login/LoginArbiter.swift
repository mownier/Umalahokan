//
//  LoginArbiter.swift
//  Login
//
//  Created by Mounir Ybanez on 03/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Viper
import ServiceProvider

public protocol LoginArbiter: Arbiter {
    
    func login(email: String, password: String)
}

public protocol LoginBuilder: Builder {
    
}

public class LoginModule: Module, Interactable {
    
    public typealias ModulePresenter = LoginPresenter
    public typealias ModuleWireframe = LoginWireframe
    public typealias ModuleScene = LoginScene
    public typealias ModuleInteractor = LoginInteractor
    
    public var presenter: LoginPresenter!
    public var wireframe: LoginWireframe!
    public var scene: LoginScene!
    public var interactor: LoginInteractor!
    
    required public init(scene: LoginScene) {
        self.scene = scene
    }
}

extension LoginModule: LoginBuilder {
    
//    public func build(root: RootWireframe?) {
//        guard let authService = AuthRemoteService() else { return }
//        
//        interactor = LoginInteractor(authService: authService)!
//        wireframe = LoginWireframe()
//        presenter = LoginPresenter()
//        
//    }
}
