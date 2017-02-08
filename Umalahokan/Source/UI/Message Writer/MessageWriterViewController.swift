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
                        if delta.height == 0 {
                            self.messageWriterView.tableView.contentInset.bottom = 0
                            self.messageWriterView.tableView.scrollIndicatorInsets.bottom = 0
                            
                        } else {
                            self.messageWriterView.tableView.contentInset.bottom -= abs(delta.height)
                            self.messageWriterView.tableView.scrollIndicatorInsets.bottom -= abs(delta.height)
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
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RecipientCell.dequeue(from: tableView)!
        cell.displayNameLabel.text = "Jana Rychla"
        cell.selectionStyle = .none
        return cell
    }
}

extension MessageWriterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension MessageWriterViewController: MessageWriterHeaderDelegate {
    
    func didTapClose() {
        view.perform(#selector(UIView.endEditing), with: true, afterDelay: 0.5)
        dismiss(animated: true, completion: nil)
    }
}
