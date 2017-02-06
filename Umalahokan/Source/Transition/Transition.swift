//
//  Transition.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 04/02/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol Transition: class {

    var duration: TimeInterval { set get }
}

struct Animation {
    
    var executor: () -> Void
    var duration: TimeInterval
    var delay: TimeInterval = 0
    var options: UIViewAnimationOptions = [.curveEaseInOut]
    
    init(duration: TimeInterval, executor: @escaping () -> Void) {
        self.duration = duration
        self.executor = executor
    }
}
