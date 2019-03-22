//
//  Stringly.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 19/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import UIKit

public struct DefaultTags {
    var h1: TagType
    var h2: TagType
    var h3: TagType
    var h4: TagType
    var h5: TagType
    var h6: TagType
    var h7: TagType
    var b: TagType
    var u: TagType
    var i: TagType
    var img: TagType
}

public class Stringly {
    
    /**
     Returns the shared stringly object for the process.
     
     By default, you should interface with this for all Stringly customization. However, if you need different behaviour for different formatting of strings then you should create your own Stringly objects and customise them.
     */
    public static let shared = Stringly()
    
    // This needs to be implemented
    // Could potentially create TagType sub classes that have default attributes and options, to make this more concise.
    public let defaultTags = DefaultTags(
        h1: TagType(tag: "h1", attributes: [TagAttributeFontSize(fontSize: 30)], options: [TagOptionFontSize(), TagOptionTextColor()]),
        h2: TagType(tag: "h2", attributes: [TagAttributeFontSize(fontSize: 27)], options: [TagOptionFontSize(), TagOptionTextColor()]),
        h3: TagType(tag: "h3", attributes: [TagAttributeFontSize(fontSize: 24)], options: [TagOptionFontSize(), TagOptionTextColor()]),
        h4: TagType(tag: "h4", attributes: [TagAttributeFontSize(fontSize: 21)], options: [TagOptionFontSize(), TagOptionTextColor()]),
        h5: TagType(tag: "h5", attributes: [TagAttributeFontSize(fontSize: 18)], options: [TagOptionFontSize(), TagOptionTextColor()]),
        h6: TagType(tag: "h6", attributes: [TagAttributeFontSize(fontSize: 16)], options: [TagOptionFontSize(), TagOptionTextColor()]),
        h7: TagType(tag: "h7", attributes: [TagAttributeFontSize(fontSize: 14)], options: [TagOptionFontSize(), TagOptionTextColor()]),
        b: TagType(tag: "b", attributes: [TagAttributeBold()], options: [TagOptionFontSize(), TagOptionTextColor()]),
        u: TagType(tag: "u", attributes: [TagAttributeUnderline()], options: [TagOptionFontSize(), TagOptionTextColor()]),
        i: TagType(tag: "i", attributes: [TagAttributeItalic()], options: [TagOptionFontSize(), TagOptionTextColor()]),
        img: TagType(tag: "img", attributes: [], options: [])
    )
    
    private var _customTags = [String: TagType]()
    
    public var customTags: [String: TagType] {
        return _customTags
    }
    
    public func addCustomTag(_ tag: TagType) {
        if _customTags[tag.tag] != nil {
            print("TODO: Write warning of overwrite.")
        }
        _customTags[tag.tag] = tag
    }
    
    func format(text: String) -> NSAttributedString {
        var i = 0
        let chars = Array(text)
        
        var currentTags = [Tag]()
        
        var blob = ""
        
        var blobs = [StringlyBlob]()
        
        while i < chars.count {
            if chars[i] == "<" {
                // Get index of end of tag
                guard let tagEnd = chars.suffix(from: i).firstIndex(of: ">") else {
                    print("ERROR: Invalid XML, could not find closing '>'.")
                    return NSAttributedString(string: text)
                }
                
                // Get index of next slash
                guard let slash = chars.suffix(from: i).firstIndex(of: "/") else {
                    print("ERROR: Invalid XML, could not find closing '/'.")
                    return NSAttributedString(string: text)
                }
                
                // Create tag
                let tag = Tag(content: String(chars[i+1..<tagEnd]), stringly: self)
                
                // Write the stringly blob
                if blob.count > 0 {
                    blobs.append(StringlyBlob(text: blob, tags: currentTags))
                    blob = ""
                }
                
                // If it's an opening tag, add it to the stack
                if tagEnd < slash {
                    currentTags.append(tag)
                }
                    // If it's a closing tag, remove it from the stack
                else if slash == i + 1 {
                    currentTags.removeLast()
                }
                
                i = tagEnd + 1
            }
            else {
                blob.append(chars[i])
                i += 1
            }
        }
        
        if blobs.count > 0 {
            print("WARNING: Invalid XML")
        }
        
        let str = NSMutableAttributedString(string: "")
        
        for sBlob in blobs {
            print(sBlob)
            str.append(sBlob.formattedText)
        }
        
        return str
    }
}
