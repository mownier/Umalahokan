//
//  LoginWireframeMock.swift
//  Login
//
//  Created by Mounir Ybanez on 04/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Viper

class LoginWireframeMock: Wireframe {
    
    weak var viewController: UIViewController?
    
    var root: RootWireframe?
    var style: WireframeStyle
    var completion: (() -> Void)?
    var animated: Bool
    var isExited: Bool
    
    public init() {
        viewController = nil
        root = nil
        style = .root
        completion = nil
        animated = true
        isExited = false
    }
    
    func exit() {
        isExited = true
    }
}
