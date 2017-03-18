//
//  ContactListDisplayData.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 18/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol ContactListDisplayData {

    var isOnline: Bool { set get }
    var displayNameText: String { set get }
    var avatarUrl: URL? { set get }
}

struct ContactListDisplayDataItem: ContactListDisplayData {
    
    var isOnline: Bool = false
    var displayNameText: String = ""
    var avatarUrl: URL?
}

func generateRandomContactListDisplayItems() -> [ContactListDisplayData] {
    var items = [ContactListDisplayData]()
    for _ in 0..<(arc4random() % 20 + 20) {
        var item = ContactListDisplayDataItem()
        item.displayNameText = "Tereza Mala"
        item.isOnline = arc4random() % 2 == 0 ? true : false
        items.append(item)
    }
    return items
}
