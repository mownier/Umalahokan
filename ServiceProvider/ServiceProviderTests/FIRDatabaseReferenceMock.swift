//
//  FIRDatabaseReferenceMock.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 29/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import ServiceProvider
import Firebase

class FIRDatabaseReferenceMock: FIRDatabaseReference {
    
    let queue = DispatchQueue(label: "FIRDatabaseReferenceMock")
    
    var id: String = ""
    var identifiers = ["abcde12345qwert"]
    var mockSnapshot = FIRDataSnapshotMock()
    
    override func child(_ path: String) -> FIRDatabaseReference {
        switch path {
        case UsersResource.allUsers.path:
            mockSnapshot.isExisting = true
            
        default:
            mockSnapshot.isExisting = false
        }
        
        if identifiers.contains(id) {
            switch path {
            case UsersResource.singleUser(id).path:
                mockSnapshot.isExisting = true
            
            default:
                mockSnapshot.isExisting = false
            }
        }
        return self
    }
    
    override func observeSingleEvent(of eventType: FIRDataEventType, with block: @escaping (FIRDataSnapshot) -> Void) {
        queue.async { [unowned self] in
            switch eventType {
            case .value:
                block(self.mockSnapshot)
            default:
                break
            }
        }
    }
}
