//
//  MoodExtension.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 05/05/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

extension Mood {
    
    var text: String {
        switch self {
        case .relaxed  : return "RELAXED"
        case .romantic : return "ROMANTIC"
        case .neutral  : return "NEUTRAL"
        case .curious  : return "CURIOUS"
        case .happy    : return "HAPPY"
        }
    }
    
    var color: UIColor {
        let theme = UITheme()
        switch self {
        case .relaxed  : return theme.color.green
        case .romantic : return theme.color.pink
        case .neutral  : return theme.color.brown
        case .curious  : return theme.color.violet3
        case .happy    : return theme.color.yellow
        }
    }
}
