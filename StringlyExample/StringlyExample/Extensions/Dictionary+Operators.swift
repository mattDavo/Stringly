//
//  Dictionary+Operators.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 24/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation

// From: https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/Extensions/SwiftStdlib/DictionaryExtensions.swift
extension Dictionary {
    
    public static func +=(lhs: inout [Key: Value], rhs: [Key: Value]) {
        rhs.forEach({ lhs[$0] = $1})
        
    }
    
    public static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        var result = lhs
        rhs.forEach { result[$0] = $1 }
        return result
    }
}
