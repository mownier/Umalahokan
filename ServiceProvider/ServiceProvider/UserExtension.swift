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
        
        id = data.getValue("id", exceptions) ?? ""
        userName = data.getValue("user_name", exceptions) ?? ""
        firstName = data.getValue("first_name", exceptions) ?? ""
        lastName = data.getValue("last_name", exceptions) ?? ""
    }
}
