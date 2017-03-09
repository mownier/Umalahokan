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
    var isValidToReload: Bool = false
    var isInitiallyReloaded: Bool = false
    var sendView: MessageWriterSendView!
    
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
    
        if !sendView.layer.hasAnimation {
            rect.size.height = 44
            rect.origin.y = frame.height - rect.height
            sendView.frame = rect
        }
    }
    
    private func initSetup() {
        backgroundColor = UIColor.white
        
        header = MessageWriterHeader()
        
        tableView = UITableView()
        tableView.tableFooterView = UIView()
        
        sendView = MessageWriterSendView()
        
        addSubview(header)
        addSubview(tableView)
        addSubview(sendView)
    }
}
