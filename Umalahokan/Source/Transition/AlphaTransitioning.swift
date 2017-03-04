//
//  AlphaTransitioning.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 04/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol AlphaTransitionDelegate: class {
    
    func preAnimation(transition: AlphaTransition)
    func postAnimation(transition: AlphaTransition)}

extension AlphaTransitionDelegate {
    
    func preAnimation(transition: AlphaTransition) { }
    func postAnimation(transition: AlphaTransition) { }
}

class AlphaTransitioning: NSObject, UIViewControllerTransitioningDelegate {
    
    weak var delegate: AlphaTransitionDelegate?
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = AlphaTransition(style: .presentation)
        transition.delegate = delegate
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = AlphaTransition(style: .dismissal)
        transition.delegate = delegate
        return transition
    }
}

class AlphaTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    enum Style {
        case presentation, dismissal
    }
    
    private(set) var style: Style = .presentation
    
    weak var delegate: AlphaTransitionDelegate?
    var duration: TimeInterval = 0.25
    
    init(style: Style) {
        super.init()
        self.style = style
    }
    
    func transitionDuration(using context: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using context: UIViewControllerContextTransitioning) {
        // Setting up context
        let presentedKey: UITransitionContextViewKey = style == .presentation ? .to : .from
        
        let fromViewController = context.viewController(forKey: .from)!
        let toViewController = context.viewController(forKey: .to)!
        
        let presented = context.view(forKey: presentedKey)!
        let container = context.containerView
        
        var toAlpha: CGFloat = 1
        
        switch style {
        case .presentation:
            container.addSubview(presented)
            presented.alpha = 0
            
        case .dismissal:
            toAlpha = 0
        }
        
        delegate?.preAnimation(transition: self)
        
        presented.setNeedsLayout()
        presented.layoutIfNeeded()
        
        fromViewController.beginAppearanceTransition(false, animated: true)
        toViewController.beginAppearanceTransition(true, animated: true)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            presented.alpha = toAlpha
        }) { _ in
            context.completeTransition(true)
            fromViewController.endAppearanceTransition()
            toViewController.endAppearanceTransition()
        }
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        delegate?.postAnimation(transition: self)
    }
}
