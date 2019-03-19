//
//  Tag.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 19/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation

struct Tag: CustomStringConvertible {
    
    var tag: String
    var attributes: [String: String]
    
    var content: String
    
    init(content: String) {
        self.content = content
        
        let tagRegex = try? NSRegularExpression(pattern: "^/?(?<tag>\\w+)", options: .caseInsensitive)
        let fieldRegex = try? NSRegularExpression(pattern: "\\w+=\".*?\"", options: .caseInsensitive)
        let fieldKeyValueRegex = try? NSRegularExpression(pattern: "(?<key>\\w+)=\"(?<value>.*?)\"", options: .caseInsensitive)
        
        self.tag = content.firstMatch(withRegex: tagRegex!).lowercased()
        self.attributes = [:]
        
        for i in content.matches(withRegex: fieldRegex!) {
            let kvps = i.matches(withRegex: fieldKeyValueRegex!, withKeys: ["key", "value"])
            attributes[kvps["key"]!] = kvps["value"]!
        }
    }
    
    var description: String {
        return "<\(content)>"
    }
    
    func applyAttributes(to text: NSMutableAttributedString) {
        if let tagType = DefaultTag(rawValue: tag) {
            tagType.applyAttributes(to: text, withOptions: attributes)
        }
        
    }
}
