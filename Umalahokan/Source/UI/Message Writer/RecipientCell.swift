//
//  RecipientCell.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 01/02/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class RecipientCell: UITableViewCell {

    var avatarImageView: UIImageView!
    var displayNameLabel: UILabel!
    var onlineStatusIndicator: UIView!
    var strip: UIView!
    
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
        
        if !avatarImageView.layer.hasAnimation {
            rect.size.width = 36
            rect.size.height = rect.width
            rect.origin.x = spacing * 2
            rect.origin.y = (frame.height - rect.height) / 2
            avatarImageView.layer.cornerRadius = rect.width / 2
            avatarImageView.frame = rect
        }

        if !displayNameLabel.layer.hasAnimation {
            displayNameLabel.sizeToFit()
            rect.origin.x = rect.maxX + spacing
            rect.size.width = min(frame.width - rect.origin.x - (spacing * 3) - indicatorDimension, displayNameLabel.frame.width)
            rect.size.height = displayNameLabel.frame.height
            rect.origin.y = (frame.height - rect.height) / 2
            displayNameLabel.frame = rect
        }
        
        if !onlineStatusIndicator.layer.hasAnimation {
            rect.origin.x = rect.maxX + spacing
            rect.origin.y += (rect.height - indicatorDimension) / 2
            rect.size.width = indicatorDimension
            rect.size.height = rect.width
            onlineStatusIndicator.layer.cornerRadius = rect.width / 2
            onlineStatusIndicator.frame = rect
        }
        
        if !strip.layer.hasAnimation {
            rect.origin.x = 0
            rect.size.height = 0.4
            rect.origin.y = frame.height - rect.height
            rect.size.width = frame.width
            strip.frame = rect
        }
    }
    
    private func initSetup() {
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
        
        strip = UIView()
        strip.backgroundColor = theme.color.gray6
        
        addSubview(avatarImageView)
        addSubview(displayNameLabel)
        addSubview(onlineStatusIndicator)
        addSubview(strip)
    }
}

extension RecipientCell {
    
    static var reuseId: String {
        return "RecipientCell"
    }
    
    class func register(in tableView: UITableView) {
        tableView.register(self, forCellReuseIdentifier: self.reuseId)
    }
    
    class func dequeue(from tableView: UITableView) -> RecipientCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseId)
        return cell as? RecipientCell
    }
}
