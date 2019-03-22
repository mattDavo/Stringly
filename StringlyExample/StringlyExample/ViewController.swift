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

class ViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textView.attributedText = content.format()
    }
}

