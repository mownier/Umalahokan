//
//  ChatViewItem.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 18/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Kingfisher

protocol ChatViewItem {

    var isOnline: Bool { get }
    var moodText: String { get }
    var moodColor: UIColor? { get }
    var avatarUrl: URL? { get }
    var displayNameText: String { get }
}

protocol ChatViewConfiguration {
    
    func configure(_ item: ChatViewItem?, isPrototype: Bool)
}

extension ChatView: ChatViewConfiguration {
    
    func configure(_ item: ChatViewItem?, isPrototype: Bool = false) {
        guard let item = item else { return }
        
        if !isPrototype {
            if let url = item.avatarUrl {
                let resource = ImageResource(downloadURL: url)
                topBar.avatarImageView.kf.setImage(with: resource)
            
            } else {
                topBar.avatarImageView.image = nil
            }
        }
        
        topBar.displayNameLabel.text = item.displayNameText
        topBar.moodLabel.text = item.moodText
        topBar.moodIndicator.backgroundColor = item.moodColor
        topBar.onlineStatusIndicator.isHidden = !item.isOnline
        
        topBar.setNeedsLayout()
        topBar.layoutIfNeeded()
    }
}

extension RecentChatDisplayDataItem: ChatViewItem { }
