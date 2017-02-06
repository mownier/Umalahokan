//
//  MessageWriterTransition.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 04/02/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class MessageWriterTransition: NSObject, Transition {
    
    var duration: TimeInterval = 2
    var startingFrame: CGRect = .zero
    
    func animatePosition(target: UIView) {
        target.frame.origin.x = target.superview == nil ? 0 : target.superview!.frame.width
        target.frame.origin.x -= target.frame.width
        target.frame.origin.x /= 2
        target.frame.origin.y = 0
    }
    
    func animateCornerRadius(target: UIView) {
        let anim = CABasicAnimation(keyPath: "cornerRadius")
        anim.fromValue = target.layer.cornerRadius
        anim.toValue = 0
        anim.isRemovedOnCompletion = true
        target.layer.add(anim, forKey: nil)
        target.layer.cornerRadius = 0
    }
    
    func animateFrame(target: UIView) {
        target.frame.size.width = target.superview == nil ? target.frame.width : target.superview!.frame.width
        target.frame.size.height = 108
        target.frame.origin.x = 0
        target.frame.origin.y = 0
    }
}

extension MessageWriterTransition: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using context: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using context: UIViewControllerContextTransitioning) {
        let container = context.containerView
        
        let from = context.viewController(forKey: .from)!
        let to = context.viewController(forKey: .to)!
        
        from.beginAppearanceTransition(false, animated: true)
        to.beginAppearanceTransition(true, animated: true)
        
        let presented = context.view(forKey: .to) as! MessageWriterView
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
        
        let composerButton = UIButton()
        composerButton.frame = startingFrame
        composerButton.tintColor = UIColor.white
        composerButton.clipsToBounds = true
        //composerButton.setImage(#imageLiteral(resourceName: "button-composer"), for: .normal)
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
        
        presented.insertSubview(composerButton, at: 0)
        container.addSubview(presented)
        
        presented.header.inputTextField.becomeFirstResponder()
        UIView.animate(withDuration: 0.5, animations: {
            presented.backgroundColor = UIColor.white
            
            self.animatePosition(target: composerButton)
        }) { _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.animateCornerRadius(target: composerButton)
            }) { _ in
                presented.header.isHidden = false
                
                UIView.animate(withDuration: 0.5, animations: {
                    presented.header.closeButton.alpha = 1
                    presented.header.titleLabel.alpha = 1
                    
                    self.animateFrame(target: composerButton)
                }) { _ in
                    composerButton.removeFromSuperview()
                    presented.header.backgroundView.alpha = 1
                    
                    UIView.animate(withDuration: 0.5, animations: { 
                        presented.header.inputBackground.alpha = 1
                        presented.header.inputLabel.alpha = 1
                        presented.header.inputTextField.alpha = 1
                        presented.tableView.alpha = 1
                    }) { completed in
                        context.completeTransition(true)
                        from.endAppearanceTransition()
                        to.endAppearanceTransition()
                    }
                }
            }
        }
    }
}
