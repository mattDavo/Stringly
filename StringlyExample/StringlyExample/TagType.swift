//
//  TagType.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 22/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import os.log

public class TagType {
    
    public var tag: String
    
    public var attributes: [TagAttribute]
    
    public var options: [String: TagOption]
    
    init(tag: String, attributes: [TagAttribute], options: [TagOption]) {
        self.tag = tag
        self.attributes = attributes
        self.options = options.reduce([String: TagOption](), { (options, option) -> [String: TagOption] in
            var options = options
            options[option.key] = option
            return options
        })
    }
    
    public func addAttribute(_ attribute: TagAttribute) {
        attributes.append(attribute)
    }
    
    public func addOption(_ option: TagOption) {
        if options.keys.contains(option.key) {
            os_log(.error, "Warning: Already have an option with key '%s', overriding...", option.key)
        }
        options[option.key] = option
    }
    
    public func applyStyle(to text: NSMutableAttributedString, withOptions options: [String: String]) {
        // Apply standard attributes
        for attribute in attributes {
            attribute.applyAttribute(to: text)
        }
        
        // Apply options
        for (key, value) in options {
            if let option = self.options[key] {
                option.applyOption(to: text, withValue: value)
            }
            else {
                os_log(.error, "Warning: There are no options for tag '%s' with key '%s'.", tag, key)
            }
        }
    }
}




