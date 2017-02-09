//
//  MessageWriterPresentation.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 04/02/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class MessageWriterPresentation: NSObject, SequentialTransition {
    
    fileprivate(set) var fromViewController: UIViewController!
    fileprivate(set) var toViewController: UIViewController!
    fileprivate(set) var context: UIViewControllerContextTransitioning!
    fileprivate(set) var sequences: [TransitionSequence]!
    
    fileprivate var composerButton: UIButton!
    fileprivate var presented: MessageWriterView!
    
    var startingFrame: CGRect = .zero
    
    override init() {
        super.init()
        
        let seq001 = TransitionSequence(duration: 0.25, executor: animateSeq001)
        let seq002 = TransitionSequence(duration: 0.50, executor: animateSeq002)
        let seq003 = TransitionSequence(duration: 0.50, executor: animateSeq003)
        let seq004 = TransitionSequence(duration: 0.50, executor: animateSeq004)
        
        sequences = [seq001, seq002, seq003, seq004]
    }
    
    func setup(for context: UIViewControllerContextTransitioning) {
        self.context = context
        
        let container = context.containerView
        
        fromViewController = context.viewController(forKey: .from)
        toViewController = context.viewController(forKey: .to)
        
        composerButton = UIButton()
        composerButton.frame = startingFrame
        composerButton.tintColor = UIColor.white
        composerButton.clipsToBounds = true
        composerButton.backgroundColor = UIColor(
            red: 142/255,
            green: 135/255,
            blue: 251/255,
            alpha: 1.0
        )
        composerButton.imageEdgeInsets.left = 4
        composerButton.imageEdgeInsets.bottom = 4
        composerButton.layer.shadowColor = UIColor.black.cgColor
        composerButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        composerButton.layer.shadowRadius = 2
        composerButton.layer.shadowOpacity = 0.5
        composerButton.layer.masksToBounds = false
        composerButton.layer.cornerRadius = startingFrame.width / 2
        composerButton.isUserInteractionEnabled = false
        
        presented = context.view(forKey: .to) as! MessageWriterView
        
        presented.backgroundColor = UIColor.clear
        
        presented.header.isHidden = true
        presented.header.backgroundColor = UIColor.clear
        presented.header.backgroundView.alpha = 0
        presented.header.closeButton.alpha = 0
        presented.header.titleLabel.alpha = 0
        presented.header.inputBackground.alpha = 0
        presented.header.inputLabel.alpha = 0
        presented.header.inputTextField.alpha = 0
        
        presented.tableView.alpha = 0
        
        presented.insertSubview(composerButton, at: 0)
        
        container.addSubview(presented)
    }
}

extension MessageWriterPresentation: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using context: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using context: UIViewControllerContextTransitioning) {
        setup(for: context)
        play { }
    }
}

extension MessageWriterPresentation {
    
    fileprivate func animateSeq001(_ duration: TimeInterval, _ next: @escaping () -> Void) {
        UIView.animate(withDuration: 0.25, animations: {
            self.presented.backgroundColor = UIColor.white
            
            self.composerButton.frame.origin.x = self.composerButton.superview == nil ? 0 : self.self.composerButton.superview!.frame.width
            self.composerButton.frame.origin.x -= self.composerButton.frame.width
            self.composerButton.frame.origin.x /= 2
            self.composerButton.frame.origin.y = 0
        }) { _ in
            next()
        }
    }
    
    fileprivate func animateSeq002(_ duration: TimeInterval, _ next: @escaping () -> Void) {
        UIView.animate(withDuration: duration, animations: {
            let anim = CABasicAnimation(keyPath: "cornerRadius")
            anim.fromValue = self.composerButton.layer.cornerRadius
            anim.toValue = 0
            anim.isRemovedOnCompletion = true
            self.composerButton.layer.add(anim, forKey: nil)
            self.composerButton.layer.cornerRadius = 0
        }) { _ in
            next()
        }
    }
    
    fileprivate func animateSeq003(_ duration: TimeInterval, _ next: @escaping () -> Void) {
        presented.header.isHidden = false
        presented.tableView.alpha = 1
        presented.isValidToReload = true
        presented.tableView.reloadData()
        
        UIView.animate(withDuration: duration, animations: {
            self.presented.header.closeButton.alpha = 1
            self.presented.header.titleLabel.alpha = 1
            
            self.composerButton.frame.size.width = self.composerButton.superview == nil ? self.composerButton.frame.width : self.composerButton.superview!.frame.width
            self.composerButton.frame.size.height = 108
            self.composerButton.frame.origin.x = 0
            self.composerButton.frame.origin.y = 0
        }) { _ in
            next()
        }
    }
    
    fileprivate func animateSeq004(_ duration: TimeInterval, _ next: @escaping () -> Void) {
        composerButton.removeFromSuperview()
        presented.header.backgroundView.alpha = 1
        
        UIView.animate(withDuration: duration, animations: {
            self.presented.header.inputBackground.alpha = 1
            self.presented.header.inputLabel.alpha = 1
            self.presented.header.inputTextField.alpha = 1
        }) { _ in
            next()
        }
    }
}
