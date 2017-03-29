//
//  RemoteDatabaseSource.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 28/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Firebase

public protocol RemoteDatabaseSourceProtocol {
    
    func get(_ path: String, completion: @escaping (FIRDataSnapshot) -> Void)
}

public class RemoteDatabaseSource: RemoteDatabaseSourceProtocol {
    
    private var ref: FIRDatabaseReference
    
    public required init?(reference: FIRDatabaseReference?) {
        guard reference != nil else { return nil }
        
        ref = reference!
    }
    
    public func get(_ path: String, completion: @escaping (FIRDataSnapshot) -> Void) {
        ref.child(path).observeSingleEvent(of: .value, with: completion)
    }
}
