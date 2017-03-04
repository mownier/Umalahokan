//
//  RecentChatViewController.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 30/01/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class RecentChatViewController: UIViewController {
    
    let contactListTransitioning = ContactListTransitioning()
    let messageWriterTransitioning = MessageWriterTransitioning()
    
    var recentChatView: RecentChatView!
    
    override func loadView() {
        var rect = CGRect.zero
        rect.size = UIScreen.main.bounds.size
        recentChatView = RecentChatView(frame: rect)
        recentChatView.delegate = self
        recentChatView.topBar.delegate = self
        recentChatView.tableView.dataSource = self
        recentChatView.tableView.rowHeight = 80
        recentChatView.tableView.separatorStyle = .none
        
        RecentChatCell.register(in: recentChatView.tableView)
        
        view = recentChatView
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension RecentChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RecentChatCell.dequeue(from: tableView)!
        cell.moodLabel.text = "RELAXED"
        cell.displayNameLabel.text = "Dominika Faniz"
        cell.messageLabel.text = "Hey there. How is it going?"
        cell.timeLabel.text = "now"
        cell.selectionStyle = .none
        return cell
    }
}

extension RecentChatViewController: RecentChatTopBarDelegate {
    
    func didTapRight() {
    }
    
    func didTapLeft() {
        let vc = ContactListViewController()
        vc.transitioningDelegate = contactListTransitioning
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }
}

extension RecentChatViewController: RecentChatViewDelegate {
    
    func didTapComposer() {
        let vc = MessageWriterViewController()
        messageWriterTransitioning.composerButtonFrame = recentChatView.composerButton.frame
        vc.transitioningDelegate = messageWriterTransitioning
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }
}

extension RecentChatViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        recentChatView.composerButton.isHidden = true
        
        let transition = MessageWriterPresentation()
        transition.startingFrame = recentChatView.composerButton.frame
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = MessageWriterDismissal()
        transition.endingFrame = recentChatView.composerButton.frame
        transition.completion = { [unowned self] in
            self.recentChatView.composerButton.isHidden = false
        }
        
        return transition
    }
}
