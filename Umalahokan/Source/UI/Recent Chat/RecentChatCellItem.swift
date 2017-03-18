//
//  RecentChatCellItem.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 18/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Kingfisher

protocol RecentChatCellItem {
    
    var avatarUrl: URL? { get }
    var displayNameText: String { get }
    var moodText: String { get }
    var moodColor: UIColor? { get }
    var isOnline: Bool { get }
    var timeText: String { get }
    var recentMessageText: String { get }
}

protocol RecentChatChellConfiguration {
    
    func configure(_ item: RecentChatCellItem?, isPrototype: Bool)
}

extension RecentChatCell: RecentChatChellConfiguration {
    
    func configure(_ item: RecentChatCellItem?, isPrototype: Bool = false) {
        guard let item = item else { return }
        
        if !isPrototype {
            if let url = item.avatarUrl {
                let resource = ImageResource(downloadURL: url)
                avatarImageView.kf.setImage(with: resource)
                avatarImageView.kf.setImage(with: resource, placeholder: #imageLiteral(resourceName: "avatar-placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
            
            } else {
                avatarImageView.image = #imageLiteral(resourceName: "avatar-placeholder")
            }
        }
        
        avatarImageView.backgroundColor = UITheme().color.gray5
        displayNameLabel.text = item.displayNameText
        moodLabel.text = item.moodText
        moodIndicator.backgroundColor = item.moodColor
        onlineStatusIndicator.isHidden = !item.isOnline
        timeLabel.text = item.timeText
        messageLabel.text = item.recentMessageText
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}

extension RecentChatDisplayDataItem: RecentChatCellItem { }
