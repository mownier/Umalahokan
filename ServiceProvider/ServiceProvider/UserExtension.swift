//
//  UserExtension.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 27/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Core
import Firebase

public protocol DataSnapshotParser {
    
    mutating func parse(data: FIRDataSnapshot, exceptions: String...)
}

extension User: DataSnapshotParser {
    
    public mutating func parse(data: FIRDataSnapshot, exceptions: String...) {
        guard data.exists() else { return  }
        
        if !exceptions.contains("id") {
            id = data.getValue("id") ?? ""
        }
        
        if !exceptions.contains("user_name") {
            userName = data.getValue("user_name") ?? ""
        }
        
        if !exceptions.contains("first_name") {
            firstName = data.getValue("first_name") ?? ""
        }
        
        if !exceptions.contains("last_name") {
            lastName = data.getValue("last_name") ?? ""
        }
    }
}
