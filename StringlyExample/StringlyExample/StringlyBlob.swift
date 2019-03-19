//
//  StringlyBlob.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 19/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import UIKit

class StringlyBlob: CustomStringConvertible {
    
    private var tags = [Tag]()
    
    private var _formattedText: NSAttributedString!
    
    var text: String
    
    var formattedText: NSAttributedString {
        return _formattedText
    }
    
    init(text: String, tags: [Tag]) {
        self.text = text
        self.tags = tags
        self._formattedText = self.getFormattedText()
    }
    
    func addTag(_ tag: Tag) {
        tags.append(tag)
    }
    
    var description: String {
        return "<\(type(of: self)): text = \(text), tags = [\(tags.map { (t) -> String in return t.description }.joined(separator: ","))]>"
    }
    
    private func getFormattedText() -> NSAttributedString {
        let formattedText = NSMutableAttributedString(string: text)
        formattedText.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 12), range: text.range)
        
        for tag in tags {
            formattedText.applyTag(tag)
        }
        
        return formattedText
    }
}
