//
//  TagAttribute.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 22/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import UIKit

public protocol TagAttribute {
    
    func applyAttribute(to text: NSMutableAttributedString)
}

public protocol TextViewTagAttribute: TagAttribute {
    
    func applyAttribute(to text: NSMutableAttributedString, forTextView textView: UITextView)
}

extension TextViewTagAttribute {
    
    public func applyAttribute(to text: NSMutableAttributedString) {
        // Nothing
    }
}
