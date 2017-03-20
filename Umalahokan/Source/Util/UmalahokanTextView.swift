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
    
    convenience init() {
        self.init(frame: .zero)
        initSetup()
    }

    func initSetup() {
        placeholderLabel = UILabel()
        
        addSubview(placeholderLabel)
    }
    
    override func becomeFirstResponder() -> Bool {
        if placeholderLabel != nil {
            placeholderLabel.isHidden = true
        }
        
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        if placeholderLabel != nil {
            placeholderLabel.isHidden = false
        }
        
        return super.resignFirstResponder()
    }
}
