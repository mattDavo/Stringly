//
//  AsyncTagOption.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 28/4/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import UIKit

public protocol AsyncTagOption {
    
    var key: String { get }
    
    var waitKey: String { get }
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String, forTextView textView: UITextView?,  onCompletion: @escaping (NSMutableAttributedString) -> ())
}
