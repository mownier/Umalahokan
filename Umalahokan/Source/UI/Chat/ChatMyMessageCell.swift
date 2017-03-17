//
//  ChatMyMessageCell.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 16/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class ChatMyMessageCell: UICollectionViewCell {
    
    var messageLabel: ChatMessageLabel!
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSetup()
    }
    
    override func layoutSubviews() {
        let spacing = LayoutDimension().spacing
        var rect = CGRect.zero
        
        rect.size.width = (frame.width - spacing * 4) * 0.8 - messageLabel.padding.left - messageLabel.padding.right
        rect.size.height = messageLabel.sizeThatFits(rect.size).height
        rect.size.height += messageLabel.padding.top
        rect.size.height += messageLabel.padding.bottom
        rect.size.width += messageLabel.padding.left
        rect.size.width += messageLabel.padding.right
        rect.origin.x = frame.width - rect.width - spacing
        messageLabel.frame = rect
    }
    
    func initSetup() {
        let theme = UITheme()
        
        messageLabel = ChatMessageLabel()
        messageLabel.backgroundColor = theme.color.green
        messageLabel.layer.borderWidth = 0
        messageLabel.textColor = UIColor.white
        
        addSubview(messageLabel)
    }
}

extension ChatMyMessageCell: CollectionViewReusableProtocol {
    
    typealias Cell = ChatMyMessageCell
}
