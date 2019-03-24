//
//  TagType.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 22/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import UIKit
import os.log

public class TagType {
    
    public var tag: String
    
    public var attributes: [TagAttribute]
    
    public var options: [TagOption]
    
    init(tag: String, attributes: [TagAttribute], options: [TagOption]) {
        self.tag = tag
        self.attributes = attributes
        self.options = options
    }
    
    public func addAttribute(_ attribute: TagAttribute) {
        attributes.append(attribute)
    }
    
    public func addOption(_ option: TagOption) {
        if options.map({return $0.key}).contains(option.key) {
            os_log(.error, "Warning: Already have an option with key '%s'. Will attempt to apply original then this new option.", option.key)
        }
        options.append(option)
    }
    
    public func applyStyle(to text: NSMutableAttributedString, withOptions options: [String: String], toTextView textView: UITextView? = nil) {
        // Apply standard attributes
        for attribute in attributes {
            if let attribute = attribute as? TextViewTagAttribute, let textView = textView {
                attribute.applyAttribute(to: text, forTextView: textView)
            }
            else {
                attribute.applyAttribute(to: text)
            }
        }
        
        var options = options
        
        // Apply options
        for option in self.options {
            if let value = options.removeValue(forKey: option.key) {
                if let option = option as? TextViewTagOption, let textView = textView {
                    option.applyOption(to: text, withValue: value, forTextView: textView)
                }
                else {
                    option.applyOption(to: text, withValue: value)
                }
            }
        }
        if options.count > 0 {
            os_log(.error, "Warning: There are no options for tag '%s' with %s '%s'.", tag, options.count < 2 ? "the key" : "keys:", options.keys.map({return "'\($0)'"}))
        }
    }
}




