//
//  ChatMessageCellItem.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 18/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol ChatMessageCellItem {

    var messageText: String { get }
    var layoutStyle: ChatMessageLayoutStyle { get }
}

protocol ChatMessageCellConfiguration {
    
    func configure(_ item: ChatMessageCellItem?, meBackgroundColor: UIColor?)
}

extension ChatMessageCell: ChatMessageCellConfiguration {
    
    func configure(_ item: ChatMessageCellItem?, meBackgroundColor: UIColor? = nil) {
        guard let item = item else { return }
        
        messageLabel.text = item.messageText
        layoutStyle = item.layoutStyle
        
        let backgroundColor: UIColor?
        let textColor: UIColor
        let borderWidth: CGFloat
        
        switch layoutStyle {
        case .me:
            backgroundColor = meBackgroundColor
            textColor = UIColor.white
            borderWidth = 0
        
        case .other:
            backgroundColor = UIColor.white
            textColor = UIColor.black
            borderWidth = 1
        }
        
        messageLabel.backgroundColor = backgroundColor
        messageLabel.textColor = textColor
        messageLabel.layer.borderWidth = borderWidth

        setNeedsLayout()
        layoutIfNeeded()
    }
}

extension ChatDisplayDataItem: ChatMessageCellItem {
    
    var messageText: String {
        return message
    }
    
    var layoutStyle: ChatMessageLayoutStyle {
        let style: ChatMessageLayoutStyle = isMe ? .me : .other
        return style
    }
}
