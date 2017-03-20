//
//  SendView.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 20/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol SendViewDelegate: class {
    
    func send(_ view: SendView)
}

class SendView: UIView {

    weak var delegate: SendViewDelegate?
    
    var messageTextField: UITextField!
    var sendButton: UIButton!
    
    convenience init() {
        var rect = CGRect.zero
        rect.size.height = 52
        self.init(frame: rect)
        initSetup()
    }
    
    override func layoutSubviews() {
        let spacing: CGFloat = 8
        var rect = CGRect.zero
        
        rect.size.width = 36
        rect.size.height = rect.width
        rect.origin.x = frame.width - rect.width - spacing
        rect.origin.y = (frame.height - rect.height) / 2
        sendButton.frame = rect
        sendButton.layer.cornerRadius = rect.width / 2
        
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
        sendButton.addTarget(self, action: #selector(self.didTapSend), for: .touchUpInside)
        sendButton.setImage(#imageLiteral(resourceName: "airplane-icon"), for: .normal)
        sendButton.tintColor = UIColor.white
        sendButton.backgroundColor = theme.color.violet2
        sendButton.layer.masksToBounds = true
        sendButton.imageEdgeInsets = UIEdgeInsetsMake(2, 0, 0, 2)
        
        addSubview(messageTextField)
        addSubview(sendButton)
    }
    
    func didTapSend() {
        delegate?.send(self)
    }
}
