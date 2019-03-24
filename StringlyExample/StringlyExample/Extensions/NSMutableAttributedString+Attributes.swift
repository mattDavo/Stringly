//
//  NSMutableAttributedString+Attributes.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 22/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation

extension NSMutableAttributedString {
    
    func fullRangeAttributes() -> [NSAttributedString.Key: Any] {
        if self.string.count == 0 {
            return [:]
        }
        return self.attributes(at: 0, effectiveRange: nil)
    }
}
