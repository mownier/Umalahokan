//
//  TranslationTransitioning.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 04/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol TranslationTransitionDelegate: class {
    
    func preAnimation(transition: TranslationTransition)
    func postAnimation(transition: TranslationTransition)}

extension TranslationTransitionDelegate {
    
    func preAnimation(transition: TranslationTransition) { }
    func postAnimation(transition: TranslationTransition) { }
}

class TranslationTransitioning: NSObject, UIViewControllerTransitioningDelegate {
    
    weak var delegate: TranslationTransitionDelegate?
    
    var presentationDirection: TranslationTransition.Direction = .up
    var dismissalDirection: TranslationTransition.Direction = .down
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = TranslationTransition(style: .presentation, direction: presentationDirection)
        transition.delegate = delegate
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = TranslationTransition(style: .dismissal, direction: dismissalDirection)
        transition.delegate = delegate
        return transition
    }
}

class TranslationTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    enum Style {
        case presentation, dismissal
    }
    
    enum Direction {
        case up, down, right, left
    }
    
    private(set) var style: Style = .presentation
    private(set) var direction: Direction = .up
    
    weak var delegate: TranslationTransitionDelegate?
    var duration: TimeInterval = 0.25
    
    init(style: Style, direction: Direction) {
        super.init()
        self.style = style
        self.direction = direction
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
        
        presented.setNeedsLayout()
        presented.layoutIfNeeded()

        var toX: CGFloat = 0
        var toY: CGFloat = 0
        
        switch style {
        case .presentation:
            container.addSubview(presented)
            switch direction {
            case .up:
                presented.frame.origin.y = presented.frame.maxY
            case .down:
                presented.frame.origin.y = -presented.frame.height
            case .left:
                presented.frame.origin.x = presented.frame.maxX
            case .right:
                presented.frame.origin.x = -presented.frame.width
            }
            
        case .dismissal:
            switch direction {
            case .up:
                toY = -presented.frame.height
            case .down:
                toY = presented.frame.maxY
            case .left:
                toX = -presented.frame.width
            case .right:
                toX = presented.frame.maxX
            }
        }
        
        delegate?.preAnimation(transition: self)
        
        presented.setNeedsLayout()
        presented.layoutIfNeeded()
        
        fromViewController.beginAppearanceTransition(false, animated: true)
        toViewController.beginAppearanceTransition(true, animated: true)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            presented.frame.origin.y = toY
            presented.frame.origin.x = toX
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
