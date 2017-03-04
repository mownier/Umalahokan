//
//  DrawerMenuTransition.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 04/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol DrawerMenuTransitionDelegate: class {
    
    func presentationPreAnimation(transition: DrawerMenuTransition)
    func presentationPostAnimation(transition: DrawerMenuTransition)
    func presentationAnimation(transition: DrawerMenuTransition)
    
    func dismissalPreAnimation(transition: DrawerMenuTransition)
    func dismissalPostAnimation(transition: DrawerMenuTransition)
    func dismissalAnimation(transition: DrawerMenuTransition)
}

extension DrawerMenuTransitionDelegate {
    
    func presentationPreAnimation(transition: DrawerMenuTransition) { }
    
    func presentationPostAnimation(transition: DrawerMenuTransition) { }
    
    func dismissalPreAnimation(transition: DrawerMenuTransition) { }
    
    func dismissalPostAnimation(transition: DrawerMenuTransition) { }
}

class DrawerMenuTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    enum Style {
        case presentation, dismissal
    }
    
    private(set) var style: Style = .presentation
    
    weak var delegate: DrawerMenuTransitionDelegate?
    var duration: TimeInterval = 0
    
    init(style: Style) {
        super.init()
        self.style = style
    }
    
    func transitionDuration(using context: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using context: UIViewControllerContextTransitioning) {
        let presentedKey: UITransitionContextViewKey = style == .presentation ? .to : .from
        let presented = context.view(forKey: presentedKey)!
        let container = context.containerView
        
        switch style {
        case .presentation:
            container.addSubview(presented)
            delegate?.presentationPreAnimation(transition: self)
            
        case .dismissal:
            delegate?.dismissalPreAnimation(transition: self)
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: { [unowned self] in
            switch self.style {
            case .presentation:
                self.delegate?.presentationAnimation(transition: self)
                
            case .dismissal:
                self.delegate?.dismissalAnimation(transition: self)
            }
            
        }) { _ in
            context.completeTransition(!context.transitionWasCancelled)
        }
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        switch style {
        case .presentation:
            delegate?.presentationPostAnimation(transition: self)
            
        case .dismissal:
            delegate?.dismissalPostAnimation(transition: self)
        }
    }
}
