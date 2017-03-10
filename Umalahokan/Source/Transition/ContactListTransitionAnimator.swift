//
//  ContactListTransitionAnimator.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 04/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class ContactListTransitionAnimator: DrawerMenuTransitionDelegate {
    
    weak var view: ContactListView?
    
    private(set) var toX: CGFloat!
    private(set) var toBackgroundColor: UIColor!
    
    func dismissalPreAnimation(transition: DrawerMenuTransition) {
        guard let view = view else { return }
        
        toX = -max(view.tableView.frame.width, view.searchTextField.frame.width)
        toBackgroundColor = toBackgroundColor.withAlphaComponent(0.0)
    }
    
    func dismissalAnimation(transition: DrawerMenuTransition) {
        animate()
    }
    
    func presentationPreAnimation(transition: DrawerMenuTransition) {
        guard let view = view else { return }
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        toX = 0
        toBackgroundColor = UIColor(red: 57/255, green: 59/255, blue: 88/255, alpha: 0.5)
        
        let fromX = -max(view.tableView.frame.width, view.searchTextField.frame.width)
        view.backgroundColor = toBackgroundColor.withAlphaComponent(0.0)
        view.tableView.frame.origin.x = fromX
        view.searchTextField.frame.origin.x = fromX
    }
    
    func presentationAnimation(transition: DrawerMenuTransition) {
        animate()
    }
    
    private func animate() {
        guard let view = view else { return }
        
        view.backgroundColor = toBackgroundColor
        view.tableView.frame.origin.x = toX
        view.searchTextField.frame.origin.x = toX
    }
}
