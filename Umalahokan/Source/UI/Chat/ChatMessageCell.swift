//
//  ChatMessageCell.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 18/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

enum ChatMessageLayoutStyle {
    
    case me
    case other
}

class ChatMessageCell: UICollectionViewCell {

    var messageLabel: ChatMessageLabel!
    var layoutStyle: ChatMessageLayoutStyle = .other
    
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
        
        switch layoutStyle {
        case .me:
            rect.origin.x = frame.width - rect.width - spacing
            
        case .other:
            rect.origin.x = spacing * 2
        }
        
        messageLabel.frame = rect
    }
    
    func initSetup() {
        messageLabel = ChatMessageLabel()
        
        addSubview(messageLabel)
    }
}

extension ChatMessageCell: CollectionViewReusableProtocol {
    
    typealias Cell = ChatMessageCell
}
