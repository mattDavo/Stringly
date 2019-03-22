//
//  TagAttributes.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 22/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import UIKit

class TagAttributeFontSize: TagAttribute {
    
    var fontSize: CGFloat
    
    init(fontSize: CGFloat) {
        self.fontSize = fontSize
    }
    
    func applyAttribute(to text: NSMutableAttributedString) {
        if let font = text.fullRangeAttributes()[.font] as? UIFont {
            text.addAttribute(.font, value: font.withSize(fontSize), range: text.string.range)
        }
        else {
            text.addAttribute(.font, value: UIFont.systemFont(ofSize: fontSize), range: text.string.range)
        }
    }
}

class TagAttributeBold: TagAttribute {
    
    let defaultFontSize: CGFloat = 12
    
    func applyAttribute(to text: NSMutableAttributedString) {
        if let font = text.fullRangeAttributes()[.font] as? UIFont {
            text.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: font.pointSize), range: text.string.range)
        }
        else {
            text.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: defaultFontSize), range: text.string.range)
        }
    }
}

class TagAttributeItalic: TagAttribute {
    
    let defaultFontSize: CGFloat = 12
    
    func applyAttribute(to text: NSMutableAttributedString) {
        if let font = text.fullRangeAttributes()[.font] as? UIFont {
            text.addAttribute(.font, value: UIFont.italicSystemFont(ofSize: font.pointSize), range: text.string.range)
        }
        else {
            text.addAttribute(.font, value: UIFont.italicSystemFont(ofSize: defaultFontSize), range: text.string.range)
        }
    }
}

class TagAttributeUnderline: TagAttribute {
    
    let defaultUnderlineStyle = NSUnderlineStyle.single.rawValue
    let defaultUnderlineColor = UIColor.black
    
    func applyAttribute(to text: NSMutableAttributedString) {
        if text.fullRangeAttributes()[.underlineStyle] == nil {
            text.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: text.string.range)
        }
        if text.fullRangeAttributes()[.underlineColor] == nil {
            if let color = text.fullRangeAttributes()[.foregroundColor] as? UIColor {
                text.addAttribute(.underlineColor, value: color, range: text.string.range)
            }
            else {
                text.addAttribute(.underlineColor, value: defaultUnderlineColor, range: text.string.range)
            }
        }
        
    }
}
