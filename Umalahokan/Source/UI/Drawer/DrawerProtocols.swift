//
//  DrawerContainerProtocols.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 04/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol DrawerContainerHamburger: class {

    var isMenuEnabled: Bool { get }
    
    func showMenu()
    func enableMenu(_ enable: Bool)
}

protocol DrawerContainerContentProtocol: class {
    
    var drawerContentViewController: UIViewController { get }
    var hamburger: DrawerContainerHamburger? { set get }
    var drawerContentId: String { get }
}

protocol DrawerContainerContentHandlerProtocol: class {
    
    func handleContentWithType<T>(_ type: T, viewController: DrawerContainerController)
}

protocol DrawerMenuProtocol: class {
    
    var drawerMenuInteractiveTransition: DrawerMenuInteractiveTransition? { set get }
    var drawerMenuViewController: UIViewController { get }
}
