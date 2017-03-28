//
//  DatabaseProtocol.swift
//  Core
//
//  Created by Mounir Ybanez on 28/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

public protocol DatabaseProtocol {

    func fetchUsers(ids: [String], completion: (([User]) -> Void)?)
}
