//
//  RecentChatViewController.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 30/01/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class RecentChatViewController: UIViewController {
    
    var recentChatView: RecentChatView!
    
    override func loadView() {
        var rect = CGRect.zero
        rect.size = UIScreen.main.bounds.size
        recentChatView = RecentChatView(frame: rect)
        recentChatView.topBar.delegate = self
        
        view = recentChatView
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension RecentChatViewController: RecentChatTopBarDelegate {
    
    func didTapRight() {
        print("right")
    }
    
    func didTapLeft() {
        print("left")
    }
}
