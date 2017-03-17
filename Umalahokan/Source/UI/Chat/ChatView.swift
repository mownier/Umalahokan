//
//  ChatView.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 16/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class ChatView: UIView {
    
    var topBar: ChatTopBar!
    var collectionView: UICollectionView!
    var flowLayout = UICollectionViewFlowLayout()
    
    convenience init() {
        self.init(frame: .zero)
        initSetup()
    }
    
    override func layoutSubviews() {
        var rect = CGRect.zero
        
        rect.size.width = frame.width
        rect.size.height = topBar.frame.height
        topBar.frame = rect
    
        rect.origin.y = rect.maxY
        rect.size.height = frame.height - rect.height
        collectionView.frame = rect
    }
    
    func initSetup() {
        let spacing = LayoutDimension().spacing
        
        backgroundColor = UIColor.white
        
        topBar = ChatTopBar()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.contentInset.top = spacing
        collectionView.contentInset.bottom = spacing
        
        addSubview(collectionView)
        addSubview(topBar)
    }
}
