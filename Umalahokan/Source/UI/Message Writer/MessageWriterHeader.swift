//
//  MessageWriterHeader.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 01/02/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol MessageWriterHeaderDelegate: class {

    func didTapClose()
}

class MessageWriterHeader: UIView {

    weak var delegate: MessageWriterHeaderDelegate?
    
    var closeButton: UIButton!
    var titleLabel: UILabel!
    var inputBackground: UIView!
    var inputLabel: UILabel!
    var inputTextField: UITextField!
    var backgroundView: UIImageView!
    
    convenience init() {
        var rect = CGRect.zero
        rect.size.height = 108
        self.init(frame: rect)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSetup()
    }
    
    override func layoutSubviews() {
        let spacing: CGFloat = 8
        var rect = CGRect.zero
        
        rect.size.width = 28
        rect.size.height = rect.width
        rect.origin.x = spacing
        rect.origin.y = spacing
        closeButton.frame = rect
        
        titleLabel.sizeToFit()
        rect.size = titleLabel.frame.size
        rect.origin.x = (frame.width - rect.width) / 2
        rect.origin.y = spacing * 2
        titleLabel.frame = rect
        
        rect.origin.x = 0
        rect.size.width = frame.width
        rect.size.height = 52
        rect.origin.y = frame.height - rect.height
        inputBackground.frame = rect
        
        inputLabel.sizeToFit()
        rect.origin.x = spacing * 2
        rect.origin.y += (rect.height - inputLabel.frame.height) / 2
        rect.size = inputLabel.frame.size
        inputLabel.frame = rect
        
        rect.origin.x = rect.maxX + spacing
        rect.size.width = frame.width - rect.origin.x - (spacing * 2)
        inputTextField.frame = rect
        
        backgroundView.frame = bounds
    }
    
    private func initSetup() {
        backgroundColor = UIColor.white
        
        // backgroundView = UIImageView(image: #imageLiteral(resourceName: "background-header"))
        // backgroundView.contentMode = .scaleAspectFill
        backgroundView = UIImageView()
        backgroundView.backgroundColor = UIColor(
            red: 142/255,
            green: 135/255,
            blue: 251/255,
            alpha: 1.0
        )
        
        closeButton = UIButton()
        closeButton.tintColor = UIColor.white
        closeButton.setImage(#imageLiteral(resourceName: "button-close"), for: .normal)
        closeButton.addTarget(self, action: #selector(self.didTapClose), for: .touchUpInside)
        closeButton.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        titleLabel = UILabel()
        titleLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        titleLabel.text = "NEW MESSAGE"
        titleLabel.textColor = UIColor.white
        
        inputBackground = UIView()
        inputBackground.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        
        inputLabel = UILabel()
        inputLabel.font = UIFont(name: "AvenirNext-Regular", size: 12)
        inputLabel.text = "Write to:"
        inputLabel.textColor = UIColor.white
        
        inputTextField = UITextField()
        inputTextField.tintColor = UIColor.white
        inputTextField.textColor = UIColor.white
        inputTextField.font = UIFont(name: "AvenirNext-Medium", size: 12)
        inputTextField.keyboardAppearance = .dark
        
        addSubview(backgroundView)
        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(inputBackground)
        addSubview(inputLabel)
        addSubview(inputTextField)
    }
    
    func didTapClose() {
        delegate?.didTapClose()
    }
}
