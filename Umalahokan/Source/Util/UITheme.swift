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
            case semiBold(String)
            
            func size(_ fontSize: CGFloat) -> UIFont? {
                switch self {
                case .regular(let name),
                     .medium(let name),
                     .bold(let name),
                     .semiBold(let name):
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
        
        var semiBold: Style {
            return Style.semiBold("AvenirNext-DemiBold")
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
        
        var gray: UIColor {
            return UIColor(red: 133/255, green: 138/255, blue: 154/255, alpha: 1.0)
        }
        
        var gray2: UIColor {
            return UIColor(red: 233/255, green: 234/255, blue: 243/255, alpha: 1.0)
        }
        
        var gray3: UIColor {
            return UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        }
        
        var gray4: UIColor {
            return UIColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1.0)
        }
        
        var gray5: UIColor {
            return UIColor(red: 182/255, green: 182/255, blue: 182/255, alpha: 1.0)
        }
        
        var gray6: UIColor {
            return UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1.0)
        }
        
        var green: UIColor {
            return UIColor(red: 42/255, green: 198/255, blue: 173/255, alpha: 1.0)
        }
        
        var yellow: UIColor {
            return UIColor(red: 236/255, green: 107/255, blue: 178/255, alpha: 1.0)
        }
        
        var brown: UIColor {
            return UIColor(red: 207/255, green: 174/255, blue: 175/255, alpha: 1.0)
        }
        
        var blue: UIColor {
            return UIColor(red: 117/255, green: 168/255, blue: 252/255, alpha: 1.0)
        }
    }
    
    let font = Font()
    let color = Color()
}
