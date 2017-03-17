//
//  ReusableProtocol.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 16/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol TableViewReusableProtocol: class {

    static var reuseId: String { get }
    
    static func register(in tableView: UITableView)
    static func dequeue(from tableView: UITableView) -> Cell
    
    associatedtype Cell
}

extension TableViewReusableProtocol {
    
    static var reuseId: String {
        return "\(self)"
    }
    
    static func register(in tableView: UITableView) {
        tableView.register(self, forCellReuseIdentifier: self.reuseId)
    }
    
    static func dequeue(from tableView: UITableView) -> Cell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseId)
        return cell as! Cell
    }
}

protocol CollectionViewReusableProtocol: class {
    
    static var reuseId: String { get }
    
    static func register(in collectionView: UICollectionView)
    static func dequeue(from collectionView: UICollectionView, at indexPath: IndexPath) -> Cell
    
    associatedtype Cell
}

extension CollectionViewReusableProtocol {
    
    static var reuseId: String {
        return "\(self)"
    }
    
    static func register(in collectionView: UICollectionView) {
        collectionView.register(self, forCellWithReuseIdentifier: self.reuseId)
    }
    
    static func dequeue(from collectionView: UICollectionView, at indexPath: IndexPath) -> Cell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseId, for: indexPath)
        return cell as! Cell
    }
}
