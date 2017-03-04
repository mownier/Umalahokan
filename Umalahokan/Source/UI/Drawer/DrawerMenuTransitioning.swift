//
//  DrawerMenuTransitioning.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 04/03/2017.
//  Copyright © 2017 Ner All rights reserved.
//

import UIKit

class DrawerMenuTransitioning: NSObject, UIViewControllerTransitioningDelegate {
    
    weak var delegate: DrawerMenuTransitionDelegate?
    weak var interactiveTransition: DrawerMenuInteractiveTransition?
    
    var duration: TimeInterval = 0.5
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = DrawerMenuTransition(style: .presentation)
        transition.duration = duration
        transition.delegate = delegate
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = DrawerMenuTransition(style: .dismissal)
        transition.duration = duration
        transition.delegate = delegate
        return transition
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition?.hasStarted ?? false ? interactiveTransition : nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition?.hasStarted ?? false ? interactiveTransition : nil
    }
}
