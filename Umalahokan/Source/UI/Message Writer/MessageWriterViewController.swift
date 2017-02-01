//
//  MessageWriterViewController.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 01/02/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class MessageWriterViewController: UIViewController {

    var messageWriterView: MessageWriterView!
    
    override func loadView() {
        var rect = CGRect.zero
        rect.size = UIScreen.main.bounds.size
        messageWriterView = MessageWriterView(frame: rect)
        messageWriterView.header.delegate = self
        

        
        view = messageWriterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension MessageWriterViewController: MessageWriterHeaderDelegate {
    
    func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
}
