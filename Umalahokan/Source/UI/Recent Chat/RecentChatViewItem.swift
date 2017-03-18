//
//  RecentChatViewItem.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 18/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Kingfisher

protocol RecentChatViewItem {

    var isOnline: Bool { get }
    var avatarUrl: URL? { get }
}

protocol RecentChatViewConfiguration {
    
    func configure(_ item: RecentChatViewItem?)
}

extension RecentChatView: RecentChatViewConfiguration {
    
    func configure(_ item: RecentChatViewItem?) {
        guard let item = item else { return }
        
        if let url = item.avatarUrl {
            let resource = ImageResource(downloadURL: url)
            topBar.rightItem.kf.setImage(with: resource, placeholder: #imageLiteral(resourceName: "avatar-placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
            
        } else {
            topBar.rightItem.image = #imageLiteral(resourceName: "avatar-placeholder")
        }
        
        topBar.rightItem.layer.borderWidth = item.isOnline ? 2 : 0
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}
