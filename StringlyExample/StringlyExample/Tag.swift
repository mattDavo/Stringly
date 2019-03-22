//
//  Tag.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 19/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation

struct Tag: CustomStringConvertible {
    
    private var stringly: Stringly
    
    var tag: String
    var options: [String: String]
    
    var content: String
    
    init(content: String, stringly: Stringly = Stringly.shared) {
        self.content = content
        self.stringly = stringly
        
        let tagRegex = try? NSRegularExpression(pattern: "^/?(?<tag>\\w+)", options: .caseInsensitive)
        let fieldRegex = try? NSRegularExpression(pattern: "\\w+=\".*?\"", options: .caseInsensitive)
        let fieldKeyValueRegex = try? NSRegularExpression(pattern: "(?<key>\\w+)=\"(?<value>.*?)\"", options: .caseInsensitive)
        
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
        if let defaultTag = DefaultTag(rawValue: tag) {
            let tagType = defaultTag.getTagType(stringly: stringly)
            tagType.applyAttributes(to: text, withOptions: options)
        }
        else if let tagType = stringly.customTags[tag] {
            tagType.applyAttributes(to: text, withOptions: options)
        }
        else {
            print("TODO: Write warnings")
        }
    }
}
