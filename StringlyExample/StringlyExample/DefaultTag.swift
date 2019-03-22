//
//  DefaultTag.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 22/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation

enum DefaultTag: String {
    case h1 = "h1"
    case h2 = "h2"
    case h3 = "h3"
    case h4 = "h4"
    case h5 = "h5"
    case h6 = "h6"
    case h7 = "h7"
    case b = "b"
    case u = "u"
    case i = "i"
    case img = "img"
    
    func getTagType(stringly: Stringly) -> TagType {
        switch self {
        case .h1:
            return stringly.defaultTags.h1
        case .h2:
            return stringly.defaultTags.h2
        case .h3:
            return stringly.defaultTags.h3
        case .h4:
            return stringly.defaultTags.h4
        case .h5:
            return stringly.defaultTags.h5
        case .h6:
            return stringly.defaultTags.h6
        case .h7:
            return stringly.defaultTags.h7
        case .b:
            return stringly.defaultTags.b
        case .u:
            return stringly.defaultTags.u
        case .i:
            return stringly.defaultTags.i
        case .img:
            return stringly.defaultTags.img
        }
    }
}
