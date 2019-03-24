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
<h1>This is <b font-size="40">heading</b> 1</h1>
<h2>This is <h2 highlight="#ff0000a0">heading 2</h2></h2>
<h3><u>This is heading 3</u></h3>
<h4>This is <i>heading</i> 4</h4>
<h5>This is <h5 color="#ff0000a0">heading</h5> 5</h5>
<h6>This is heading 6</h6>
<t font-style="footnote">Footnote</t>
<t underline-style="double,patternDash" font-size="20">Testing, yahoo!</t>
<t font="Helvetica Neue" font-size="20">Testing, yahoo!</t>
"""

class ViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textView.attributedText = content.format()
        
        let range: NSRange = (textView.text as NSString).range(of: "heading 2")
        let start: UITextPosition? = textView.position(from: textView.beginningOfDocument, offset: range.location)
        let end: UITextPosition? = textView.position(from: start!, offset: range.length)
        let textRange: UITextRange? = textView.textRange(from: start!, to: end!)
        let rect: CGRect = textView.firstRect(for: textRange!)
        
        let v = UIView(frame: rect)
        v.backgroundColor = UIColor.red.withAlphaComponent(0.5)
//        textView.addSubview(v)
    }
}

