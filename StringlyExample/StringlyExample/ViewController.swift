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
<t font-size="20">You can also redact <r>stuff</r> if you like</t>

<img orientation="down" src="me"/>
"""

// To insert images and add popovers with control we will need a Stringly format() that takes a UITextView, so that it has total access to it, to get sizes, rects, add subviews, etc.

class ViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        textView.attributedText = content.format()
        
        textView.format(text: content)
        
        // Getting the rect of a string
        let range: NSRange = (textView.text as NSString).range(of: "heading 2")
        let start: UITextPosition? = textView.position(from: textView.beginningOfDocument, offset: range.location)
        let end: UITextPosition? = textView.position(from: start!, offset: range.length)
        let textRange: UITextRange? = textView.textRange(from: start!, to: end!)
        let rect: CGRect = textView.firstRect(for: textRange!)
        
        let v = UIView(frame: rect)
        v.backgroundColor = UIColor.red.withAlphaComponent(0.5)
//        textView.addSubview(v)
        
        
        
        
        
        // Inserting images
        let textAttachment = NSTextAttachment()
        textAttachment.image = UIImage(named: "me")!
        
        let oldWidth = textAttachment.image!.size.width;
        
        let scaleFactor = oldWidth / (textView.frame.size.width - 10); //for the padding inside the textView
        let image = UIImage(cgImage: textAttachment.image!.cgImage!, scale: scaleFactor, orientation: .up)
        textAttachment.image = image
        let attrStringWithImage = NSAttributedString(attachment: textAttachment)
        let mut = NSMutableAttributedString(attributedString: textView.attributedText)
        mut.append(attrStringWithImage)
//        mut.replaceCharacters(in: NSMakeRange(mut.string.count-1, 1), with: attrStringWithImage)
//        textView.attributedText = mut;
    }
}

