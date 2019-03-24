//
//  TagOption.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 22/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import UIKit

public protocol TagOption {
    
    var key: String { get }
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String)
}

public protocol TextViewTagOption: TagOption {
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String, forTextView textView: UITextView)
}

extension TextViewTagOption {
    
    public func applyOption(to text: NSMutableAttributedString) {
        // Nothing
    }
}
