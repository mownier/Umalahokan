//
//  FIRDataSnapshotMock.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 29/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Firebase

class FIRDataSnaphostMock: FIRDataSnapshot {
    
    var isExisting: Bool = true
    
    override func exists() -> Bool {
        return isExisting
    }
}
