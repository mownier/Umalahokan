//
//  FIRDatabaseReferenceMock.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 29/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Firebase
import ServiceProvider

class FIRDatabaseReferenceMock: FIRDatabaseReference {
    
    var id: String = ""
    var identifiers = ["abcde12345qwert"]
    var mockSnapshot = FIRDataSnaphostMock()
    
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
        let queue = DispatchQueue(label: "Observe single event")
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
