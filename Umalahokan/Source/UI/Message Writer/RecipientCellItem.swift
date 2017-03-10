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
}

struct RecipientCellDisplayItem: RecipientCellItem {
    
    var avatarURL: URL?
    var displayNameText: String = ""
    var isOnline: Bool = false
    var isAnimatable: Bool = true
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
