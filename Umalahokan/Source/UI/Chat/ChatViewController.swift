//
//  ChatViewController.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 16/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    var chatView: ChatView!

    
    override func loadView() {
        let size = UIScreen.main.bounds.size
        
        chatView = ChatView()
        chatView.frame.size = size
        chatView.topBar.delegate = self
        
        view = chatView
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension ChatViewController: ChatTopBarDelegate {
    
    func goBack() {
        dismiss(animated: true, completion: nil)
    }
}
