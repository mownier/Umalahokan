//
//  MessageWriterView.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 01/02/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class MessageWriterView: UIView {

    var header: MessageWriterHeader!
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
        
        rect.size.width = frame.width
        rect.size.height = header.frame.height
        header.frame = rect
        
        rect.origin.y = rect.maxY
        rect.size.height = frame.height - rect.height
        tableView.frame = rect
    }
    
    private func initSetup() {
        backgroundColor = UIColor.white
        
        header = MessageWriterHeader()
        
        tableView = UITableView()
        tableView.tableFooterView = UIView()
        
        addSubview(header)
        addSubview(tableView)
    }
}
