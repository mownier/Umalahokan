//
//  ChatViewController.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 16/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    var chatView: ChatView!
    
    lazy var otherMessageCellPrototype = ChatOtherMessageCell()
    lazy var myMessageCellPrototype = ChatMyMessageCell()
    lazy var messages: [ChatDisplayData] = generateRandomChatDisplayItems()
    
    override func loadView() {
        let size = UIScreen.main.bounds.size
        
        chatView = ChatView()
        chatView.frame.size = size
        chatView.topBar.delegate = self
        chatView.collectionView.delegate = self
        chatView.collectionView.dataSource = self
        
        ChatOtherMessageCell.register(in: chatView.collectionView)
        ChatMyMessageCell.register(in: chatView.collectionView)
        
        otherMessageCellPrototype.frame.size.width = size.width
        myMessageCellPrototype.frame.size.width = size.width
        
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
        let cell: UICollectionViewCell
        let item = messages[indexPath.row]
        
        if item.isMe {
            let messageCell = ChatMyMessageCell.dequeue(from: collectionView, at: indexPath)
            messageCell.messageLabel.text = item.message
            cell = messageCell
            
        } else {
            let messageCell = ChatOtherMessageCell.dequeue(from: collectionView, at: indexPath)
            messageCell.messageLabel.text = item.message
            cell = messageCell
        }
        
        return cell
    }
}

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = messages[indexPath.row]
        
        if item.isMe {
            myMessageCellPrototype.messageLabel.text = item.message
            myMessageCellPrototype.setNeedsLayout()
            myMessageCellPrototype.layoutIfNeeded()
            let width = collectionView.frame.width
            let height = myMessageCellPrototype.messageLabel.frame.maxY
            return CGSize(width: width, height: height)
            
        } else {
            otherMessageCellPrototype.messageLabel.text = item.message
            otherMessageCellPrototype.setNeedsLayout()
            otherMessageCellPrototype.layoutIfNeeded()
            let width = collectionView.frame.width
            let height = otherMessageCellPrototype.messageLabel.frame.maxY
            return CGSize(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutDimension().spacing
    }
}
