//
//  ChatTransitioning.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 16/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class ChatTransitioning: NSObject, UIViewControllerTransitioningDelegate {
    
    var avatarFrame: CGRect = .zero
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = ChatTransition(style: .presentation)
        transition.avatarFrame = avatarFrame
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = AlphaTransition(style: .dismissal)
        return transition
    }
}

class ChatTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    enum Style {
        case presentation, dismissal
    }
    
    private(set) var style: Style = .presentation
    private var avatarOriginalFrame: CGRect = .zero
    
    var duration: TimeInterval = 1.25
    var avatarFrame: CGRect = .zero
    
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
        let presented = context.view(forKey: presentedKey) as! ChatView
        let container = context.containerView
        
        switch style {
        case .presentation:
            presented.setNeedsLayout()
            presented.layoutIfNeeded()
            
            presented.topBar.clipsToBounds = false
            presented.topBar.backButton.alpha = 0
            presented.topBar.displayNameLabel.alpha = 0
            presented.topBar.moodLabel.alpha = 0
            presented.topBar.moodIndicator.alpha = 0
            presented.topBar.onlineStatusIndicator.alpha = 0
            presented.topBar.backgroundColor = UIColor.clear
            presented.collectionView.alpha = 0
            presented.sendView.alpha = 0
            avatarOriginalFrame = presented.topBar.avatarImageView.frame
            presented.topBar.avatarImageView.frame = avatarFrame
            presented.backgroundColor =  UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
            
            container.addSubview(presented)
            
            presentationAnimation(presented, context: context)
        
        case .dismissal:
            break
        }
    }
    
    private func presentationAnimation(_ presented: ChatView, context: UIViewControllerContextTransitioning) {
        let totalDuration = duration
        let toFrame = avatarOriginalFrame
        let toColor = presented.backgroundColor?.withAlphaComponent(1)
        UIView.animateKeyframes(withDuration: totalDuration, delay: 0, options: .calculationModeLinear, animations: {
            var keyframeDuration: TimeInterval = 0.25
            var delay: TimeInterval = 0
            var relativeStartTime: TimeInterval = 0 + (delay / totalDuration)
            var relativeDuration: TimeInterval = keyframeDuration / totalDuration
            var totalKeyframeDuration = keyframeDuration + delay
            
            UIView.addKeyframe(withRelativeStartTime: relativeStartTime, relativeDuration: relativeDuration, animations: {
                presented.backgroundColor = toColor
                presented.topBar.avatarImageView.frame = toFrame
                presented.topBar.backButton.alpha = 1
            })
            
            keyframeDuration = 0.25
            delay = 0.25
            relativeStartTime = relativeDuration + (delay / totalDuration)
            relativeDuration += (keyframeDuration / totalDuration)
            totalKeyframeDuration += (keyframeDuration + delay)
            
            UIView.addKeyframe(withRelativeStartTime: relativeStartTime, relativeDuration: relativeDuration, animations: {
                presented.topBar.displayNameLabel.alpha = 1
                presented.topBar.moodLabel.alpha = 1
                presented.topBar.moodIndicator.alpha = 1
                presented.topBar.onlineStatusIndicator.alpha = 1
                presented.collectionView.alpha = 1
            })
            
            keyframeDuration = 0.25
            delay = 0.25
            relativeStartTime = relativeDuration + (delay / totalDuration)
            relativeDuration += (keyframeDuration / totalDuration)
            totalKeyframeDuration += (keyframeDuration + delay)
            
            UIView.addKeyframe(withRelativeStartTime: relativeStartTime, relativeDuration: relativeDuration, animations: {
                presented.sendView.alpha = 1
            })

        }) { _ in
            context.completeTransition(!context.transitionWasCancelled)
        }
        
        perform(#selector(self.reloadCollectionView(_:)), with: presented, afterDelay: 0.75)
    }
    
    func reloadCollectionView(_ presented: ChatView) {
        presented.isValidToReload = true
        presented.collectionView.reloadData()
    }
}
