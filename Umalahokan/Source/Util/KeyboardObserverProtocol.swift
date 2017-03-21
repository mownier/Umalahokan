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
    
    func willHandle(userInfo: [AnyHashable: Any]?, view: UIView?, scrollView: UIScrollView, isContentOffsetIncluded: Bool = false, offsetOnUp: CGFloat = 0, willMoveUsedView: Bool = true) {
        var handler = KeyboardHandler()
        handler.info = userInfo
        handler.willMoveUsedView = willMoveUsedView
        
        handler.handle(using: view ?? scrollView, with: { delta in
            let update: CGFloat?
            
            switch delta.direction {
            case .down:
                update = delta.height == 0 ? -abs(delta.y) : -abs(delta.height)
                
            case .up:
                update = delta.height == 0 ? (abs(delta.y) - offsetOnUp) : abs(delta.height)
                
            default:
                update = nil
            }
            
            guard update != nil else { return }
            
            scrollView.contentInset.bottom += update!
            scrollView.scrollIndicatorInsets.bottom += update!
            
            guard isContentOffsetIncluded else { return }
            
            let heightThreshold = scrollView.contentSize.height - scrollView.contentOffset.y + scrollView.contentInset.bottom
            var offset = scrollView.contentOffset
            offset.y = heightThreshold > scrollView.frame.height ? max(-scrollView.contentInset.top, offset.y + update!) : offset.y
            scrollView.setContentOffset(offset, animated: false)
        })
    }
}
