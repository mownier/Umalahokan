//
//  MessageWriterViewController.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 01/02/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class MessageWriterViewController: UIViewController {

    var messageWriterView: MessageWriterView!
    var keyboardObserver: Any?
    var keyboardHandler = KeyboardHandler()
    var isDismissing: Bool = false
    
    lazy var recipients: [RecipientCellDisplayItem] = {
        return RecipientCellDisplayItem.generateRandomDisplayItems()
    }()
    
    override func loadView() {
        var rect = CGRect.zero
        rect.size = UIScreen.main.bounds.size
        
        messageWriterView = MessageWriterView(frame: rect)
        messageWriterView.header.delegate = self
        messageWriterView.tableView.delegate = self
        messageWriterView.tableView.dataSource = self
        messageWriterView.tableView.rowHeight = 52
        messageWriterView.tableView.separatorStyle = .none

        RecipientCell.register(in: messageWriterView.tableView)
        
        messageWriterView.setNeedsLayout()
        messageWriterView.layoutIfNeeded()
        
        view = messageWriterView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        removeKeyboardObserver()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension MessageWriterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageWriterView.isValidToReload ? recipients.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RecipientCell.dequeue(from: tableView)!
        let recipient = recipients[indexPath.row]
        cell.configure(recipient)
        return cell
    }
}

extension MessageWriterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let recipientCell = cell as? RecipientCell else { return }
        
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        let indexPaths = tableView.indexPathsForVisibleRows?.sorted(by: { indexPath1, indexPath2 -> Bool in
            return isDismissing ? indexPath1.row > indexPath2.row : indexPath1.row < indexPath2.row
        })
        let relativeIndex = indexPaths?.index(where: { visibleRowIndexpath -> Bool in
            return indexPath == visibleRowIndexpath
        }) ?? 0
        
        let delay: TimeInterval = 0.25 + (Double(relativeIndex) / 50.0)
        let duration: TimeInterval = 0.5

        if isDismissing {
            recipientCell.animation2(duration, delay: delay)
            
        } else {
            var recipient = recipients[indexPath.row]
            
            guard recipient.isAnimatable else { return }
            
            recipientCell.animation1(duration, delay: delay)
                        
            recipient.isAnimatable = false
            recipients[indexPath.row] = recipient
        }
    }
}

extension MessageWriterViewController: MessageWriterHeaderDelegate {
    
    func didTapClose() {
        isDismissing = true
        messageWriterView.tableView.backgroundColor = UIColor.clear
        messageWriterView.tableView.reloadData()
        
        view.perform(#selector(UIView.endEditing), with: true, afterDelay: 0.0)
        dismiss(animated: true, completion: nil)
    }
}

extension MessageWriterViewController: KeyboardObserverProtocol {
    
    func willHandleKeyboardNotification(with notif: Notification) {
        willHandle(userInfo: notif.userInfo, view: messageWriterView.sendView, scrollView: messageWriterView.tableView)
    }
}
