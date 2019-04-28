//
//  TagTypeText.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 24/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation

public class TagTypeText: TagType {
    
    public let defaultAttributes: [TagAttribute] = []
    
    public var defaultOptions: [TagOption] = [
        TagOptionFont(),
        TagOptionFontSize(),
        TagOptionTextColor(),
        TagOptionTextHighlight(),
        TagOptionFontStyle(),
        TagOptionUnderlineStyle(),
        TagOptionUnderlineColor(),
        TagOptionStrikethroughStyle(),
        TagOptionStrikethroughColor(),
        TagOptionTextAlignment()
    ]
    
    override init(tag: String, attributes: [TagAttribute], options: [TagOption]) {
        super.init(tag: tag, attributes: attributes, options: options)
        
        self.attributes = defaultAttributes + self.attributes
        self.options = defaultOptions + self.options
    }
}
