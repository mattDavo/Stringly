//
//  String+Stringly.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 19/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation

extension String {
    
    func format() -> NSAttributedString {
        return Stringly.shared.format(text: self)
    }
}
