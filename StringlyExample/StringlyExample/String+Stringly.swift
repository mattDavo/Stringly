//
//  String+Stringly.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 19/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation

extension String {
    
    func format() -> NSAttributedString {
        var i = 0
        let chars = Array(self)
        
        var currentTags = [Tag]()
        
        var blob = ""
        
        var blobs = [StringlyBlob]()
        
        while i < chars.count {
            if chars[i] == "<" {
                // Get index of end of tag
                guard let tagEnd = chars.suffix(from: i).firstIndex(of: ">") else {
                    print("ERROR: Invalid XML, could not find closing '>'.")
                    return NSAttributedString(string: self)
                }
                
                // Get index of next slash
                guard let slash = chars.suffix(from: i).firstIndex(of: "/") else {
                    print("ERROR: Invalid XML, could not find closing '/'.")
                    return NSAttributedString(string: self)
                }
                
                // Create tag
                let tag = Tag(content: String(chars[i+1..<tagEnd]))
                
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
