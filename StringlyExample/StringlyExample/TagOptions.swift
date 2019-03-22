//
//  TagOptions.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 22/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import UIKit
import os.log

class TagOptionFontSize: TagOption {
    
    var key: String = "size"
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String) {
        if let fontSize = CGFloat(value) {
            if let font = text.fullRangeAttributes()[.font] as? UIFont {
                text.addAttribute(.font, value: font.withSize(fontSize), range: text.string.range)
            }
            else {
                text.addAttribute(.font, value: UIFont.systemFont(ofSize: fontSize), range: text.string.range)
            }
        }
        else {
            os_log(.error, "Failed to apply option '%s' to text '%s', because value '%s' is not a valid option.", key, text.string, value)
        }
    }
}

class TagOptionTextColor: TagOption {
    
    var key: String = "color"
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String) {
        if let color = UIColor.fromHexString(value) {
            text.addAttribute(.foregroundColor, value: color, range: text.string.range)
        }
        else {
            os_log(.error, "Failed to apply option '%s' to text '%s', because value '%s' is not a valid hex color. Acceptable color value formats: {'hhhhhh', 'hhhhhhhh', '#hhhhhh', '#hhhhhhhh'}, where h is a hex character.", key, text.string, value)
        }
    }
}
