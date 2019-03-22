//
//  TagAttribute.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 22/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation

public protocol TagAttribute {
    
    func applyAttribute(to text: NSMutableAttributedString)
}
