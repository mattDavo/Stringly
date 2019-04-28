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
    
    public var asyncOptions: [AsyncTagOption]
    
    public var asyncWaitingOptions: [AsyncWaitingTagOption]
    
    init(tag: String, attributes: [TagAttribute], options: [TagOption], asyncOptions: [AsyncTagOption], asyncWaitingOptions: [AsyncWaitingTagOption]) {
        self.tag = tag
        self.attributes = attributes
        self.options = options
        self.asyncOptions = asyncOptions
        self.asyncWaitingOptions = asyncWaitingOptions
    }
    
    init(tag: String, attributes: [TagAttribute], options: [TagOption]) {
        self.tag = tag
        self.attributes = attributes
        self.options = options
        self.asyncOptions = []
        self.asyncWaitingOptions = []
    }
    
    public func addAttribute(_ attribute: TagAttribute) {
        attributes.append(attribute)
    }
    
    public func addOption(_ option: TagOption) {
        if options.map({return $0.key}).contains(option.key) {
            os_log("Warning: Already have an option with key '%s'. Will attempt to apply original then this new option.", log: .default, type: .error, option.key)
        }
        options.append(option)
    }
    
    public func applyStyle(to text: NSMutableAttributedString, withOptions options: [String: String], toTextView textView: UITextView? = nil, onAppliedAsync: ((NSMutableAttributedString) -> ())? = nil) {
        // Apply standard attributes
        for attribute in attributes {
            attribute.applyAttribute(to: text, forTextView: textView)
        }
        
        var options = options
        // Apply options in order as defined in the TagType
        for option in self.options {
            if let value = options.removeValue(forKey: option.key) {
                option.applyOption(to: text, withValue: value, forTextView: textView)
            }
        }
        
        // Apply Async tag options
        if let onAppliedAsync = onAppliedAsync {
            var completedAsyncOptions = [String]()
            for option in self.asyncOptions {
                if let value = options.removeValue(forKey: option.key) {
                    option.applyOption(to: text, withValue: value, forTextView: textView) {
                        (newText) -> Void in
                        // Apply the options that have been waiting on this async option
                        completedAsyncOptions.append(option.waitKey)
                        
                        for waitingOption in self.asyncWaitingOptions {
                            if let value = options[waitingOption.key] {
                                if waitingOption.waitOnOptions.filter({ return !completedAsyncOptions.contains($0) }).count == 0 {
                                    options.removeValue(forKey: option.key)
                                    
                                    waitingOption.applyOption(to: newText, withValue: value, forTextView: textView)
                                }
                            }
                        }
                        
                        // Call completion handler to handle how this string is now handled with its new formatting.
                        onAppliedAsync(newText)
                    }
                }
            }
        }
        
        let leftOverOptions = options.filter({return !self.asyncOptions.map({$0.key}).contains($0.key)}).filter({return !self.asyncWaitingOptions.map({$0.key}).contains($0.key)})
        
        if leftOverOptions.count > 0 {
            os_log("Warning: There are no options for tag '%s' with %s %s.", log: .default, type: .error, tag, leftOverOptions.count < 2 ? "the key" : "keys:", leftOverOptions.keys.map({return "'\($0)'"}).joined(separator: ", "))
        }
    }
}




