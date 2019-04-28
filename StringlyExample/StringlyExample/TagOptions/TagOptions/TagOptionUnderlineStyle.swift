//
//  TagOptionUnderlineStyle.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 28/4/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import UIKit
import os.log

class TagOptionUnderlineStyle: TagOption {
    
    var key = "underline-style"
    
    let underlineStyles: [String: NSUnderlineStyle] = [
        "byWord": NSUnderlineStyle.byWord,
        "double": NSUnderlineStyle.double,
        "patternDash": NSUnderlineStyle.patternDash,
        "patternDot": NSUnderlineStyle.patternDot,
        "patternDashDot": NSUnderlineStyle.patternDashDot,
        "patternDashDotDot": NSUnderlineStyle.patternDashDotDot,
        "single": NSUnderlineStyle.single
    ]
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String, forTextView textView: UITextView?) {
        // Remove other underline styles
        text.removeAttribute(.underlineStyle, range: text.string.range)
        for style in value.split(separator: ",").map({return String($0)}) {
            if let underlineStyle = underlineStyles[style] {
                if let currUnderlineStyle = text.fullRangeAttributes()[.underlineStyle] as? Int {
                    let newUnderlineStyle = NSUnderlineStyle(rawValue: currUnderlineStyle).union(underlineStyle)
                    text.addAttribute(.underlineStyle, value: newUnderlineStyle.rawValue, range: text.string.range)
                }
                else {
                    text.addAttribute(.underlineStyle, value: underlineStyle.rawValue, range: text.string.range)
                }
            }
            else {
                os_log("Failed to completely apply option '%s' to text '%s', because value '%s' is not a valid option. Valid options are: {%s}.", log: .default, type: .error, key, text.string, style, underlineStyles.keys.map({return "'\($0)'"}).joined(separator: ", "))
            }
        }
    }
}
