//
//  UmalahokanDrawerController.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 04/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class UmalahokanDrawerController: DrawerContainerController {
    
    let drawerMenuTransitionDelegate = ContactListTransitionAnimator()
    
    convenience init() {
        let contactList = ContactListViewController()
        let _ = contactList.view
        self.init(drawerMenu: contactList)
        
        // Removed this if business logic is already determined
        struct Item: RecentChatViewItem {
            
            var isOnline: Bool = true
            var avatarUrl: URL?
        }
        
        let recentChat = RecentChatViewController()
        recentChat.item = Item()
        changeContentUsing(recentChat)
        
        drawerMenuTransitionDelegate.view = contactList.contactListView
        drawerMenuTransitioning.delegate = drawerMenuTransitionDelegate
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
