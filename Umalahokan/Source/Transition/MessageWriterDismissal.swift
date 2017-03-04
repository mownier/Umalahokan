//
//  MessageWriterDismissal.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 08/02/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

//class MessageWriterDismissal: NSObject, SequentialTransition {
//
//    fileprivate(set) var fromViewController: UIViewController!
//    fileprivate(set) var toViewController: UIViewController!
//    fileprivate(set) var context: UIViewControllerContextTransitioning!
//    fileprivate(set) var sequences: [TransitionSequence]!
//    
//    fileprivate var composerButton: UIButton!
//    fileprivate var presented: MessageWriterView!
//    
//    var endingFrame: CGRect = .zero
//    var completion: (() -> Void)?
//    
//    override init() {
//        super.init()
//        
//        let seq001 = TransitionSequence(duration: 0.25, executor: animateSeq001)
//        let seq002 = TransitionSequence(duration: 0.25, executor: animateSeq002)
//        let seq003 = TransitionSequence(duration: 0.25, executor: animateSeq003)
//        let seq004 = TransitionSequence(duration: 0.40, executor: animateSeq004)
//        
//        sequences = [seq001, seq002, seq003, seq004]
//    }
//    
//    func setup(for ctx: UIViewControllerContextTransitioning) {
//        context = ctx
//        
//        fromViewController = context.viewController(forKey: .from)
//        toViewController = context.viewController(forKey: .to)
//
//        presented = context.view(forKey: .from) as! MessageWriterView
//        
//        composerButton = UIButton()
//        composerButton.frame = presented.header.frame
//        composerButton.tintColor = UIColor.white
//        composerButton.clipsToBounds = true
//        composerButton.backgroundColor = UIColor(
//            red: 142/255,
//            green: 135/255,
//            blue: 251/255,
//            alpha: 1.0
//        )
//        composerButton.imageEdgeInsets.left = 4
//        composerButton.imageEdgeInsets.bottom = 4
//        composerButton.layer.shadowColor = UIColor.black.cgColor
//        composerButton.layer.shadowOffset = CGSize(width: 2, height: 2)
//        composerButton.layer.shadowRadius = 2
//        composerButton.layer.shadowOpacity = 0.5
//        composerButton.layer.masksToBounds = false
//        composerButton.isUserInteractionEnabled = false
//        
//        presented.header.backgroundView.isHidden = true
//        presented.insertSubview(composerButton, at: 0)
//    }
//}
//
//extension MessageWriterDismissal: UIViewControllerAnimatedTransitioning {
//    
//    func transitionDuration(using context: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return duration
//    }
//    
//    func animateTransition(using context: UIViewControllerContextTransitioning) {
//        setup(for: context)
//        play {
//            self.completion?()
//        }
//    }
//}
//
//extension MessageWriterDismissal {
//    
//    func animateSeq001(_ duration: TimeInterval, _ next: @escaping () -> Void) {
//        UIView.animate(withDuration: duration, animations: {
//            self.presented.header.inputBackground.alpha = 0
//            self.presented.header.inputLabel.alpha = 0
//            self.presented.header.inputTextField.alpha = 0
//        }) { _ in
//            next()
//        }
//    }
//    
//    func animateSeq002(_ duration: TimeInterval, _ next: @escaping () -> Void) {
//        UIView.animate(withDuration: duration, animations: {
//            self.presented.header.closeButton.alpha = 0
//            self.presented.header.titleLabel.alpha = 0
//            
//            self.composerButton.frame.size = self.endingFrame.size
//            self.composerButton.frame.origin.x = self.composerButton.superview == nil ? 0 : self.self.composerButton.superview!.frame.width
//            self.composerButton.frame.origin.x -= self.composerButton.frame.width
//            self.composerButton.frame.origin.x /= 2
//            self.composerButton.frame.origin.y = 0
//        }) { _ in
//            next()
//        }
//    }
//    
//    func animateSeq003(_ duration: TimeInterval, _ next: @escaping () -> Void) {
//        UIView.animate(withDuration: duration, animations: {
//            let cornerRadius = self.composerButton.frame.width / 2
//            let anim = CABasicAnimation(keyPath: "cornerRadius")
//            anim.fromValue = self.composerButton.layer.cornerRadius
//            anim.toValue = cornerRadius
//            anim.isRemovedOnCompletion = true
//            
//            self.composerButton.layer.add(anim, forKey: nil)
//            self.composerButton.layer.cornerRadius = cornerRadius
//        }) { _ in
//            next()
//        }
//    }
//    
//    func animateSeq004(_ duration: TimeInterval, _ next: @escaping () -> Void) {
//        UIView.animate(withDuration: duration, animations: {
//            self.presented.backgroundColor = UIColor.clear
//            
//            self.composerButton.frame = self.endingFrame
//        }) { _ in
//            self.composerButton.removeFromSuperview()
//            next()
//        }
//    }
//}
