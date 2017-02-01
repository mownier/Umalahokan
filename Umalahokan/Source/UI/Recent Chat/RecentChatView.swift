//
//  RecentChatView.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 31/01/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol RecentChatViewDelegate: class {
    
    func didTapComposer()
}

class RecentChatView: UIView {

    weak var delegate: RecentChatViewDelegate?
    
    var topBar: RecentChatTopBar!
    var tableView: UITableView!
    var composerButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSetup()
    }
    
    override func layoutSubviews() {
        let spacing: CGFloat = 8
        var rect = CGRect.zero
        
        rect.size = topBar.frame.size
        rect.size.width = frame.width
        topBar.frame = rect
        
        rect.origin.y = rect.maxY
        rect.size.height = frame.height - rect.height
        tableView.frame = rect
    
        rect.size.width = 56
        rect.size.height = rect.width
        rect.origin.x = frame.width - rect.width - (spacing * 2)
        rect.origin.y = frame.height - rect.height - (spacing * 2)
        composerButton.layer.cornerRadius = rect.width / 2
        composerButton.frame = rect
    }
    
    private func initSetup() {
        topBar = RecentChatTopBar()
        
        tableView = UITableView()
        tableView.tableFooterView = UIView()
        
        composerButton = UIButton()
        composerButton.tintColor = UIColor.white
        composerButton.clipsToBounds = true
        composerButton.setImage(#imageLiteral(resourceName: "button-composer"), for: .normal)
        composerButton.backgroundColor = UIColor(
            red: 142/255,
            green: 135/255,
            blue: 251/255,
            alpha: 1.0
        )
        composerButton.imageEdgeInsets.left = 4
        composerButton.imageEdgeInsets.bottom = 4
        composerButton.layer.shadowColor = UIColor.black.cgColor
        composerButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        composerButton.layer.shadowRadius = 2
        composerButton.layer.shadowOpacity = 0.5
        composerButton.layer.masksToBounds = false
        composerButton.addTarget(self, action: #selector(self.didTapComposer), for: .touchUpInside)
        
        addSubview(topBar)
        addSubview(tableView)
        addSubview(composerButton)
    }
    
    func didTapComposer() {
        delegate?.didTapComposer()
    }
}
