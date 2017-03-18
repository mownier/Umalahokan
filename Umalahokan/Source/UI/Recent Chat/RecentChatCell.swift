//
//  RecentChatCell.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 31/01/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class RecentChatCell: UITableViewCell {

    var avatarImageView: UIImageView!
    var moodIndicator: UIView!
    var moodLabel: UILabel!
    var displayNameLabel: UILabel!
    var messageLabel: UILabel!
    var timeLabel: UILabel!
    var strip: UIView!
    var onlineStatusIndicator: UIView!
    
    convenience init() {
        self.init(style: .default, reuseIdentifier: RecentChatCell.reuseId)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSetup()
    }
    
    override func layoutSubviews() {
        let spacing: CGFloat = 8
        var rect = CGRect.zero
        
        rect.size.width = 80
        rect.size.height = rect.width
        avatarImageView.frame = rect
        
        rect.origin.x = rect.maxX
        rect.size.width = 12
        moodIndicator.frame = rect
        
        rect.origin.x = rect.maxX
        rect.size.height = 0.4
        rect.origin.y = frame.height - rect.height
        rect.size.width = frame.width - rect.origin.x
        strip.frame = rect
        
        timeLabel.sizeToFit()
        rect.size = timeLabel.frame.size
        rect.origin.y = spacing * 2
        rect.origin.x = frame.width - rect.width - (spacing * 2)
        timeLabel.frame = rect
        
        moodLabel.sizeToFit()
        rect.size = moodLabel.frame.size
        rect.origin.x = moodIndicator.frame.maxX + (spacing * 2)
        rect.size.width = frame.width - rect.origin.x - timeLabel.frame.width - (spacing * 2)
        moodLabel.frame = rect
        
        displayNameLabel.sizeToFit()
        rect.size.width = min(rect.width - 8 - spacing, displayNameLabel.frame.width)
        rect.size.height = displayNameLabel.frame.height
        rect.origin.y = rect.maxY
        displayNameLabel.frame = rect
        
        rect.origin.x = rect.maxX + spacing
        rect.origin.y += (rect.height - 8) / 2
        rect.size.width = 8
        rect.size.height = rect.width
        onlineStatusIndicator.layer.cornerRadius = rect.width / 2
        onlineStatusIndicator.frame = rect
        
        messageLabel.sizeToFit()
        rect.size.width = moodLabel.frame.width
        rect.size.height = messageLabel.frame.height
        rect.origin.y = displayNameLabel.frame.maxY
        rect.origin.x = moodLabel.frame.origin.x
        messageLabel.frame = rect
    }
    
    private func initSetup() {
        let theme = UITheme()
        
        selectionStyle = .none
        
        avatarImageView = UIImageView()
        avatarImageView.backgroundColor = theme.color.gray5
        
        moodIndicator = UIView()
        moodIndicator.backgroundColor = theme.color.violet3
        
        moodLabel = UILabel()
        moodLabel.font = theme.font.regular.size(10)
        moodLabel.textColor = theme.color.gray4
        
        displayNameLabel = UILabel()
        displayNameLabel.font = theme.font.medium.size(12)
        
        messageLabel = UILabel()
        messageLabel.font = theme.font.regular.size(12)
        moodLabel.textColor = theme.color.gray5
        
        timeLabel = UILabel()
        timeLabel.font = theme.font.regular.size(10)
        timeLabel.textColor = moodLabel.textColor
        
        strip = UIView()
        strip.backgroundColor = theme.color.gray6
        
        onlineStatusIndicator = UIView()
        onlineStatusIndicator.clipsToBounds = true
        onlineStatusIndicator.backgroundColor = theme.color.green
        
        addSubview(avatarImageView)
        addSubview(moodIndicator)
        addSubview(moodLabel)
        addSubview(displayNameLabel)
        addSubview(messageLabel)
        addSubview(timeLabel)
        addSubview(strip)
        addSubview(onlineStatusIndicator)
    }
}

extension RecentChatCell: TableViewReusableProtocol {
    
    typealias Cell = RecentChatCell
}
