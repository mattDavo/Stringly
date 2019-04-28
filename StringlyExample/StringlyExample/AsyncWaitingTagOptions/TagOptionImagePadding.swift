//
//  TextViewTagOptionImagePadding.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 28/4/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import UIKit
import os.log

class TagOptionImagePadding: AsyncWaitingTagOption {
    
    var key = "padding"
    
    var waitOnOptions = ["img-src"]
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String, forTextView textView: UITextView?) {
        if let textView = textView {
            if let padding = CGFloat(value) {
                if textView.contentWidth - padding * 2 <= 0 {
                    os_log("Failed to apply option '%s' to image, because value '%s' is too large and would result in an image width of '%lf'.", log: .default, type: .error, key, value, textView.contentWidth - padding * 2)
                    return
                }
                
                text.enumerateAttribute(NSAttributedString.Key.attachment, in: NSRange(location: 0, length: text.length), options: .longestEffectiveRangeNotRequired) { (attribute, range, stop) -> Void in
                    if let attachment = attribute as? NSTextAttachment, let image = attachment.image, let cgImage = image.cgImage {
                        var oldWidth = cgImage.width
                        if image.isHorizontal() {
                            oldWidth = cgImage.height
                        }
                        
                        // For the padding inside the textView
                        let scaleFactor = CGFloat(oldWidth) / (textView.contentWidth - 2 * padding)
                        let newImage = UIImage(cgImage: cgImage, scale: scaleFactor, orientation: image.imageOrientation)
                        attachment.image = newImage
                        text.replaceCharacters(in: range, with: NSAttributedString(attachment: attachment))
                    }
                }
            }
            else {
                os_log("Failed to apply option '%s' to image, because value '%s' is not a number.", log: .default, type: .error, key, value)
            }
        }
        else {
            os_log("Warning: You have used TextViewTagOption with key '%s' but used the Stringly.format(...) with a nil value for the UITextView. The %s option is not supported for nil UITextView values.", log: .default, type: .error, key, text, key)
        }
    }
}
