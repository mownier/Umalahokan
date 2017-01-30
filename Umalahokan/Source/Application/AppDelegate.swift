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
        nav.navigationBar.barTintColor = UIColor(red: 57/255, green: 59/255, blue: 88/255, alpha: 1.0)
        nav.navigationBar.barStyle = .black
        nav.navigationBar.tintColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true
    }
}

