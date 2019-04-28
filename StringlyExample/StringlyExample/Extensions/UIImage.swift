//
//  UIImage.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 25/4/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func isHorizontal() -> Bool {
        return imageOrientation.isHorizontal()
    }
}

extension UIImage.Orientation {
    
    func isHorizontal() -> Bool {
        return [UIImage.Orientation.left, UIImage.Orientation.leftMirrored, UIImage.Orientation.right, UIImage.Orientation.rightMirrored].contains(self)
    }
}
