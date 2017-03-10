//
//  KeyboardObserverProtocol.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 10/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol KeyboardObserverProtocol: class {
    
    var keyboardObserver: Any? { set get }
    
    func addKeyboardObserver()
    func removeKeyboardObserver()
    func willHandleKeyboardNotification(with: Notification)
}

extension KeyboardObserverProtocol {
    
    func addKeyboardObserver() {
        keyboardObserver = NotificationCenter.default.addObserver(
            forName: Notification.Name.UIKeyboardWillChangeFrame,
            object: nil,
            queue: nil) { [unowned self] notif in
                self.willHandleKeyboardNotification(with: notif)
        }
    }
    
    func removeKeyboardObserver() {
        guard keyboardObserver != nil else {
            return
        }
        
        NotificationCenter.default.removeObserver(keyboardObserver!)
    }
    
    func willHandle(userInfo: [AnyHashable: Any]?, scrollView: UIScrollView) {
        willHandle(userInfo: userInfo, view: nil, scrollView: scrollView, offsetOnUp: 0)
    }
    
    func willHandle(userInfo: [AnyHashable: Any]?, view: UIView?, scrollView: UIScrollView, offsetOnUp: CGFloat) {
        var handler = KeyboardHandler()
        handler.info = userInfo
        handler.willMoveUsedView = true
        
        handler.handle(using: view ?? scrollView, with: { delta in
            switch delta.direction {
            case .down:
                if delta.height == 0 {
                    scrollView.contentInset.bottom = 0
                    scrollView.scrollIndicatorInsets.bottom = 0
                    
                } else {
                    scrollView.contentInset.bottom -= abs(delta.height)
                    scrollView.scrollIndicatorInsets.bottom -= abs(delta.height)
                }
                
            case .up:
                if delta.height == 0 {
                    scrollView.contentInset.bottom = abs(delta.y) - offsetOnUp
                    scrollView.scrollIndicatorInsets.bottom = abs(delta.y) - offsetOnUp
                    
                } else {
                    scrollView.contentInset.bottom += abs(delta.height)
                    scrollView.scrollIndicatorInsets.bottom += abs(delta.height)
                }
                
            default:
                break
            }
        })
    }
}
