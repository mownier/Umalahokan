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
        
        view = messageWriterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageWriterView.header.inputTextField.becomeFirstResponder()
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
