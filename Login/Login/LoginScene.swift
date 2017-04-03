//
//  LoginScene.swift
//  Login
//
//  Created by Mounir Ybanez on 03/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Viper

public protocol LoginScene: Scene {

    func showLoginError(message: String)
}
