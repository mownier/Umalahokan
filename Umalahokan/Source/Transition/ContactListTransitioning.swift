//
//  ContactListTransitioning.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 13/02/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit
import DKChainableAnimationKit

class ContactListTransitioning: NSObject, UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ContactListTransition(style: .presentation)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ContactListTransition(style: .dismissal)
    }
}

class ContactListTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    enum Style {
        case presentation, dismissal
    }
    
    private(set) var style: Style = .presentation
    
    var duration: TimeInterval = 0.32
    
    init(style: Style) {
        super.init()
        self.style = style
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using context: UIViewControllerContextTransitioning) {
        // Setting up context
        let presentedKey: UITransitionContextViewKey = style == .presentation ? .to : .from
        
        let fromViewController = context.viewController(forKey: .from)!
        let toViewController = context.viewController(forKey: .to)!
        
        let presented = context.view(forKey: presentedKey) as! ContactListView
        let container = context.containerView
        
        presented.subviewWidthLayoutRatio = 2/3
        presented.setNeedsLayout()
        presented.layoutIfNeeded()
        
        let color: UIColor = UIColor(red: 57/255, green: 59/255, blue: 88/255, alpha: 1.0)
        let pointX = -max(
            presented.tableView.frame.maxX,
            presented.searchTextField.frame.maxX
        )
        
        switch style {
        case .presentation:
            container.addSubview(presented)
            container.backgroundColor = color.withAlphaComponent(0)
            
            presented.tableView.frame.origin.x = pointX
            presented.searchTextField.frame.origin.x = pointX
            
        default:
            break
        }
        
        // Setting up animation
        
        var toX: CGFloat = 0
        var toColor: UIColor = color
        
        switch style {
        case .presentation:
            toColor = color.withAlphaComponent(0.7)
            
        case .dismissal:
            toX = pointX
            toColor = color.withAlphaComponent(0)
        }
    
        fromViewController.beginAppearanceTransition(false, animated: true)
        toViewController.beginAppearanceTransition(true, animated: true)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            context.completeTransition(true)
            fromViewController.endAppearanceTransition()
            toViewController.endAppearanceTransition()
        })

        presented.tableView.animation.makeX(toX).easeInOut.animate(duration)
        presented.searchTextField.animation.makeX(toX).easeInOut.animate(duration)
        container.animation.makeBackground(toColor).animate(duration)
        
        CATransaction.commit()
    }
}
