//
//  TagOptionTextColor.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 28/4/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import UIKit
import os.log

class TagOptionTextColor: TagOption {
    
    var key: String = "color"
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String, forTextView textView: UITextView?) {
        if let color = UIColor.fromHexString(value) {
            text.addAttribute(.foregroundColor, value: color, range: text.string.range)
        }
        else {
            os_log("Failed to apply option '%s' to text '%s', because value '%s' is not a valid hex color. Acceptable color value formats: {'hhhhhh', 'hhhhhhhh', '#hhhhhh', '#hhhhhhhh'}, where h is a hex character.", log: .default, type: .error, key, text.string, value)
        }
    }
}
