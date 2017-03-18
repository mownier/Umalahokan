//
//  RecentChatDisplayData.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 18/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol RecentChatDisplayData {

    var avatarUrl: URL? { set get }
    var displayNameText: String { set get }
    var moodText: String { set get }
    var moodColor: UIColor? { set get }
    var isOnline: Bool { set get }
    var timeText: String { set get }
    var recentMessageText: String { set get }
}

struct RecentChatDisplayDataItem: RecentChatDisplayData {
    
    var avatarUrl: URL?
    var displayNameText: String = ""
    var moodText: String = ""
    var moodColor: UIColor?
    var isOnline: Bool = true
    var timeText: String = ""
    var recentMessageText: String = "'"
}

func genereRecentChatRandomDisplayItems() -> [RecentChatDisplayData] {
    let theme = UITheme()
    var items = [RecentChatDisplayData]()
    for _ in 0..<(arc4random() % 20 + 20) {
        var item = RecentChatDisplayDataItem()
        item.displayNameText = "Dominika Faniz"
        item.timeText = "now"
        item.recentMessageText = "Hey there. How is it going?"
        item.moodText = "ROMANTIC"
        item.moodColor = theme.color.pink
        items.append(item)
    }
    return items
}
