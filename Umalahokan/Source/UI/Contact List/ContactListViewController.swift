//
//  ContactListViewController.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 11/02/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController {

    var contactListView: ContactListView!
    
    override func loadView() {
        let size = UIScreen.main.bounds.size
        
        contactListView = ContactListView()
        contactListView.frame.size = size
        contactListView.tableView.dataSource = self
        contactListView.delegate = self
        
        ContactListCell.register(in: contactListView.tableView)
        
        view = contactListView
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func didTapToDismiss() {
        dismiss(animated: true, completion: nil)
    }
}

extension ContactListViewController: ContactListViewDelegate {
    
    func didTapHelperView() {
        didTapToDismiss()
    }
}

extension ContactListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ContactListCell.dequeue(from: tableView)!
        cell.displayNameLabel.text = "Tereza Mala"
        cell.onlineStatusIndicator.isHidden = arc4random() % 2 == 0 ? false : true
        return cell
    }
}
