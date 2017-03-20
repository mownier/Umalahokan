//
//  ChatData.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 17/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol ChatDisplayData {

    var message: String { set get }
    var isMe: Bool { set get }
    var isAnimatable: Bool { set get }
}

struct ChatDisplayDataItem: ChatDisplayData {
    
    var message: String = ""
    var isMe: Bool = false
    var isAnimatable: Bool = true
}

func generateRandomChatDisplayItems() -> [ChatDisplayData] {
    var items = [ChatDisplayData]()
    
    for _ in 0..<(arc4random() % 20 + 20) {
        var item = ChatDisplayDataItem()
        item.isMe = arc4random() % 2 == 0 ? true : false
        
        switch arc4random() % 5 + 1 {
        case 1:
            item.message = "Hello! Are you free tonight?"
            
        case 2:
            item.message = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
            
        case 3:
            item.message = "No, I have an appointment with my boss."
            
        case 4:
            item.message = "Ok, how about tomorrow night?"
            
        default:
            item.message = "The quick brown fox jumps over the lazy dog."
        }
        
        items.append(item)
    }
    
    return items
}
