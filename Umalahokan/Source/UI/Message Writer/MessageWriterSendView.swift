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
        let theme = UITheme()
        
        backgroundColor = theme.color.gray3
        
        messageTextField = UITextField()
        messageTextField.placeholder = "Your message"
        messageTextField.font = theme.font.medium.size(12)
        messageTextField.textColor = theme.color.gray
        messageTextField.tintColor = theme.color.gray
        messageTextField.keyboardAppearance = .dark
        
        sendButton = UIButton()
        sendButton.setTitle("SEND", for: .normal)
        sendButton.setTitleColor(theme.color.gray, for: .normal)
        sendButton.titleLabel?.textAlignment = .center
        sendButton.titleLabel?.font = theme.font.bold.size(12)
        
        addSubview(messageTextField)
        addSubview(sendButton)
    }
}
