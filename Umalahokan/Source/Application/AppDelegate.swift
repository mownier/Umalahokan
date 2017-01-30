//
//  AppDelegate.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 30/01/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let recentChat = RecentChatViewController()
        let nav = UINavigationController(rootViewController: recentChat)
        nav.navigationBar.isTranslucent = false
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true
    }
}

