//
//  TagOptionFontStyle.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 28/4/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import UIKit
import os.log

class TagOptionFontStyle: TagOption {
    
    var key = "font-style"
    
    let textStyles: [String: UIFont.TextStyle] = [
        "body": .body,
        "callout": .callout,
        "caption1": .caption1,
        "caption2": .caption2,
        "footnote": .footnote,
        "headline": .headline,
        "largeTitle": .largeTitle,
        "subheadline": .subheadline,
        "title1": .title1,
        "title2": .title2,
        "title3": .title3
    ]
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String, forTextView textView: UITextView?) {
        if let textStyle = textStyles[value] {
            text.addAttribute(.font, value: UIFont.preferredFont(forTextStyle: textStyle), range: text.string.range)
        }
        else {
            os_log("Failed to apply option '%s' to text '%s', because value '%s' is not a valid option. Valid options are: {%s}.", log: .default, type: .error, key, text.string, value, textStyles.keys.map({return "'\($0)'"}).joined(separator: ", "))
        }
    }
}
