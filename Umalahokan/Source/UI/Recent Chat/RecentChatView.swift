//
//  RecentChatView.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 31/01/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class RecentChatView: UIView {

    var topBar: RecentChatTopBar!
    var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSetup()
    }
    
    override func layoutSubviews() {
        var rect = CGRect.zero
        
        rect.size = topBar.frame.size
        rect.size.width = frame.width
        topBar.frame = rect
        
        rect.origin.y = rect.maxY
        rect.size.height = frame.height - rect.height
        tableView.frame = rect
    }
    
    private func initSetup() {
        topBar = RecentChatTopBar()
        tableView = UITableView()
        tableView.tableFooterView = UIView()
        
        addSubview(topBar)
        addSubview(tableView)
    }
}
