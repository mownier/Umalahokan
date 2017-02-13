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
        
        let containerView = context.containerView
        
        fromViewController = context.viewController(forKey: .from)
        toViewController = context.viewController(forKey: .to)
        
        presented = context.view(forKey: .to) as! ContactListView
        presented.frame.size.width = containerView.frame.width * (2/3)
        
        let tapHelperView = UIView()
        tapHelperView.backgroundColor = UIColor.clear
        tapHelperView.frame.size.width = containerView.frame.width * (1/3)
        tapHelperView.frame.size.height = containerView.frame.height
        tapHelperView.frame.origin.x = presented.frame.maxX
        
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 1
        tap.addTarget(self, action: #selector(self.didTapToDismiss))
        
        tapHelperView.addGestureRecognizer(tap)
        
        containerView.addSubview(tapHelperView)
        containerView.addSubview(presented)
    }
    
    func didTapToDismiss() {
        fromViewController.dismiss(animated: true, completion: nil)
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
        let container = context.containerView
        container.backgroundColor = UIColor.clear
        
        let maskLayer = CAShapeLayer()
        let menuView = presented!
        menuView.layer.mask = maskLayer
        
        let menuWidth = menuView.frame.width
        let maxSideSize = max(menuView.bounds.width, menuView.bounds.height)
        let beginRect = CGRect(x: 1, y: menuView.bounds.height / 2 - 1, width: 2, height: 2)
        let middleRect = CGRect(x: -menuWidth, y: 0, width: menuWidth * 2, height: menuView.bounds.height)
        let endRect = CGRect(x: -maxSideSize, y: menuView.bounds.height / 2 - maxSideSize, width: maxSideSize * 2, height: maxSideSize * 2)
        
        let beginPath = UIBezierPath(rect: menuView.bounds)
        beginPath.append(UIBezierPath(ovalIn: beginRect).reversing())
        
        let middlePath = UIBezierPath(rect: menuView.bounds)
        middlePath.append(UIBezierPath(ovalIn: middleRect).reversing())
        
        let endPath = UIBezierPath(rect: menuView.bounds)
        endPath.append(UIBezierPath(ovalIn: endRect).reversing())
        
        let bubbleAnim = CAKeyframeAnimation(keyPath: "path")
        bubbleAnim.values = [beginRect, middleRect, endRect].map { UIBezierPath(ovalIn: $0).cgPath }
        bubbleAnim.keyTimes = [0, 0.4, 1]
        bubbleAnim.duration = duration
        bubbleAnim.isRemovedOnCompletion = true
        bubbleAnim.fillMode = kCAFillModeForwards
        
        UIView.animate(withDuration: duration, animations: {
            maskLayer.add(bubbleAnim, forKey: "bubbleAnim")
            
            container.backgroundColor = UIColor(red: 57/255, green: 59/255, blue: 88/255, alpha: 0.7)
        }) { _ in
            maskLayer.removeFromSuperlayer()
            next()
        }
    }
}
