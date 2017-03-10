//
//  ContactListViewController.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 11/02/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController {

    weak var drawerMenuInteractiveTransition: DrawerMenuInteractiveTransition?
    
    var contactListView: ContactListView!
    var keyboardObserver: Any?
    
    override func loadView() {
        let size = UIScreen.main.bounds.size
        
        contactListView = ContactListView()
        contactListView.frame.size = size
        contactListView.tableView.dataSource = self
        contactListView.delegate = self
        
        ContactListCell.register(in: contactListView.tableView)
        
        view = contactListView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        removeKeyboardObserver()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func didTapToDismiss() {
        dismiss(animated: true, completion: nil)
    }
}

extension ContactListViewController: ContactListViewDelegate {
    
    func handleGestureHelperOnPan(_ gesture: UIPanGestureRecognizer) {
        guard let interactiveTransition = drawerMenuInteractiveTransition else { return }
        
        let translation = gesture.translation(in: view)
        let progress = interactiveTransition.computeProgress(translation, viewBounds: view.bounds, direction: .left)
        interactiveTransition.updateUsing(gesture.state, progress: progress) {
            [unowned self] in
            self.didTapToDismiss()
        }
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

extension ContactListViewController: DrawerMenuProtocol {
    
    var drawerMenuViewController: UIViewController {
        return self
    }
}

extension ContactListViewController: KeyboardObserverProtocol {
    
    func willHandleKeyboardNotification(with notif: Notification) {
        willHandle(userInfo: notif.userInfo, view: contactListView.searchTextField, scrollView: contactListView.tableView, offsetOnUp: 0)
    }
}
