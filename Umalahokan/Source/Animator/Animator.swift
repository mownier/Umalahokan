//
//  Animator.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 04/02/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol Animator: class {

    var target: Target! { set get }
    var duration: TimeInterval { set get }
    var queue: [Animation] { set get }
    var isPlaying: Bool { set get }
    
    init(target: Target)
    
    func play()
    func setupQueue()
    func completion()
    
    associatedtype Target
}

extension Animator {
    
    func play() {        
        if queue.count == 0 && !isPlaying {
            setupQueue()
        }
        
        isPlaying = true
        
        let anim = queue.removeFirst()
        UIView.animate(
            withDuration: anim.duration,
            animations: anim.executor) { completed in
                if self.queue.count == 0 {
                    self.isPlaying = false
                    self.completion()
                } else {
                    self.play()
                }
        }
    }
}

struct Animation {
    
    var executor: () -> Void
    var duration: TimeInterval
}
