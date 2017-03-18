//
//  ChatViewController.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 16/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    lazy var messageCellPrototype = ChatMessageCell()
    lazy var messages: [ChatDisplayData] = generateRandomChatDisplayItems()
    
    var chatView: ChatView!
    var item: ChatViewItem?
    
    override func loadView() {
        let size = UIScreen.main.bounds.size
        
        chatView = ChatView()
        chatView.frame.size = size
        chatView.configure(item)
        chatView.topBar.delegate = self
        chatView.collectionView.delegate = self
        chatView.collectionView.dataSource = self
        
        ChatMessageCell.register(in: chatView.collectionView)
        
        messageCellPrototype.frame.size.width = size.width
        
        view = chatView
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension ChatViewController: ChatTopBarDelegate {
    
    func goBack() {
        dismiss(animated: true, completion: nil)
    }
}

extension ChatViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ChatMessageCell.dequeue(from: collectionView, at: indexPath)
        let item = messages[indexPath.row] as? ChatMessageCellItem
        cell.configure(item)
        return cell
    }
}

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = messages[indexPath.row] as? ChatMessageCellItem
        messageCellPrototype.configure(item)
        
        let width = collectionView.frame.width
        let height = messageCellPrototype.messageLabel.frame.maxY
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutDimension().spacing
    }
}
