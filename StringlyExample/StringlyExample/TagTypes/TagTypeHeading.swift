//
//  TagTypeHeading.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 24/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import UIKit

public class TagTypeHeading: TagTypeText {
    
    init(tag: String, fontSize: CGFloat, attributes: [TagAttribute] = [], options: [TagOption] = []) {
        super.init(tag: tag, attributes: attributes, options: options)
        
        self.attributes.append(TagAttributeFontSize(fontSize: fontSize))
    }
    
}
