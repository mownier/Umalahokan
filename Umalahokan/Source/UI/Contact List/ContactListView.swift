//
//  ContactListView.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 11/02/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol ContactListViewDelegate: class {
    
    func handleGestureHelperOnPan(_ gesture: UIPanGestureRecognizer)
    func handleGestureHelperOnTap(_ gesture: UITapGestureRecognizer)
}

class ContactListView: UIView {

    weak var delegate: ContactListViewDelegate?
    
    var subviewWidthLayoutRatio: CGFloat = 0.8 // 0-1
    
    var gestureHelperView: UIView!
    var tableView: UITableView!
    var searchTextField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSetup()
    }
    
    override func layoutSubviews() {
        let width: CGFloat = frame.width * subviewWidthLayoutRatio
        var rect = CGRect.zero
        
        if !searchTextField.layer.hasAnimation {
            rect.size.width = width
            rect.size.height = 52
            searchTextField.frame = rect
        }

        if !tableView.layer.hasAnimation {
            rect.origin.y = rect.maxY
            rect.size.width = width
            rect.size.height = frame.height - rect.height
            tableView.frame = rect
        }

        if subviewWidthLayoutRatio < 1 {
            rect.size.width = frame.width - width
            rect.size.height = frame.height
            rect.origin.x = frame.width - rect.width
            rect.origin.y = 0
            gestureHelperView.frame = rect
        }
    }
    
    func initSetup() {
        let theme = UITheme()
        
        tableView = UITableView()
        tableView.backgroundColor = theme.color.gray2
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 52
        
        searchTextField = UITextField()
        searchTextField.backgroundColor = UIColor.white
        searchTextField.leftViewMode = .always
        searchTextField.tintColor = theme.color.gray
        searchTextField.font = theme.font.medium.size(12)
        searchTextField.placeholder = NSLocalizedString("Search", comment: "search")
        searchTextField.keyboardAppearance = .dark
        
        let searchIcon = UIButton()
        searchIcon.setImage(#imageLiteral(resourceName: "button-search"), for: .normal)
        searchIcon.tintColor = searchTextField.tintColor
        searchIcon.frame.size = CGSize(width: 14, height: 14)
        searchIcon.addTarget(searchTextField, action: #selector(UIView.becomeFirstResponder), for: .touchUpInside)
        
        let searchIconContainer = UIView()
        searchIconContainer.frame.size = CGSize(width: 22, height: 14)
        searchIconContainer.addSubview(searchIcon)
        
        searchTextField.leftView = searchIconContainer
        searchTextField.layer.sublayerTransform = CATransform3DMakeTranslation(16, 0, 0)
        
        gestureHelperView = UIView()
        gestureHelperView.backgroundColor = UIColor.clear
        
        let panGesture = UIPanGestureRecognizer()
        panGesture.minimumNumberOfTouches = 1
        panGesture.addTarget(self, action: #selector(self.handlePanGesture(_ :)))
        panGesture.isEnabled = true
        panGesture.cancelsTouchesInView = true
        panGesture.delaysTouchesEnded = true
        panGesture.delaysTouchesBegan = false
        gestureHelperView.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTapsRequired = 1
        tapGesture.addTarget(self, action: #selector(self.handleTapGesture(_ :)))
        gestureHelperView.addGestureRecognizer(tapGesture)
        
        addSubview(tableView)
        addSubview(searchTextField)
        addSubview(gestureHelperView)
    }
    
    func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        delegate?.handleGestureHelperOnPan(gesture)
    }
    
    func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        delegate?.handleGestureHelperOnTap(gesture)
    }
}
