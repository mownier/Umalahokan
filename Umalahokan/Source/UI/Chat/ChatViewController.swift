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
    var keyboardObserver: Any?
    var isCellDisplayAnimationEnabled: Bool = false
    var isReloadedOnAppear: Bool = false
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        reloadCollectionView()
        
        if !isReloadedOnAppear {
            reloadCollectionView(true)
            isReloadedOnAppear = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObserver()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func reloadCollectionView(_ animated: Bool = false) {
        if animated {
            chatView.collectionView.performBatchUpdates({ [unowned self] in
                self.chatView.collectionView.reloadData()
                
            }, completion: { _ in
                let indexPath = IndexPath(item: self.messages.count - 1, section: 0)
                self.chatView.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .bottom)
                self.isCellDisplayAnimationEnabled = true
                self.chatView.collectionView.reloadData()
            })
            
        } else {
            chatView.collectionView.reloadData()
        }
    }
}

extension ChatViewController: ChatTopBarDelegate {
    
    func goBack() {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
}

extension ChatViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ChatMessageCell.dequeue(from: collectionView, at: indexPath)
        let messageItem = messages[indexPath.row] as? ChatMessageCellItem
        cell.configure(messageItem, meBackgroundColor: item?.moodColor)
        return cell
    }
}

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        var item = messages[indexPath.item]
        guard let cell = cell as? ChatMessageCell, item.isAnimatable else { return }
        
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        let toX: CGFloat = cell.messageLabel.frame.origin.x
        let toAlpha: CGFloat = 1
        let fromX: CGFloat
        let fromAlpha: CGFloat = 0
        
        switch cell.layoutStyle {
        case .me    : fromX = cell.frame.width
        case .other : fromX = -cell.messageLabel.frame.width
        }
        
        cell.messageLabel.frame.origin.x = fromX
        cell.messageLabel.alpha = fromAlpha
        
        guard isCellDisplayAnimationEnabled else { return }
        
        item.isAnimatable = false
        messages[indexPath.item] = item
        
        let relativePoint = cell.convert(cell.messageLabel.frame.origin, to: nil)
        let relativeIndex = (1.0 - abs(relativePoint.y/view.frame.height)) * 0.1
        
        let delay: TimeInterval = Double(relativeIndex)
        let duration: TimeInterval = 0.5
        
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
            cell.messageLabel.frame.origin.x = toX
            cell.messageLabel.alpha = toAlpha
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = messages[indexPath.row] as? ChatMessageCellItem
        messageCellPrototype.configure(item)
        
        let width = collectionView.frame.width
        let height = messageCellPrototype.messageLabel.frame.maxY
        
        return CGSize(width: width, height: height)
    }
}

extension ChatViewController: KeyboardObserverProtocol {
    
    func willHandleKeyboardNotification(with notif: Notification) {
        willHandle(
            userInfo: notif.userInfo,
            view: chatView.sendView,
            scrollView: chatView.collectionView,
            isContentOffsetIncluded: true
        )
    }
}
