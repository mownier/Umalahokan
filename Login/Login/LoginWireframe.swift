//
//  LoginWireframe.swift
//  Login
//
//  Created by Mounir Ybanez on 03/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Viper

public class LoginWireframe: Wireframe {

    weak public var viewController: UIViewController?
    
    public var root: RootWireframe?
    public var style: WireframeStyle
    public var completion: (() -> Void)?
    public var animated: Bool
    
    init() {
        viewController = nil
        root = nil
        style = .root
        completion = nil
        animated = true
    }
}

extension LoginWireframe: Rootable { }
