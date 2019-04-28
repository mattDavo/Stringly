//
//  TagOptionTextAlignment.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 28/4/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import UIKit
import os.log

class TagOptionTextAlignment: TagOption {
    
    var key = "align"
    
    // TODO: Are the other text alignments relevant.
    let alignments: [String: NSTextAlignment] = [
        "center": NSTextAlignment.center,
        "right": NSTextAlignment.right,
        "left": NSTextAlignment.left,
        "justified": NSTextAlignment.justified,
        "natural": NSTextAlignment.natural
    ]
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String, forTextView textView: UITextView?) {
        if let alignment = alignments[value] {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = alignment
            text.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: text.string.range)
        }
        else {
            os_log("Failed to completely apply option '%s' to image, because value '%s' is not a valid option. Valid options are: {%s}.", log: .default, type: .error, key, value, alignments.keys.map({return "'\($0)'"}).joined(separator: ", "))
        }
    }
}
