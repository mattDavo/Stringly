//
//  ViewController.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 18/3/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import UIKit

let content =
"""
<h1>This is <b size="40">heading</b> 1</h1>
<h2>This is heading 2</h2>
<h3><u>This is heading 3</u></h3>
<h4>This is <i>heading</i> 4</h4>
<h5>This is <h5 color="#ff0000a0">heading</h5> 5</h5>
<h6>This is heading 6</h6>
"""


enum DefaultTag: String {
    case h1 = "h1"
    case h2 = "h2"
    case h3 = "h3"
    case h4 = "h4"
    case h5 = "h5"
    case h6 = "h6"
    case h7 = "h7"
    case b = "b"
    case u = "u"
    case i = "i"
    
    var defaultFont: UIFont {
        return UIFont.systemFont(ofSize: 12)
    }
    
    func applyAttributes(to text: NSMutableAttributedString, withOptions options: [String: String]) {
        var attr: [NSAttributedString.Key: Any] = [:]
        var font = text.attributes(at: 0, effectiveRange: nil)[NSAttributedString.Key.font] as! UIFont
        switch self {
        case .h1:
            attr[NSAttributedString.Key.font] = font.withSize(30)
            break
        case .h2:
            attr[NSAttributedString.Key.font] = font.withSize(27)
            break
        case .h3:
            attr[NSAttributedString.Key.font] = font.withSize(24)
            break
        case .h4:
            attr[NSAttributedString.Key.font] = font.withSize(21)
            break
        case .h5:
            attr[NSAttributedString.Key.font] = font.withSize(18)
            break
        case .h6:
            attr[NSAttributedString.Key.font] = font.withSize(16)
            break
        case .h7:
            attr[NSAttributedString.Key.font] = font.withSize(14)
            break
        case .b:
            if let boldFontName = options["font"] {
                font = UIFont(name: boldFontName, size: font.pointSize)!
            }
            else {
                font = UIFont.boldSystemFont(ofSize: font.pointSize)
            }
            if let size = options["size"], let fontSize: CGFloat = NumberFormatter().number(from: size) as? CGFloat {
                font = font.withSize(fontSize)
            }
            attr[.font] = font
            break
        case .u:
            attr[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.single.rawValue
            attr[NSAttributedString.Key.underlineColor] = UIColor.black
            break
        case .i:
            if let italicFontName = options["font"] {
                font = UIFont(name: italicFontName, size: font.pointSize)!
            }
            else {
                font = UIFont.italicSystemFont(ofSize: font.pointSize)
            }
            
            attr[.font] = font
            break
        }
        if let color = options["color"] {
            attr[.foregroundColor] = UIColor.fromHexString(color)
        }
        text.addAttributes(attr, range: text.string.range)
    }
    
    

}

class ViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textView.attributedText = content.format()
    }
}

