//
//  MessageWriterSendView.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 09/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class MessageWriterSendView: UIView {

    var messageTextField: UITextField!
    var sendButton: UIButton!
    
    convenience init() {
        self.init(frame: .zero)
        initSetup()
    }
    
    override func layoutSubviews() {
        let spacing: CGFloat = 8
        var rect = CGRect.zero
        
        sendButton.sizeToFit()
        rect.size.width = sendButton.bounds.width + spacing
        rect.size.height = sendButton.bounds.height + spacing
        rect.origin.x = frame.width - rect.width - spacing
        rect.origin.y = (frame.height - rect.height) / 2
        sendButton.frame = rect
        
        rect.size.width = rect.origin.x - spacing * 2
        rect.size.height = messageTextField.sizeThatFits(rect.size).height
        rect.origin.x = spacing
        rect.origin.y = (frame.height - rect.height) / 2
        messageTextField.frame = rect
    }

    func initSetup() {
        backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        
        messageTextField = UITextField()
        messageTextField.placeholder = "Your message"
        messageTextField.font = UIFont(name: "AvenirNext-Medium", size: 12.0)
        messageTextField.textColor = UIColor(red: 133/255, green: 138/255, blue: 154/255, alpha: 1.0)
        messageTextField.tintColor = UIColor(red: 133/255, green: 138/255, blue: 154/255, alpha: 1.0)
        messageTextField.keyboardAppearance = .dark
        
        sendButton = UIButton()
        sendButton.setTitle("SEND", for: .normal)
        sendButton.setTitleColor(UIColor(red: 133/255, green: 138/255, blue: 154/255, alpha: 1.0), for: .normal)
        sendButton.titleLabel?.textAlignment = .center
        sendButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 12.0)
        
        addSubview(messageTextField)
        addSubview(sendButton)
    }
}
