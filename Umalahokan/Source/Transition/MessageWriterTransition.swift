//
//  MessageWriterTransition.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 04/02/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class MessageWriterTransition: Transition {

    typealias Target = MessageWriterView
    
    var target: Target!
    var duration: TimeInterval = 2
    var queue = [Animation]()
    var isPlaying = false
    
    required init(target: Target) {
        self.target = target
    }
    
    func completion() {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
            self.target.removeFromSuperview()
        }
    }
    
    func setupQueue() {
        var anim = Animation(duration: 0.5, executor: animatePosition)
        queue.append(anim)
        
        anim.executor = animateCornerRadius
        anim.duration = 0.5
        queue.append(anim)
        
        anim.executor = animateFrame
        anim.duration = 0.5
        queue.append(anim)
    }
    
    func animatePosition() {
        target.frame.origin.x = target.superview == nil ? 0 : target.superview!.frame.width
        target.frame.origin.x -= target.frame.width
        target.frame.origin.x /= 2
        target.frame.origin.y = 0
    }
    
    func animateCornerRadius() {
        let anim = CABasicAnimation(keyPath: "cornerRadius")
        anim.fromValue = target.layer.cornerRadius
        anim.toValue = 0
        anim.duration = 1
        anim.isRemovedOnCompletion = true
        target.layer.add(anim, forKey: nil)
        target.layer.cornerRadius = 0
    }
    
    func animateFrame() {
        target.header.closeButton.isHidden = false
        target.header.titleLabel.isHidden = false
        
        target.frame.size.width = target.superview == nil ? target.frame.width : target.superview!.frame.width
        target.frame.size.height = target.superview == nil ? target.frame.height : target.superview!.frame.height
        target.frame.origin.x = 0
    }
}
