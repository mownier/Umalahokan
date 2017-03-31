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

    let queue = DispatchQueue(label: "RemoteDatabaseSourceMock")
    var mockSnapshots = [String: FIRDataSnapshotMock?]()
    var mockSnapshot: FIRDataSnapshotMock?
    
    func get(_ path: String, completion: @escaping (FIRDataSnapshot) -> Void) {
        mockSnapshots[path] = mockSnapshot
        queue.async { [unowned self] in
            let data: FIRDataSnapshotMock
            
            if let snapshot = self.mockSnapshots[path], snapshot != nil {
                data = snapshot!
            
            } else {
                data = FIRDataSnapshotMock()
                data.isExisting = false
            }
            
            completion(data)
        }
    }
    
    func getUserInfo(_ id: String, completion: @escaping (FIRDataSnapshot) -> Void) {
        mockSnapshot = snapshotForUser(id)
        get(UsersResource.singleUser(id).path, completion: completion)
    }
}
