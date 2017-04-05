//
//  LoginViewController.swift
//  UserInterface
//
//  Created by Mounir Ybanez on 05/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit
import Viper
import Login

public class LoginViewController: UIViewController  {

    public var isShowingLoadView: Bool = false
    
    fileprivate(set) public var presenter: LoginArbiter!
    private(set) public var emailTextField: UITextField!
    private(set) public var passwordTextField: UITextField!
    private(set) public var loginButton: UIButton!
    
    public override func loadView() {
        let loginView = UIView(frame: UIScreen.main.bounds)
        
        emailTextField = UITextField()
        passwordTextField = UITextField()
        loginButton = UIButton()
        
        loginView.addSubview(emailTextField)
        loginView.addSubview(passwordTextField)
        loginView.addSubview(loginButton)
        
        view = loginView
    }
    
    public override func viewDidLayoutSubviews() {
        
    }
}

extension LoginViewController: LoginScene {

    public func setupArbiter<T : Arbiter>(_ arbiter: T) {
        presenter = arbiter as! LoginArbiter
    }
    
    public func showLoginError(message: String) {
        
    }
}
