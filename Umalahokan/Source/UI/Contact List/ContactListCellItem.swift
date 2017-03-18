//
//  ContactListCellItem.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 18/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Kingfisher

protocol ContactListCellItem {

    var isOnline: Bool { get }
    var displayNameText: String { get }
    var avatarUrl: URL? { get }
}

protocol ContactListCellConfiguration {
    
    func configure(_ item: ContactListCellItem?)
}

extension ContactListCell: ContactListCellConfiguration {
    
    func configure(_ item: ContactListCellItem?) {
        guard let item = item else { return }
        
        if let url = item.avatarUrl {
            let resource = ImageResource(downloadURL: url)
            avatarImageView.kf.setImage(with: resource, placeholder: #imageLiteral(resourceName: "avatar-placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
        
        } else {
            avatarImageView.image = #imageLiteral(resourceName: "avatar-placeholder")
        }
        
        displayNameLabel.text = item.displayNameText
        onlineStatusIndicator.isHidden = !item.isOnline
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}

extension ContactListDisplayDataItem: ContactListCellItem { }
