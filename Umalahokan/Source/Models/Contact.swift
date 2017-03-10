//
//  Contact.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 10/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

struct Contact {
    
    var avatar: String = ""
    var name: String = ""
    var isOnline: Bool = false
    var isAnimatable: Bool = false
    
    static func generateRandomList() -> [Contact] {
        var list = [Contact]()
        let count = arc4random() % 10 + 10
        for _ in 0..<count {
            var contact = Contact()
            contact.name = "Merriam Webster"
            contact.isOnline = arc4random() % 2 == 0 ? true : false
            list.append(contact)
        }
        return list
    }
}

