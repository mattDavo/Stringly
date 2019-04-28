//
//  String+Stringly.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 19/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation

extension String {
    
    func format(stringly: Stringly = Stringly.shared) -> NSAttributedString {
        return stringly.format(text: self)
    }
}
