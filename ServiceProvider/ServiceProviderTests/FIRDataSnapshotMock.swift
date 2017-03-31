//
//  FIRDataSnapshotMock.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 29/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Firebase

class FIRDataSnapshotMock: FIRDataSnapshot {
    
    var isExisting: Bool = true
    var childDictionary = [String: Any]()
    var childKey: String = ""
    
    override func exists() -> Bool {
        return isExisting
    }
    
    override func hasChildren() -> Bool {
        return childDictionary.count > 0
    }
    
    override func childSnapshot(forPath childPathString: String) -> FIRDataSnapshot {
        childKey = childPathString
        return self
    }
    
    override var value: Any? {
        return childDictionary[childKey]
    }
}
