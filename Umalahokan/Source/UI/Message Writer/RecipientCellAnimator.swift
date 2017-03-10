//
//  RecipientCellAnimator.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 10/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol RecipientCellAnimator {

    func animation1(_ duration: TimeInterval, delay: TimeInterval)
    func animation2(_ duration: TimeInterval, delay: TimeInterval)
}

extension RecipientCell: RecipientCellAnimator {
    
    func animation1(_ duration: TimeInterval, delay: TimeInterval) {
        let from: CGAffineTransform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        let to: CGAffineTransform = CGAffineTransform.identity
        
        strip.isHidden = true
        avatarImageView.transform = from
        displayNameLabel.transform = from
        onlineStatusIndicator.transform = from
        
        UIView.animate(withDuration: duration, delay: delay, animations: {
            self.avatarImageView.transform = to
            self.displayNameLabel.transform = to
            self.onlineStatusIndicator.transform = to
        }) { _ in
            self.strip.isHidden = false
        }
    }
    
    func animation2(_ duration: TimeInterval, delay: TimeInterval) {
        let from: CGAffineTransform = .identity
        let to: CGAffineTransform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        
        strip.isHidden = true
        avatarImageView.transform = from
        displayNameLabel.transform = from
        onlineStatusIndicator.transform = from
        
        UIView.animate(withDuration: duration, delay: delay, animations: {
            self.avatarImageView.transform = to
            self.displayNameLabel.transform = to
            self.onlineStatusIndicator.transform = to
        }) { _ in
            self.isHidden = true
        }
    }
}
