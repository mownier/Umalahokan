//
//  CALayerExtension.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 10/02/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import QuartzCore

extension CALayer {
    
    var hasAnimation: Bool {
        guard let keys = animationKeys(), keys.count > 0 else {
            return false
        }
        
        return true
    }
}
