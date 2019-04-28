//
//  TextViewTagOptionImageSource.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 28/4/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import UIKit
import os.log

class TagOptionImageSource: AsyncTagOption {
    
    var key = "src"
    
    var waitKey = "img-src"
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String, forTextView textView: UITextView?, onCompletion: @escaping (NSMutableAttributedString) -> ()) {
        if let textView = textView {
            // Courtesy of https://stackoverflow.com/a/38479284
            if let image = UIImage(named: value) {
                let textAttachment = NSTextAttachment()
                textAttachment.image = image
                
                let oldWidth = textAttachment.image!.size.width;
                
                // For the padding inside the textView
                let scaleFactor = oldWidth / textView.contentWidth
                let image = UIImage(cgImage: textAttachment.image!.cgImage!, scale: scaleFactor, orientation: .up)
                textAttachment.image = image
                let attrStringWithImage = NSAttributedString(attachment: textAttachment)
                text.replaceCharacters(in: NSRange(location: 0, length: text.length), with: attrStringWithImage)
                onCompletion(text)
            }
            else {
                os_log("Error: Failed to load image named '%s'.", log: .default, type: .error, value)
            }
        }
        else {
            os_log("Warning: You have used TextViewTagOption with key '%s' but used the Stringly.format(...) with a nil value for the UITextView. For best results provide a value for 'textView'. Attempting to apply option anyway.", log: .default, type: .error, key, text)
            
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
                os_log("Error: Failed to load image named '%s'.", log: .default, type: .error, value)
            }
        }
    }
}
