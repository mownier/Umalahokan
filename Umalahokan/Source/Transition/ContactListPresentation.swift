//
//  ContactListPresentation.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 11/02/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class ContactListPresentation: NSObject, SequentialTransition {

    fileprivate(set) var fromViewController: UIViewController!
    fileprivate(set) var toViewController: UIViewController!
    fileprivate(set) var context: UIViewControllerContextTransitioning!
    fileprivate(set) var sequences: [TransitionSequence]!
    
    fileprivate var presented: ContactListView!
    
    override init() {
        super.init()
        
        let seq001 = TransitionSequence(duration: 0.5, executor: animSeq001)
        
        sequences = [seq001]
    }
    
    func setup(for transitionContext: UIViewControllerContextTransitioning) {
        context = transitionContext
        
        let container = context.containerView
        
        fromViewController = context.viewController(forKey: .from)
        toViewController = context.viewController(forKey: .to)
        
        presented = context.view(forKey: .to) as! ContactListView
        
        container.addSubview(presented)
    }
}

extension ContactListPresentation: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using context: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using context: UIViewControllerContextTransitioning) {
        setup(for: context)
        play { }
    }
}
extension ContactListPresentation {
    
    func animSeq001(_ duration: TimeInterval, _ next: @escaping () -> Void) {
        presented.setNeedsLayout()
        presented.layoutIfNeeded()
        
        presented.backgroundView.alpha = 0
        
        let fromX: CGFloat = -presented.tableView.frame.width
        let toX: CGFloat = 0
        presented.tableView.frame.origin.x = fromX
        presented.searchTextField.frame.origin.x = fromX
        
        UIView.animate(withDuration: duration, animations: {
            self.presented.backgroundView.alpha = 1
            
            self.presented.tableView.frame.origin.x = toX
            self.presented.searchTextField.frame.origin.x = toX
        }) { _ in
            next()
        }
    }
}
