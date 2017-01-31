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
        window?.rootViewController = RecentChatViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

