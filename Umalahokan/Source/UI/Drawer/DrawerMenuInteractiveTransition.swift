//
//  DrawerMenuInteractiveTransition.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 04/03/2017.
//  Copyright © 2017 Ner All rights reserved.
//

import UIKit

class DrawerMenuInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    enum Direction {
        
        case up
        case down
        case left
        case right
    }
    
    var hasStarted: Bool = false
    var shouldFinish: Bool = false
    
    var percentThreshold: CGFloat = 0.25
    
    func computeProgress(_ translationInView: CGPoint, viewBounds: CGRect, direction: DrawerMenuInteractiveTransition.Direction) -> CGFloat {
        let pointOnAxis: CGFloat
        let axisLength: CGFloat
        
        switch direction {
        case .up, .down:
            pointOnAxis = translationInView.y
            axisLength = viewBounds.height
            
        case .left, .right:
            pointOnAxis = translationInView.x
            axisLength = viewBounds.width
        }
        
        let movementOnAxis = pointOnAxis / axisLength
        let positiveMovementOnAxis: Float
        let positiveMovementOnAxisPercent: Float
        
        switch direction {
        case .right, .down: // positive
            positiveMovementOnAxis = fmaxf(Float(movementOnAxis), 0.0)
            positiveMovementOnAxisPercent = fminf(positiveMovementOnAxis, 1.0)
            return CGFloat(positiveMovementOnAxisPercent)
            
        case .up, .left: // negative
            positiveMovementOnAxis = fminf(Float(movementOnAxis), 0.0)
            positiveMovementOnAxisPercent = fmaxf(positiveMovementOnAxis, -1.0)
            return CGFloat(-positiveMovementOnAxisPercent)
        }
    }
    
    func updateUsing(_ state: UIGestureRecognizerState, progress: CGFloat, onBegin: () -> Void) {
        switch state {
        case .began:
            hasStarted = true
            onBegin()
            
        case .changed:
            shouldFinish = progress > percentThreshold
            update(progress)
            
        case .cancelled:
            hasStarted = false
            cancel()
            
        case .ended:
            hasStarted = false
            shouldFinish ? finish() : cancel()
            
        default:
            break
        }
    }
}
