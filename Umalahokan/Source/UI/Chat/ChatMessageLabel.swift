//
//  ChatMessageLabel.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 17/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class ChatMessageLabel: UILabel {

    var padding: UIEdgeInsets {
        let spacing = LayoutDimension().spacing * 2
        let insets = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        return insets
    }
    
    convenience init() {
        self.init(frame: .zero)
        initSetup()
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, padding))
    }
    
    func initSetup() {
        let theme = UITheme()
        font = theme.font.medium.size(13)
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        layer.borderWidth = 1
        layer.borderColor = theme.color.gray2.cgColor
    }
}
