//
//  MessageWriterTransitioning.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 15/02/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import DKChainableAnimationKit

class MessageWriterTransitioning: NSObject, UIViewControllerTransitioningDelegate {

    var composerButtonFrame: CGRect = .zero
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = MessageWriterTransition(style: .presentation)
        transition.composerButtonFrame = composerButtonFrame
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
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
        
        let fromViewController = context.viewController(forKey: .from)!
        let toViewController = context.viewController(forKey: .to)!
        
        let presented = context.view(forKey: presentedKey) as! MessageWriterView
        let container = context.containerView
        
        let composerButton = UIButton()
        composerButton.frame = composerButtonFrame
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
        composerButton.layer.cornerRadius = composerButtonFrame.width / 2
        composerButton.isUserInteractionEnabled = false
        
        let whiteColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        switch style {
        case .presentation:
            presented.backgroundColor = whiteColor.withAlphaComponent(0)
            
            presented.header.isHidden = true
            presented.header.closeButton.alpha = 0
            presented.header.titleLabel.alpha = 0
            presented.header.inputBackground.alpha = 0
            presented.header.inputLabel.alpha = 0
            presented.header.inputTextField.alpha = 0
            presented.header.backgroundView.alpha = 0
            
            presented.tableView.isHidden = true
            
            // presented.insertSubview(composerButton, at: 0)
            
            container.addSubview(presented)
            container.addSubview(composerButton)
        
        case .dismissal:
            break
        }

        // Setting up animation
        fromViewController.beginAppearanceTransition(false, animated: true)
        toViewController.beginAppearanceTransition(true, animated: true)
        
        let y: CGFloat = 0
        var x: CGFloat = 0
        let width: CGFloat = composerButton.superview == nil ? composerButton.frame.width : composerButton.superview!.frame.width
        let height: CGFloat = 108
        
        x = composerButton.superview == nil ? 0 : composerButton.superview!.frame.width
        x -= composerButton.frame.width
        x /= 2

        let color = whiteColor.withAlphaComponent(1)
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(duration)
        CATransaction.setCompletionBlock({
            context.completeTransition(true)
            fromViewController.endAppearanceTransition()
            toViewController.endAppearanceTransition()
        })
        
        switch style {
        case .presentation:
            
//            presented.animation
//                .makeBackground(color)
//            .animate(0.25)
            
            composerButton.animation
                .makeX(x)
                .makeY(y)
            .thenAfter(0.25)
                .makeHeight(height)
                .easeInOut
            .animate(5.0)
            
//            presented.header.closeButton.animation.delay(0.75).makeAlpha(1).animate(0.5)
//            presented.header.titleLabel.animation.delay(0.75).makeAlpha(1).animateWithCompletion(0.5, { _ in
//                composerButton.removeFromSuperview()
//                presented.header.backgroundView.alpha = 1
//            })
//            presented.header.inputBackground.animation.delay(1.25).makeAlpha(1).animate(0.5)
//            presented.header.inputLabel.animation.delay(1.25).makeAlpha(1).animate(0.5)
//            presented.header.inputTextField.animation.delay(1.25).makeAlpha(1).animate(0.5)
            
        case .dismissal:
            break
        }
        
        CATransaction.commit()
    }
}
