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
    
    var sequences: [TransitionSequence]! { get }
    
    func playSequences(_ index: Int, _ next: @escaping () -> Void)
}

extension SequentialTransition {
    
    var duration: TimeInterval {
        var time: TimeInterval = 0
        for seq in sequences {
            time += seq.duration
        }
        return time
    }
    
    func play(_ completion: @escaping () -> Void) {
        prelude {
            self.playSequences(0) {
                self.epilogue {
                    completion()
                }
            }
        }
    }
    
    func playSequences(_ index: Int, _ end: @escaping () -> Void) {
        guard index > -1, index < sequences.count else {
            end()
            return
        }
        
        let sequence = sequences[index]
        sequence.perform {
            self.playSequences(index + 1, end)
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
