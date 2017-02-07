//
//  MessageWriterTransition.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 04/02/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class MessageWriterPresentation: NSObject, Transition {
    
    var startingFrame: CGRect = .zero
    var animation: MessageWriterPresentAnimation!
    
    override init() {
        super.init()
        self.animation = MessageWriterPresentAnimation()
    }
}

extension MessageWriterPresentation: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using context: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animation.duration
    }
    
    func animateTransition(using context: UIViewControllerContextTransitioning) {
        animation.context = context
        animation.startingFrame = startingFrame
        animation.play { }
    }
}

class MessageWriterPresentAnimation {
    
    private var composerButton: UIButton?
    private var presented: MessageWriterView?
    private var from: UIViewController?
    private var to: UIViewController?
    
    let duration: TimeInterval = 1.75
    
    var context: UIViewControllerContextTransitioning? {
        didSet {
            guard let context = context else { return }
            
            let container = context.containerView
            
            from = context.viewController(forKey: .from)
            to = context.viewController(forKey: .to)
            
            composerButton = UIButton()
            composerButton!.tintColor = UIColor.white
            composerButton!.clipsToBounds = true
            composerButton!.backgroundColor = UIColor(
                red: 142/255,
                green: 135/255,
                blue: 251/255,
                alpha: 1.0
            )
            composerButton!.imageEdgeInsets.left = 4
            composerButton!.imageEdgeInsets.bottom = 4
            composerButton!.layer.shadowColor = UIColor.black.cgColor
            composerButton!.layer.shadowOffset = CGSize(width: 2, height: 2)
            composerButton!.layer.shadowRadius = 2
            composerButton!.layer.shadowOpacity = 0.5
            composerButton!.layer.masksToBounds = false
            composerButton!.isUserInteractionEnabled = false
            
            presented = context.view(forKey: .to) as? MessageWriterView
            
            if let presented = presented {
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
                
                presented.insertSubview(composerButton!, at: 0)
                
                container.addSubview(presented)
            }
        }
    }
    
    var startingFrame: CGRect = .zero {
        didSet {
            guard composerButton != nil else { return }
            
            composerButton!.frame = startingFrame
            composerButton!.layer.cornerRadius = startingFrame.width / 2
        }
    }
    
    func play(_ completion: @escaping () -> Void) {
        prelude {
            self.animateSeq001 {
                self.animateSeq002 {
                    self.animateSeq003 {
                        self.animateSeq004 {
                            self.epilogue {
                                completion()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func prelude(_ next: @escaping () -> Void) {
        from?.beginAppearanceTransition(false, animated: true)
        to?.beginAppearanceTransition(true, animated: true)
        next()
    }
    
    func epilogue(_ end: @escaping () -> Void) {
        context?.completeTransition(true)
        from?.endAppearanceTransition()
        to?.endAppearanceTransition()
        end()
    }
    
    private func animateSeq001(_ next: @escaping () -> Void) {
        UIView.animate(withDuration: 0.25, animations: {
            self.presented?.backgroundColor = UIColor.white
            
            guard let composerButton = self.composerButton else { return }
            
            composerButton.frame.origin.x = composerButton.superview == nil ? 0 : composerButton.superview!.frame.width
            composerButton.frame.origin.x -= composerButton.frame.width
            composerButton.frame.origin.x /= 2
            composerButton.frame.origin.y = 0
        }) { _ in
            next()
        }
    }
    
    private func animateSeq002(_ next: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5, animations: {
            guard let composerButton = self.composerButton else { return }
            
            let anim = CABasicAnimation(keyPath: "cornerRadius")
            anim.fromValue = composerButton.layer.cornerRadius
            anim.toValue = 0
            anim.isRemovedOnCompletion = true
            composerButton.layer.add(anim, forKey: nil)
            composerButton.layer.cornerRadius = 0
        }) { _ in
            next()
        }
    }
    
    private func animateSeq003(_ next: @escaping () -> Void) {
        presented?.header.isHidden = false
        
        UIView.animate(withDuration: 0.5, animations: {
            self.presented?.header.closeButton.alpha = 1
            self.presented?.header.titleLabel.alpha = 1
            
            guard let composerButton = self.composerButton else { return }
            
            composerButton.frame.size.width = composerButton.superview == nil ? composerButton.frame.width : composerButton.superview!.frame.width
            composerButton.frame.size.height = 108
            composerButton.frame.origin.x = 0
            composerButton.frame.origin.y = 0
        }) { _ in
            next()
        }
    }
    
    private func animateSeq004(_ next: @escaping () -> Void) {
        composerButton?.removeFromSuperview()
        presented?.header.backgroundView.alpha = 1
        
        UIView.animate(withDuration: 0.5, animations: {
            guard let presented = self.presented else { return }
            
            presented.header.inputBackground.alpha = 1
            presented.header.inputLabel.alpha = 1
            presented.header.inputTextField.alpha = 1
            presented.tableView.alpha = 1
        }) { _ in
            next()
        }
    }
}
