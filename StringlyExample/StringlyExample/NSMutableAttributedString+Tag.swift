//
//  NSMutableAttributedString+Tag.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 19/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation

extension NSMutableAttributedString {
    
    func applyTag(_ tag: Tag) {
        tag.applyAttributes(to: self)
    }
    
}
