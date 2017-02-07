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

protocol SequentialTransition: Transition {
    
    var sequences: [TransitionSequence] { set get }
    
    func setupSequences()
    func playSequences(_ next: @escaping () -> Void)
}

extension SequentialTransition {
    
    func play(_ completion: @escaping () -> Void) {
        setupSequences()
        prelude {
            self.playSequences {
                self.epilogue {
                    completion()
                }
            }
        }
    }
    
    func playSequences(_ end: @escaping () -> Void) {
        guard sequences.count > 0 else {
            end()
            return
        }
        
        let sequence = sequences.removeFirst()
        sequence.perform {
            self.playSequences(end)
        }
    }
}

struct TransitionSequence {
    
    var executor: (TimeInterval, @escaping () -> Void) -> Void
    var duration: TimeInterval
    
    init(duration: TimeInterval, executor: @escaping (TimeInterval, @escaping () -> Void) -> Void) {
        self.duration = duration
        self.executor = executor
    }
    
    func perform(_ next: @escaping () -> Void) {
        executor(duration, next)
    }
}
