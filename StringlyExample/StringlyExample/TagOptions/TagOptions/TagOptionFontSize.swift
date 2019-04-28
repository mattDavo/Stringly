//
//  TagOptionFontSize.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 28/4/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import UIKit
import os.log

class TagOptionFontSize: TagOption {
    
    var key: String = "font-size"
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String, forTextView textView: UITextView?) {
        if let fontSize = CGFloat(value) {
            if let font = text.fullRangeAttributes()[.font] as? UIFont {
                text.addAttribute(.font, value: font.withSize(fontSize), range: text.string.range)
            }
            else {
                text.addAttribute(.font, value: UIFont.systemFont(ofSize: fontSize), range: text.string.range)
            }
        }
        else {
            os_log("Failed to apply option '%s' to text '%s', because value '%s' is not a valid option.", log: .default, type: .error, key, text.string, value)
        }
    }
}
