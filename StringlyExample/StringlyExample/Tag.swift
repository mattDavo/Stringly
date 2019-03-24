//
//  Tag.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 19/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import UIKit
import os.log

class Tag: CustomStringConvertible {
    
    private var stringly: Stringly
    
    var tag: String
    var options: [String: String]
    
    var content: String
    
    init(content: String, stringly: Stringly = Stringly.shared) {
        self.content = content
        self.stringly = stringly
        
        let tagRegex = try? NSRegularExpression(pattern: "^/?(?<tag>\\w+)", options: .caseInsensitive)
        let fieldRegex = try? NSRegularExpression(pattern: "\\S+=\".*?\"", options: .caseInsensitive)
        let fieldKeyValueRegex = try? NSRegularExpression(pattern: "(?<key>\\S+)=\"(?<value>.*?)\"", options: .caseInsensitive)
        
        self.tag = content.firstMatch(withRegex: tagRegex!).lowercased()
        self.options = [:]
        
        for i in content.matches(withRegex: fieldRegex!) {
            let kvps = i.matches(withRegex: fieldKeyValueRegex!, withKeys: ["key", "value"])
            options[kvps["key"]!] = kvps["value"]!
        }
    }
    
    var description: String {
        return "<\(content)>"
    }
    
    func applyAttributes(to text: NSMutableAttributedString) {
        if let tagType = stringly.getTagType(withTag: tag) {
            tagType.applyStyle(to: text, withOptions: options)
        }
        else {
            os_log(.error, "Error: There is no TagType defined in Stringly with the tag '%s'. Cannot correctly apply style to text '%s'", tag, text)
        }
    }
}
