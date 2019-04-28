//
//  TagOptionTextAttachmentAlignment.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 28/4/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import UIKit
import os.log

class TagOptionTextAttachmentAlignment: AsyncWaitingTagOption {
    
    var key = "align"
    
    var waitOnOptions = ["img-src"]
    
    // TODO: Are the other text alignments relevant.
    let alignments: [String: NSTextAlignment] = [
        "center": NSTextAlignment.center,
        "right": NSTextAlignment.right,
        "left": NSTextAlignment.left
    ]
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String, forTextView textView: UITextView?) {
        if let alignment = alignments[value] {
            self.setAttachmentsAlignment(to: text, alignment)
        }
        else {
            os_log("Failed to completely apply option '%s' to image, because value '%s' is not a valid option. Valid options are: {%s}.", log: .default, type: .error, key, value, alignments.keys.map({return "'\($0)'"}).joined(separator: ", "))
        }
    }
    
    
    // Courtesy of: https://stackoverflow.com/a/45184640
    func setAttachmentsAlignment(to text: NSMutableAttributedString, _ alignment: NSTextAlignment) {
        text.enumerateAttribute(NSAttributedString.Key.attachment, in: NSRange(location: 0, length: text.length), options: .longestEffectiveRangeNotRequired) { (attribute, range, stop) -> Void in
            if attribute is NSTextAttachment {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = alignment
                text.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
            }
        }
    }
}
