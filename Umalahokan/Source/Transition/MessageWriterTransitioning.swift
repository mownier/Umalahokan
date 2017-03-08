//
//  MessageWriterTransitioning.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 15/02/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class MessageWriterTransitioning: NSObject, UIViewControllerTransitioningDelegate {

    var composerButtonFrame: CGRect = .zero
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = MessageWriterTransition(style: .presentation)
        transition.composerButtonFrame = composerButtonFrame
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = AlphaTransition(style: .dismissal)
        return transition
    }
}

class MessageWriterTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    enum Style {
        case presentation, dismissal
    }
    
    private(set) var style: Style = .presentation
    
    var duration: TimeInterval = 5.5
    var composerButtonFrame: CGRect = .zero
    
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
        let presented = context.view(forKey: presentedKey) as! MessageWriterView
        let container = context.containerView
        
        let whiteColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        switch style {
        case .presentation:
            presented.header.closeButton.alpha = 0
            presented.header.titleLabel.alpha = 0
            presented.header.inputBackground.alpha = 0
            presented.header.inputLabel.alpha = 0
            presented.header.inputTextField.alpha = 0
            
            presented.backgroundColor = whiteColor.withAlphaComponent(0)
            presented.tableView.backgroundColor = UIColor.clear
            presented.header.backgroundColor = UIColor.clear
            
            presented.header.backgroundView.frame = composerButtonFrame
            presented.header.backgroundView.layer.cornerRadius = composerButtonFrame.width / 2
            presented.header.backgroundView.layer.masksToBounds = true
            
            container.addSubview(presented)
        
            presentationAnimation(presented, context: context)
            
        case .dismissal:
            break
        }
    }
    
    func presentationAnimation(_ presented: MessageWriterView, context: UIViewControllerContextTransitioning) {
        let whiteColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let color = whiteColor.withAlphaComponent(1)
        
        let duration: TimeInterval = 1.25
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeLinear, animations: {
            var keyframeDuration: TimeInterval = 0.25
            var delay: TimeInterval = 0
            var relativeStartTime: TimeInterval = 0 + (delay / duration)
            var relativeDuration: TimeInterval = keyframeDuration / duration
            var totalKeyframeDuration = keyframeDuration + delay
            
            UIView.addKeyframe(withRelativeStartTime: relativeStartTime, relativeDuration: relativeDuration, animations: {
                presented.backgroundColor = color
                
                presented.header.backgroundView.frame.origin.y = 0
                presented.header.backgroundView.frame.origin.x = (presented.header.frame.width - presented.header.backgroundView.frame.width) / 2
            })
            
            keyframeDuration = 0.25
            delay = 0
            relativeStartTime = relativeDuration + (delay / duration)
            relativeDuration += (keyframeDuration / duration)
            totalKeyframeDuration += (keyframeDuration + delay)
            
            UIView.addKeyframe(withRelativeStartTime: relativeStartTime, relativeDuration: relativeDuration, animations: {
                presented.header.backgroundView.transform = CGAffineTransform(scaleX: 10, y: 10)
            })
            
            keyframeDuration = 0.25
            delay = 0
            relativeStartTime = relativeDuration + (delay / duration)
            relativeDuration += (keyframeDuration / duration)
            totalKeyframeDuration += (keyframeDuration + delay)
            
            UIView.addKeyframe(withRelativeStartTime: relativeStartTime, relativeDuration: relativeDuration, animations: {
                presented.header.closeButton.alpha = 1
                presented.header.titleLabel.alpha = 1
            })
            
            keyframeDuration = 0.25
            delay = 0.25
            relativeStartTime = relativeDuration + (delay / duration)
            relativeDuration += (keyframeDuration / duration)
            totalKeyframeDuration += (keyframeDuration + delay)
            
            UIView.addKeyframe(withRelativeStartTime: relativeStartTime, relativeDuration: relativeDuration, animations: {
                presented.header.inputBackground.alpha = 1
                presented.header.inputLabel.alpha = 1
                presented.header.inputTextField.alpha = 1
            })
            
            assert(totalKeyframeDuration == duration, "Total keyframe duration is not in sync.")
            
        }) { _ in
            context.completeTransition(!context.transitionWasCancelled)
        }
        
        perform(#selector(self.reloadTableView(_:)), with: presented, afterDelay: 0.50)
        perform(#selector(self.clipToBounds(_:)), with: presented, afterDelay: 0.49)
    }
    
    @objc func reloadTableView(_ presented: MessageWriterView) {
        presented.isValidToReload = true
        presented.tableView.reloadData()
    }
    
    @objc func clipToBounds(_ presented: MessageWriterView) {
        presented.header.clipsToBounds = true
    }
}
