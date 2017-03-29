//
//  RemoteDatabaseSourceMock.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 29/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import ServiceProvider
import Firebase

class RemoteDatabaseSourceMock: RemoteDatabaseSourceProtocol {

    func get(_ path: String, completion: @escaping (FIRDataSnapshot) -> Void) {
        let queue = DispatchQueue(label: "RemoteDatabaseSourceMock")
        queue.async {
            let snapshot = FIRDataSnaphostMock()
            
            switch path {
            case UsersResource.allUsers.path:
                snapshot.isExisting = true
                
            default:
                snapshot.isExisting = false
            }
            completion(snapshot)
        }
    }
}
