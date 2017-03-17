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
    lazy var messages: [String] = {
        var data = [String]()
        for i in 0..<(arc4random() % 20 + 20) {
            switch arc4random() % 5 + 1 {
            case 1:
                data.append("Hello! Are you free tonight?")
                
            case 2:
               data.append("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")
                
            case 3:
                data.append("No, I have an appointment with my boss.")
                
            case 4:
                data.append("Ok, how about tomorrow night?")
                
            default:
                data.append("The quick brown fox jumps over the lazy dog.")
            }
        }
        return data
    }()
    
    override func loadView() {
        let size = UIScreen.main.bounds.size
        
        chatView = ChatView()
        chatView.frame.size = size
        chatView.topBar.delegate = self
        chatView.collectionView.delegate = self
        chatView.collectionView.dataSource = self
        
        ChatOtherMessageCell.register(in: chatView.collectionView)
        
        otherMessageCellPrototype.frame.size.width = size.width
        
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
        let cell = ChatOtherMessageCell.dequeue(from: collectionView, at: indexPath)
        cell.messageLabel.text = messages[indexPath.row]
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        return cell
    }
}

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        otherMessageCellPrototype.messageLabel.text = messages[indexPath.row]
        otherMessageCellPrototype.setNeedsLayout()
        otherMessageCellPrototype.layoutIfNeeded()
        let width = collectionView.frame.width
        let height = otherMessageCellPrototype.containerView.frame.maxY + LayoutDimension().spacing * 0.5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
