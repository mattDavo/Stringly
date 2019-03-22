//
//  CGFloat+LosslessStringConvertible.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 22/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat: LosslessStringConvertible {
    
    public init?<S>(_ text: S) where S : StringProtocol {
        if let doubleVal = Double(text) {
            self.init(doubleVal)
        }
        else {
            return nil
        }
    }
}
