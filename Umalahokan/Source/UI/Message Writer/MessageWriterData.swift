//
//  MessageWriterData.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 10/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

protocol MessageWriterData {

    var avatar: String { get }
    var name: String { get }
    var isOnline: Bool { get }
}

struct MessageWriterDataItem: MessageWriterData {
    
    var avatar: String = ""
    var name: String = ""
    var isOnline: Bool = false
}

extension RecipientCellDisplayItem {
    
    init(data: MessageWriterData) {
        self.init()
        avatarURL = URL(string: data.avatar)
        displayNameText = data.name
        isOnline = data.isOnline
        isAnimatable = true
    }
    
    static func generateRandomDisplayItems() -> [RecipientCellDisplayItem] {
        var displayItems = [RecipientCellDisplayItem]()
        let count = arc4random() % 10 + 10
        for _ in 0..<count {
            var data = MessageWriterDataItem()
            data.name = "Merriam Webster"
            data.isOnline = arc4random() % 2 == 0 ? true : false

            let displayItem = RecipientCellDisplayItem(data: data)
            displayItems.append(displayItem)
        }
        return displayItems
    }
}
