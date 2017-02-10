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
    var keyboardObserver: NSObjectProtocol?
    var keyboardHandler = KeyboardHandler()
    var isDismissing: Bool = false
    
    struct Contact {
        
        var name: String = ""
        var isOnline: Bool = false
        var isAnimatable: Bool = false
    }
    
    lazy var contacts: [Contact] = {
        var data = [Contact]()
        for _ in 0..<20 {
            var contact = Contact()
            contact.name = "Jana Rychla"
            contact.isAnimatable = true
            contact.isOnline = arc4random() % 2 == 0 ? false : true
            data.append(contact)
        }
        return data
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
        
        keyboardObserver = NotificationCenter.default.addObserver(
            forName: Notification.Name.UIKeyboardWillChangeFrame,
            object: nil,
            queue: nil,
            using: {  [unowned self] notif in
                self.keyboardHandler.willMoveUsedView = false
                self.keyboardHandler.info = notif.userInfo
                self.keyboardHandler.handle(using: self.messageWriterView.tableView, with: { delta in
                    switch delta.direction {
                    case .up:
                        if delta.height == 0 {
                            self.messageWriterView.tableView.contentInset.bottom = abs(delta.y)
                            self.messageWriterView.tableView.scrollIndicatorInsets.bottom = abs(delta.y)
                            
                        } else {
                            self.messageWriterView.tableView.contentInset.bottom += abs(delta.height)
                            self.messageWriterView.tableView.scrollIndicatorInsets.bottom += abs(delta.height)
                        }
                        
                    case .down:
                        UIView.performWithoutAnimation {
                            if delta.height == 0 {
                                self.messageWriterView.tableView.contentInset.bottom = 0
                                self.messageWriterView.tableView.scrollIndicatorInsets.bottom = 0
                                
                            } else {
                                self.messageWriterView.tableView.contentInset.bottom -= abs(delta.height)
                                self.messageWriterView.tableView.scrollIndicatorInsets.bottom -= abs(delta.height)
                            }
                        }

                    default:
                        break
                    }
                })
            })
        
        messageWriterView.header.inputTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.removeObserver(keyboardObserver)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension MessageWriterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageWriterView.isValidToReload ? contacts.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RecipientCell.dequeue(from: tableView)!
        let contact = contacts[indexPath.row]
        cell.displayNameLabel.text = contact.name
        cell.onlineStatusIndicator.isHidden = !contact.isOnline
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        return cell
    }
}

extension MessageWriterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let recipientCell = cell as? RecipientCell else { return }
        
        let indexPaths = tableView.indexPathsForVisibleRows?.sorted(by: { indexPath1, indexPath2 -> Bool in
            return isDismissing ? indexPath1.row > indexPath2.row : indexPath1.row < indexPath2.row
        })
        let relativeIndex = indexPaths?.index(where: { visibleRowIndexpath -> Bool in
            return indexPath == visibleRowIndexpath
        }) ?? 0
        
        let delay: TimeInterval = 0.25 + (Double(relativeIndex) / 50.0)
        let duration: TimeInterval = 0.5

        if isDismissing {
            let from: CGAffineTransform = .identity
            let to: CGAffineTransform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            
            recipientCell.strip.transform = from
            recipientCell.avatarImageView.transform = from
            recipientCell.displayNameLabel.transform = from
            recipientCell.onlineStatusIndicator.transform = from

            UIView.animate(withDuration: duration, delay: delay, animations: {
                recipientCell.strip.transform = to
                recipientCell.avatarImageView.transform = to
                recipientCell.displayNameLabel.transform = to
                recipientCell.onlineStatusIndicator.transform = to
            }) { _ in
                recipientCell.isHidden = true
            }
            
        } else {
            var contact = contacts[indexPath.row]
            
            guard contact.isAnimatable else { return }
            
            let from: CGAffineTransform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            let to: CGAffineTransform = CGAffineTransform.identity
            
            recipientCell.avatarImageView.transform = from
            recipientCell.displayNameLabel.transform = from
            recipientCell.onlineStatusIndicator.transform = from
            recipientCell.strip.transform = from
            
            UIView.animate(withDuration: duration, delay: delay, animations: {
                recipientCell.avatarImageView.transform = to
                recipientCell.displayNameLabel.transform = to
                recipientCell.onlineStatusIndicator.transform = to
                recipientCell.strip.transform = to
            }) { _ in }
            
            contact.isAnimatable = false
            contacts[indexPath.row] = contact
        }
    }
}

extension MessageWriterViewController: MessageWriterHeaderDelegate {
    
    func didTapClose() {
        isDismissing = true
        messageWriterView.tableView.backgroundColor = UIColor.clear
        messageWriterView.tableView.reloadData()
        
        view.perform(#selector(UIView.endEditing), with: true, afterDelay: 0.5)
        dismiss(animated: true, completion: nil)
    }
}
