//
//  FIRDataSnapshotExtension.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 27/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Firebase

public extension FIRDataSnapshot {
    
    public func getValue<T>(_ key: String) -> T? {
        guard hasChild(key), let child = childSnapshot(forPath: key).value as? T else {
            return nil
        }
        
        return child
    }
}
