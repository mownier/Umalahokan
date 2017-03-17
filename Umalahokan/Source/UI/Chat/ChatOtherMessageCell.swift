//
//  ChatOtherMessageCell.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 16/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class ChatOtherMessageCell: UICollectionViewCell {
    
    var containerView: UIView!
    var messageLabel: UILabel!
    
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
        let containerViewMaxWidth: CGFloat = (frame.width - (spacing * 2)) * 0.8
        var rect = CGRect.zero
        
        rect.size.width = containerViewMaxWidth - (spacing * 2)
        let messageLabelHeight = messageLabel.sizeThatFits(rect.size).height
        let charSize = messageLabel.font!.lineHeight
        let lineCount = floorf(Float(messageLabelHeight/charSize))
        
        if lineCount <= 0 {
            rect.size = .zero
        
        } else if lineCount == 1 {
            messageLabel.sizeToFit()
            rect.size.width = messageLabel.intrinsicContentSize.width
        }
        rect.size.height = messageLabelHeight
        rect.origin.x = spacing
        rect.origin.y = spacing
        messageLabel.frame = rect
        
        rect.origin.y = spacing * 0.5
        rect.size.width = rect.maxX + spacing
        rect.size.height = rect.maxY + spacing
        containerView.frame = rect
    }
    
    func initSetup() {
        let theme = UITheme()
        
        containerView = UIView()
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = theme.color.gray5.cgColor
        
        messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        messageLabel.text = "Hi! Are you free tonight"
        messageLabel.font = theme.font.regular.size(13)
        messageLabel.lineBreakMode = .byWordWrapping
        
        containerView.addSubview(messageLabel)
        addSubview(containerView)
    }
}

extension ChatOtherMessageCell: CollectionViewReusableProtocol {
    
    typealias Cell = ChatOtherMessageCell
}
