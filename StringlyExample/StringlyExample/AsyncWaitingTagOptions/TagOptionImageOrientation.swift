//
//  TagOptionImageOrientation.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 28/4/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import UIKit
import os.log

class TagOptionImageOrientation: AsyncWaitingTagOption {
    
    var key = "orientation"
    
    var waitOnOptions = ["img-src"]
    
    let orientations: [String: UIImage.Orientation] = [
        "down": UIImage.Orientation.down,
        "downMirrored": UIImage.Orientation.downMirrored,
        "left": UIImage.Orientation.left,
        "leftMirrored": UIImage.Orientation.leftMirrored,
        "right": UIImage.Orientation.right,
        "rightMirrored": UIImage.Orientation.rightMirrored,
        "up": UIImage.Orientation.up,
        "upMirrored": UIImage.Orientation.upMirrored,
        ]
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String, forTextView textView: UITextView?) {
        if let textView = textView {
            if let orientation = orientations[value] {
                text.enumerateAttribute(NSAttributedString.Key.attachment, in: NSRange(location: 0, length: text.length), options: .longestEffectiveRangeNotRequired) { (attribute, range, stop) -> Void in
                    if let attachment = attribute as? NSTextAttachment, let image = attachment.image, let cgImage = image.cgImage {
                        var oldWidth = cgImage.width
                        if orientation.isHorizontal() {
                            oldWidth = cgImage.height
                        }
                        
                        // For the padding inside the textView
                        let scaleFactor = CGFloat(oldWidth) / textView.contentWidth
                        let newImage = UIImage(cgImage: cgImage, scale: scaleFactor, orientation: orientation)
                        attachment.image = newImage
                        text.replaceCharacters(in: range, with: NSAttributedString(attachment: attachment))
                    }
                }
            }
            else {
                os_log("Failed to completely apply option '%s' to image, because value '%s' is not a valid option. Valid options are: {%s}.", log: .default, type: .error, key, value, orientations.keys.map({return "'\($0)'"}).joined(separator: ", "))
            }
        }
        else {
            os_log("Warning: You have used TagOption with key '%s' but used the Stringly.format(...) with a nil value for the UITextView. For best results provide a value for 'textView'. Attempting to apply option anyway.", log: .default, type: .error, key, text)
            
            if let orientation = orientations[value] {
                text.enumerateAttribute(NSAttributedString.Key.attachment, in: NSRange(location: 0, length: text.length), options: .longestEffectiveRangeNotRequired) { (attribute, range, stop) -> Void in
                    if let attachment = attribute as? NSTextAttachment {
                        if let image = attachment.image {
                            let newImage = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: orientation)
                            attachment.image = newImage
                            text.replaceCharacters(in: range, with: NSAttributedString(attachment: attachment))
                        }
                    }
                }
            }
            else {
                os_log("Failed to completely apply option '%s' to image, because value '%s' is not a valid option. Valid options are: {%s}.", log: .default, type: .error, key, value, orientations.keys.map({return "'\($0)'"}).joined(separator: ", "))
            }
        }
        
    }
}
