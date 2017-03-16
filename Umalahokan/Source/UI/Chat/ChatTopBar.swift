//
//  ChatTopBar.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 16/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol ChatTopBarDelegate: class {
    
    func goBack()
}

class ChatTopBar: UIView {

    weak var delegate: ChatTopBarDelegate?
    
    var backButton: UIButton!
    var moodLabel: UILabel!
    var moodIndicator: UIView!
    var avatarImageView: UIImageView!
    var displayNameLabel: UILabel!
    var onlineStatusIndicator: UIView!
    
    convenience init() {
        var rect = CGRect.zero
        rect.size.height = 59
        self.init(frame: rect)
        initSetup()
    }
    
    override func layoutSubviews() {
        let spacing = LayoutDimension().spacing
        var rect = CGRect.zero
        
        rect.size.width = frame.width
        rect.size.height = 4
        moodIndicator.frame = rect
        
        let frameHeightOffset = frame.height - moodIndicator.frame.height
        
        backButton.sizeToFit()
        rect.size.width = backButton.bounds.width + spacing
        rect.size.height = backButton.bounds.height + spacing
        rect.origin.x = spacing
        rect.origin.y = (frameHeightOffset - rect.height) / 2
        backButton.frame = rect
        
        rect.size.width = 32
        rect.size.height = rect.width
        rect.origin.x = frame.width - spacing - rect.width
        rect.origin.y = (frameHeightOffset - rect.height) / 2
        avatarImageView.frame = rect
        avatarImageView.layer.cornerRadius = rect.width / 2
        
        moodLabel.sizeToFit()
        displayNameLabel.sizeToFit()
        
        let onlineStatusIndicatorDimension: CGFloat = 10
        let totalLabelHeight = moodLabel.bounds.height + displayNameLabel.bounds.height
        let maxLabelWidth = frame.width - backButton.frame.maxX - avatarImageView.frame.width - (frame.width - avatarImageView.frame.maxX) - spacing * 2
        
        rect.origin.x = backButton.frame.maxX + spacing
        rect.origin.y = (frameHeightOffset - totalLabelHeight) / 2
        rect.size.width = maxLabelWidth
        rect.size.height = moodLabel.sizeThatFits(rect.size).height
        moodLabel.frame = rect
        
        rect.origin.y = rect.maxY
        if !onlineStatusIndicator.isHidden {
            let maxOnlineStatusIndicatorWidth = rect.width - (onlineStatusIndicatorDimension + spacing)
            rect.size.width = min(displayNameLabel.bounds.width, maxOnlineStatusIndicatorWidth)
            rect.origin.x = avatarImageView.frame.origin.x - spacing - rect.width
        }
        displayNameLabel.frame = rect
        
        rect.size.width = onlineStatusIndicatorDimension
        rect.size.height = rect.width
        rect.origin.x -= (spacing + rect.width)
        rect.origin.y = (displayNameLabel.frame.maxY - rect.height + displayNameLabel.frame.origin.y) / 2
        onlineStatusIndicator.frame = rect
        onlineStatusIndicator.layer.cornerRadius = rect.width / 2
    }
    
    func initSetup() {
        let theme = UITheme()
        
        backgroundColor = UIColor.white
        
        backButton = UIButton()
        backButton.setImage(#imageLiteral(resourceName: "back-icon"), for: .normal)
        backButton.tintColor = theme.color.gray
        backButton.addTarget(self, action: #selector(self.didTapBack), for: .touchUpInside)
        
        moodLabel = UILabel()
        moodLabel.textColor = theme.color.gray4
        moodLabel.font = theme.font.regular.size(10)
        moodLabel.textAlignment = .right
        moodLabel.text = "RELAXED"
        
        moodIndicator = UIView()
        moodIndicator.backgroundColor = theme.color.green
        
        displayNameLabel = UILabel()
        displayNameLabel.font = theme.font.medium.size(15)
        displayNameLabel.textAlignment = .right
        displayNameLabel.text = "Dominika Feniz"
        
        onlineStatusIndicator = UIView()
        onlineStatusIndicator.layer.masksToBounds = true
        onlineStatusIndicator.backgroundColor = theme.color.green
        
        avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.backgroundColor = theme.color.gray5
        avatarImageView.layer.masksToBounds = true
        
        addSubview(backButton)
        addSubview(moodLabel)
        addSubview(moodIndicator)
        addSubview(displayNameLabel)
        addSubview(onlineStatusIndicator)
        addSubview(avatarImageView)
    }
    
    func didTapBack() {
        delegate?.goBack()
    }
}
