//
//  LoginInteractor.swift
//  Login
//
//  Created by Mounir Ybanez on 01/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Viper
import Core

public protocol LoginInteractorInput: InteractorInput {
    
    func login(email: String, password: String)
}

public protocol LoginInteractorOutput: InteractorOutput {
    
    func didLogin(error: AuthServiceError?)
}

public class LoginInteractor: Interactor {

    public typealias Output = LoginInteractorOutput
    
    var authService: AuthService
    
    public weak var output: Output?
    
    public init?(authService: AuthService?) {
        guard authService != nil else { return nil }
        
        self.authService = authService!
    }
}

extension LoginInteractor: LoginInteractorInput {
    
    public func login(email: String, password: String) {
        authService.login(email: email, password: password) { [unowned self] result in
            switch result {
            case .fail(let error): self.output?.didLogin(error: error)
            case .success: self.output?.didLogin(error: nil)
            }
        }
    }
}
