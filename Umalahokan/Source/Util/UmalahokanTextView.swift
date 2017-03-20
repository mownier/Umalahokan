//
//  UmalahokanTextView.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 20/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

enum UmalahokanTextViewVerticalAlignment {

    case center
    case top
}

class UmalahokanTextView: UITextView {
    
    var verticalAlignment: UmalahokanTextViewVerticalAlignment = .center
    var placeholderLabel: UILabel!
    var notificationCenter = NotificationCenter.default
    
    override var contentSize: CGSize {
        didSet {
            switch verticalAlignment {
            case .center:
                var top = (bounds.size.height - contentSize.height * zoomScale) / 2.0
                top = max(0, top)
                contentInset = UIEdgeInsets(top: top, left: 0, bottom: 0, right: 0)
                
            default:
                break
            }
        }
    }
    
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
    convenience init() {
        self.init(frame: .zero)
        initSetup()
    }
    
    override func layoutSubviews() {
        var rect = CGRect.zero
        
        rect.size.width = frame.width - textContainer.lineFragmentPadding * 2
        rect.size.height = placeholderLabel.sizeThatFits(rect.size).height
        rect.origin.x = textContainer.lineFragmentPadding
        
        switch verticalAlignment {
        case .center:
            rect.origin.y = ((frame.height - rect.height) / 2) - (rect.height / 2)
            
        default:
            break
        }
        
        placeholderLabel.frame = rect
    }

    func initSetup() {
        notificationCenter.addObserver(
            self, selector: #selector(self.didChangeText(_:)),
            name: Notification.Name.UITextViewTextDidChange,
            object: nil
        )
        
        placeholderLabel = UILabel()
        
        addSubview(placeholderLabel)
    }
    
    func didChangeText(_ notif: Notification) {
        placeholderLabel.isHidden = text != nil && !text!.isEmpty
    }
}
