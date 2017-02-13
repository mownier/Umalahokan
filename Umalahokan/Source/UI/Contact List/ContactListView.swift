//
//  ContactListView.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 11/02/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class ContactListView: UIView {

    var tableView: UITableView!
    var searchTextField: UITextField!
    var backgroundView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSetup()
    }
    
    override func layoutSubviews() {
        let width: CGFloat = frame.width * 0.7
        var rect = CGRect.zero
        
        rect.size.width = width
        rect.size.height = 52
        rect.origin.y = frame.height - rect.height
        searchTextField.frame = rect
        
        rect.size.width = width
        rect.size.height = rect.origin.y
        rect.origin.y = 0
        tableView.frame = rect
        
        rect.origin = .zero
        rect.size = frame.size
        backgroundView.frame = rect
    }
    
    func initSetup() {
        tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 233/255, green: 234/255, blue: 243/255, alpha: 1.0)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 52
        
        searchTextField = UITextField()
        searchTextField.backgroundColor = UIColor.white
        searchTextField.leftViewMode = .always
        searchTextField.tintColor = UIColor(red: 133/255, green: 138/255, blue: 154/255, alpha: 1.0)
        searchTextField.font = UIFont(name: "AvenirNext-Medium", size: 12.0)
        searchTextField.placeholder = NSLocalizedString("Search", comment: "search")
        
        let searchIcon = UIImageView()
        searchIcon.image = #imageLiteral(resourceName: "button-search")
        searchIcon.tintColor = searchTextField.tintColor
        searchIcon.frame.size = CGSize(width: 14, height: 14)
        
        let searchIconContainer = UIView()
        searchIconContainer.frame.size = CGSize(width: 22, height: 14)
        searchIconContainer.addSubview(searchIcon)
        
        searchTextField.leftView = searchIconContainer
        searchTextField.layer.sublayerTransform = CATransform3DMakeTranslation(16, 0, 0)
        
        backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 57/255, green: 59/255, blue: 88/255, alpha: 0.7)
        
        
        addSubview(backgroundView)
        addSubview(tableView)
        addSubview(searchTextField)
    }
}
