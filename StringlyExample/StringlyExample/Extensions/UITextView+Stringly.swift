//
//  UITextView+Stringly.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 25/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    
    func format(text: String, withStringly stringly: Stringly = Stringly.shared) {
        attributedText = stringly.format(text: text, textView: self)
    }
    
    var contentWidth: CGFloat {
        let xPadding = contentInset.left + contentInset.right + textContainerInset.left + textContainerInset.right + 2*textContainer.lineFragmentPadding
        return frame.width - xPadding
    }
}
