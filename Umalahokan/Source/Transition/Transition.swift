//
//  Transition.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 04/02/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol Transition: class {

    var duration: TimeInterval { get }
    var context: UIViewControllerContextTransitioning! { get }
    var fromViewController: UIViewController! { get }
    var toViewController: UIViewController! { get }
    
    func setup(for context: UIViewControllerContextTransitioning)
    func play(_ completion: @escaping () -> Void)
    func prelude(_ next: @escaping () -> Void)
    func epilogue(_ end: @escaping () -> Void)
}

extension Transition {
    
    func prelude(_ next: @escaping () -> Void) {
        fromViewController.beginAppearanceTransition(false, animated: true)
        toViewController.beginAppearanceTransition(true, animated: true)
        next()
    }
    
    func epilogue(_ end: @escaping () -> Void) {
        context.completeTransition(true)
        fromViewController.endAppearanceTransition()
        toViewController.endAppearanceTransition()
        end()
    }
}

struct Animation {
    
    var executor: () -> Void
    var duration: TimeInterval
    var delay: TimeInterval = 0
    var options: UIViewAnimationOptions = [.curveEaseInOut]
    
    init(duration: TimeInterval, executor: @escaping () -> Void) {
        self.duration = duration
        self.executor = executor
    }
}
