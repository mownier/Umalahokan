//
//  LoginModule.swift
//  Login
//
//  Created by Mounir Ybanez on 05/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Viper
import ServiceProvider

public class LoginModule: Module, Interactable {
    
    public typealias ModulePresenter = LoginPresenter
    public typealias ModuleWireframe = LoginWireframe
    public typealias ModuleScene = LoginScene
    public typealias ModuleInteractor = LoginInteractor
    
    public var presenter: LoginPresenter!
    public var wireframe: LoginWireframe!
    public var scene: LoginScene!
    public var interactor: LoginInteractor!
    
    required public init(scene loginScene: LoginScene) {
        guard let authService = AuthRemoteService() else { return }
        
        interactor = LoginInteractor(authService: authService)!
        wireframe = LoginWireframe()
        presenter = LoginPresenter()
        scene = loginScene
        
        presenter.wireframe = wireframe
        presenter.interactor = interactor
        interactor.output = presenter
        scene.setupArbiter(presenter)
    }
}
