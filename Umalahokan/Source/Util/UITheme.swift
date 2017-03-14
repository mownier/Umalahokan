//
//  UITheme.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 14/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

struct UITheme {
    
    struct Font {
        
        enum Style {
            
            case regular(String)
            case medium(String)
            case bold(String)
            
            func size(_ fontSize: CGFloat) -> UIFont? {
                switch self {
                case .regular(let name),
                     .medium(let name),
                     .bold(let name):
                    return UIFont(name: name, size: fontSize)
                }
            }
        }
        
        var regular: Style {
            return Style.regular("AvenirNext-Regular")
        }
        
        var medium: Style {
            return Style.medium("AvenirNext-Medium")
        }
        
        var bold: Style {
            return Style.bold("AvenirNext-Bold")
        }
    }
    
    struct Color {
        
        var violet: UIColor {
            return UIColor(red: 57/255, green: 59/255, blue: 88/255, alpha: 1.0)
        }
        
        var violet2: UIColor {
            return UIColor(red: 142/255, green: 135/255, blue: 251/255, alpha: 1.0)
        }
        
        var violet3: UIColor {
            return UIColor(red: 188/255, green: 103/255, blue: 212/255, alpha: 1.0)
        }
        
        var pink: UIColor {
            return UIColor(red: 236/255, green: 107/255, blue: 178/255, alpha: 1.0)
        }
    }
    
    let font = Font()
    let color = Color()
}
