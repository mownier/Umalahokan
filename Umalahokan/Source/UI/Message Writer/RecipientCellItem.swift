//
//  RecipientCellItem.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 10/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Kingfisher

protocol RecipientCellItem {

    var avatarURL: URL? { get }
    var displayNameText: String { get }
    var isOnline: Bool { get }
    var isAnimatable: Bool { set get }
}

protocol RecipientCellConfiguration {
    
    func configure(_ item: RecipientCellItem?, isPrototype: Bool)
}

extension RecipientCell: RecipientCellConfiguration {
    
    func configure(_ item: RecipientCellItem?, isPrototype: Bool = false) {
        guard let item = item else { return }
        
        if !isPrototype {
            if item.avatarURL != nil {
                let resource = ImageResource(downloadURL: item.avatarURL!)
                avatarImageView.kf.setImage(with: resource)
                
            } else {
                avatarImageView.image = nil
            }
        }

        displayNameLabel.text = item.displayNameText
        onlineStatusIndicator.isHidden = !item.isOnline
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}

extension Contact: RecipientCellItem {
    
    var avatarURL: URL? {
        return URL(string: avatar)
    }
    
    var displayNameText: String {
        return name
    }
}
