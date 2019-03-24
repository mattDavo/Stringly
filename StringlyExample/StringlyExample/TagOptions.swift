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

class TagOptionFont: TagOption {
    
    var key = "font"
    
    let defaultFontSize: CGFloat = 12
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String) {
        guard let font = UIFont(name: value, size: defaultFontSize) else {
            os_log(.error, "Failed to apply option '%s' to text '%s', because value '%s' is not a known font.", key, text.string, value)
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

class TagOptionFontSize: TagOption {
    
    var key: String = "font-size"
    
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

class TagOptionTextHighlight: TagOption {
    
    var key = "highlight"
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String) {
        if let color = UIColor.fromHexString(value) {
            text.addAttribute(.backgroundColor, value: color, range: text.string.range)
        }
        else {
            os_log(.error, "Failed to apply option '%s' to text '%s', because value '%s' is not a valid hex color. Acceptable color value formats: {'hhhhhh', 'hhhhhhhh', '#hhhhhh', '#hhhhhhhh'}, where h is a hex character.", key, text.string, value)
        }
    }
}

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
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String) {
        if let textStyle = textStyles[value] {
            text.addAttribute(.font, value: UIFont.preferredFont(forTextStyle: textStyle), range: text.string.range)
        }
        else {
            os_log(.error, "Failed to apply option '%s' to text '%s', because value '%s' is not a valid option. Valid options are: {%s}.", key, text.string, value, textStyles.keys.map({return "'\($0)'"}).joined(separator: ", "))
        }
    }
}

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
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String) {
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
                os_log(.error, "Failed to completely apply option '%s' to text '%s', because value '%s' is not a valid option. Valid options are: {%s}.", key, text.string, style, underlineStyles.keys.map({return "'\($0)'"}).joined(separator: ", "))
            }
        }
    }
}

class TagOptionUnderlineColor: TagOption {
    
    var key = "underline-color"
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String) {
        if let color = UIColor.fromHexString(value) {
            text.addAttribute(.underlineColor, value: color, range: text.string.range)
        }
        else {
            os_log(.error, "Failed to apply option '%s' to text '%s', because value '%s' is not a valid hex color. Acceptable color value formats: {'hhhhhh', 'hhhhhhhh', '#hhhhhh', '#hhhhhhhh'}, where h is a hex character.", key, text.string, value)
        }
    }
}

class TagOptionStrikethroughStyle: TagOption {
    
    var key = "strikethrough-style"
    
    let strikethroughStyles: [String: NSUnderlineStyle] = [
        "byWord": NSUnderlineStyle.byWord,
        "double": NSUnderlineStyle.double,
        "patternDash": NSUnderlineStyle.patternDash,
        "patternDot": NSUnderlineStyle.patternDot,
        "patternDashDot": NSUnderlineStyle.patternDashDot,
        "patternDashDotDot": NSUnderlineStyle.patternDashDotDot,
        "single": NSUnderlineStyle.single
    ]
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String) {
        // Remove other underline styles
        text.removeAttribute(.strikethroughStyle, range: text.string.range)
        for style in value.split(separator: ",").map({return String($0)}) {
            if let underlineStyle = strikethroughStyles[style] {
                if let currUnderlineStyle = text.fullRangeAttributes()[.underlineStyle] as? Int {
                    let newUnderlineStyle = NSUnderlineStyle(rawValue: currUnderlineStyle).union(underlineStyle)
                    text.addAttribute(.strikethroughStyle, value: newUnderlineStyle.rawValue, range: text.string.range)
                }
                else {
                    text.addAttribute(.strikethroughStyle, value: underlineStyle.rawValue, range: text.string.range)
                }
            }
            else {
                os_log(.error, "Failed to completely apply option '%s' to text '%s', because value '%s' is not a valid option. Valid options are: {%s}.", key, text.string, style, strikethroughStyles.keys.map({return "'\($0)'"}).joined(separator: ", "))
            }
        }
    }
}

class TagOptionStrikethroughColor: TagOption {
    
    var key = "strikethrough-color"
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String) {
        if let color = UIColor.fromHexString(value) {
            text.addAttribute(.strikethroughColor, value: color, range: text.string.range)
        }
        else {
            os_log(.error, "Failed to apply option '%s' to text '%s', because value '%s' is not a valid hex color. Acceptable color value formats: {'hhhhhh', 'hhhhhhhh', '#hhhhhh', '#hhhhhhhh'}, where h is a hex character.", key, text.string, value)
        }
    }
}

class TagOptionRedactColor: TagOption {
    
    var key = "color"
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String) {
        if let color = UIColor.fromHexString(value) {
            text.addAttribute(.backgroundColor, value: color, range: text.string.range)
            text.addAttribute(.foregroundColor, value: color, range: text.string.range)
        }
        else {
            os_log(.error, "Failed to apply option '%s' to text '%s', because value '%s' is not a valid hex color. Acceptable color value formats: {'hhhhhh', 'hhhhhhhh', '#hhhhhh', '#hhhhhhhh'}, where h is a hex character.", key, text.string, value)
        }
    }
}

class TextViewTagOptionImageSource: TextViewTagOption {
    
    var key = "src"
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String, forTextView textView: UITextView) {
        // Courtesy of https://stackoverflow.com/a/38479284
        if let image = UIImage(named: value) {
            let textAttachment = NSTextAttachment()
            textAttachment.image = image
            
            let oldWidth = textAttachment.image!.size.width;
            
            // For the padding inside the textView
            let scaleFactor = oldWidth / (textView.frame.size.width - 10)
            let image = UIImage(cgImage: textAttachment.image!.cgImage!, scale: scaleFactor, orientation: .up)
            textAttachment.image = image
            let attrStringWithImage = NSAttributedString(attachment: textAttachment)
            text.append(attrStringWithImage)
        }
        else {
            os_log(.error, "Error: Failed to load image named '%s'.", value)
        }
    }
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String) {
        os_log(.error, "Warning: You have used TextViewTagOption with key '%s' but used the Stringly.format(...) with a nil value for the UITextView. For best results provide a value for 'textView'. Attempting to apply option anyway.", key, text)
        
        // Courtesy of https://stackoverflow.com/a/38479284
        if let image = UIImage(named: value) {
            let textAttachment = NSTextAttachment()
            textAttachment.image = image
            let image = UIImage(cgImage: textAttachment.image!.cgImage!, scale: 1, orientation: .up)
            textAttachment.image = image
            let attrStringWithImage = NSAttributedString(attachment: textAttachment)
            text.append(attrStringWithImage)
        }
        else {
            os_log(.error, "Error: Failed to load image named '%s'.", value)
        }
    }
}

class TagOptionImageOrientation: TagOption {
    
    var key = "orientation"
    
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
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String) {
        if let orientation = orientations[value] {
            // Using: https://stackoverflow.com/a/48196253
            text.enumerateAttributes(in: text.string.range, options: NSAttributedString.EnumerationOptions(rawValue: 0)) { (object, range, stop) in
                if object.keys.contains(NSAttributedString.Key.attachment) {
                    if let attachment = object[NSAttributedString.Key.attachment] as? NSTextAttachment {
                        if let image = attachment.image {
                            let newImage = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: orientation)
                            attachment.image = newImage
                            text.replaceCharacters(in: range, with: NSAttributedString(attachment: attachment))
                        }
                        else if let image = attachment.image(forBounds: attachment.bounds, textContainer: nil, characterIndex: range.location) {
                            let newImage = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: orientation)
                            attachment.image = newImage
                            text.replaceCharacters(in: range, with: NSAttributedString(attachment: attachment))
                        }
                    }
                }
            }
        }
        else {
            os_log(.error, "Failed to completely apply option '%s' to image, because value '%s' is not a valid option. Valid options are: {%s}.", key, value, orientations.keys.map({return "'\($0)'"}).joined(separator: ", "))
        }
    }
}
