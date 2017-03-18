//
//  ContactListCell.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 11/02/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class ContactListCell: UITableViewCell {

    var avatarImageView: UIImageView!
    var displayNameLabel: UILabel!
    var onlineStatusIndicator: UIView!

    convenience init() {
        self.init(style: .default, reuseIdentifier: RecipientCell.reuseId)
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
        let indicatorDimension: CGFloat = 8
        var rect = CGRect.zero
        
        rect.size.width = 36
        rect.size.height = rect.width
        rect.origin.x = spacing * 2
        rect.origin.y = (frame.height - rect.height) / 2
        avatarImageView.layer.cornerRadius = rect.width / 2
        avatarImageView.frame = rect
        
        displayNameLabel.sizeToFit()
        rect.origin.x = rect.maxX + spacing
        rect.size.width = min(frame.width - rect.origin.x - (spacing * 3) - indicatorDimension, displayNameLabel.frame.width)
        rect.size.height = displayNameLabel.frame.height
        rect.origin.y = (frame.height - rect.height) / 2
        displayNameLabel.frame = rect
        
        rect.size.width = indicatorDimension
        rect.size.height = rect.width
        rect.origin.x = frame.width - rect.width - (spacing * 2)
        rect.origin.y = (frame.height - rect.height) / 2
        onlineStatusIndicator.layer.cornerRadius = rect.width / 2
        onlineStatusIndicator.frame = rect
    }
    
    func initSetup() {
        let theme = UITheme()
        
        selectionStyle = .none
        backgroundColor = UIColor.clear
        
        avatarImageView = UIImageView()
        avatarImageView.backgroundColor = theme.color.gray5
        avatarImageView.clipsToBounds = true
        
        displayNameLabel = UILabel()
        displayNameLabel.font = theme.font.medium.size(12)
        
        onlineStatusIndicator = UIView()
        onlineStatusIndicator.clipsToBounds = true
        onlineStatusIndicator.backgroundColor = theme.color.green
        
        addSubview(avatarImageView)
        addSubview(displayNameLabel)
        addSubview(onlineStatusIndicator)
    }
}

extension ContactListCell: TableViewReusableProtocol {
    
    typealias Cell = ContactListCell
}
