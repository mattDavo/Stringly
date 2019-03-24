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
    var t: TagType
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
    
    public let defaultTags = DefaultTags(
        t: TagTypeText(tag: "t", attributes: [], options: []),
        h1: TagTypeHeading(tag: "h1", fontSize: 30),
        h2: TagTypeHeading(tag: "h1", fontSize: 27),
        h3: TagTypeHeading(tag: "h1", fontSize: 24),
        h4: TagTypeHeading(tag: "h1", fontSize: 21),
        h5: TagTypeHeading(tag: "h1", fontSize: 18),
        h6: TagTypeHeading(tag: "h1", fontSize: 16),
        h7: TagTypeHeading(tag: "h1", fontSize: 14),
        b: TagTypeText(tag: "b", attributes: [TagAttributeBold()], options: []),
        u: TagTypeText(tag: "u", attributes: [TagAttributeUnderline()], options: []),
        i: TagTypeText(tag: "i", attributes: [TagAttributeItalic()], options: []),
        img: TagType(tag: "img", attributes: [], options: [])
    )
    
    func getTagType(withTag tag: String) -> TagType? {
        switch tag {
        case "t":
            return self.defaultTags.t
        case "h1":
            return self.defaultTags.h1
        case "h2":
            return self.defaultTags.h2
        case "h3":
            return self.defaultTags.h3
        case "h4":
            return self.defaultTags.h4
        case "h5":
            return self.defaultTags.h5
        case "h6":
            return self.defaultTags.h6
        case "h7":
            return self.defaultTags.h7
        case "b":
            return self.defaultTags.b
        case "u":
            return self.defaultTags.u
        case "i":
            return self.defaultTags.i
        case "img":
            return self.defaultTags.img
        default:
            return customTags[tag]
        }
    }
    
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
    
    public func format(text: String) -> NSAttributedString {
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
