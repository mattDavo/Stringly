//
//  String+Regex.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 19/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation

extension String {
    
    var range: NSRange {
        return NSRange(location: 0, length: self.count)
    }
    
    func firstMatch(withRegex regex: NSRegularExpression) -> String {
        if let match = regex.firstMatch(in: self, options: [], range: self.range) {
            if let range = Range(match.range, in: self) {
                return String(self[range])
            }
        }
        
        print("Failed to match")
        
        return ""
    }
    
    func matches(withRegex regex: NSRegularExpression) -> [String] {
        return regex.matches(in: self, options: [], range: self.range).map({ (m) -> String in
            return String(self[Range(m.range, in: self)!])
        })
    }
    
    func matches(withRegex regex: NSRegularExpression, withKeys keys: [String]) -> [String: String] {
        var pairs = [String: String]()
        if let match = regex.firstMatch(in: self, options: [], range: self.range) {
            for key in keys {
                if let range = Range(match.range(withName: key), in: self) {
                    pairs[key] = String(self[range])
                }
            }
        }
        return pairs
    }
}
