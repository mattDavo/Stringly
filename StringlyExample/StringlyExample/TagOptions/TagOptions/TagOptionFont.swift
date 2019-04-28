//
//  TagOptionFont.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 28/4/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import UIKit
import os.log

class TagOptionFont: TagOption {
    
    var key = "font"
    
    let defaultFontSize: CGFloat = 12
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String, forTextView textView: UITextView?) {
        guard let font = UIFont(name: value, size: defaultFontSize) else {
            os_log("Failed to apply option '%s' to text '%s', because value '%s' is not a known font.", log: .default, type: .error, key, text.string, value)
            return
        }
        if let oldFont = text.fullRangeAttributes()[.font] as? UIFont {
            text.addAttribute(.font, value: font.withSize(oldFont.pointSize), range: text.string.range)
        }
        else {
            text.addAttribute(.font, value: font.withSize(defaultFontSize), range: text.string.range)
        }
    }
}
