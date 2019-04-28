//
//  AsyncTagOptionUrlImageSource.swift
//  StringlyExample
//
//  Created by Matthew Davidson on 28/4/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import Foundation
import UIKit

class TagOptionUrlImageSource: AsyncTagOption {
    
    var key = "url-src"
    
    var waitKey = "img-src"
    
    func applyOption(to text: NSMutableAttributedString, withValue value: String, forTextView textView: UITextView?, onCompletion: @escaping (NSMutableAttributedString) -> ()) {
        URLSession.shared.dataTask(with: URL(string: value)!) {
            (data: Data?, resposnse: URLResponse?, error: Error?) -> Void in
            guard let data = data, error == nil else {
                // Call the completion handler when you've failed
                print("FAILED")
                onCompletion(text)
                return
            }
            DispatchQueue.main.async {
                // And call the completion handler when you've succeded
                if let image = UIImage(data: data) {
                    let textAttachment = NSTextAttachment()
                    textAttachment.image = image
                    
                    let oldWidth = textAttachment.image!.size.width;
                    
                    // For the padding inside the textView
                    let scaleFactor = oldWidth / (textView?.contentWidth ?? oldWidth)
                    let image = UIImage(cgImage: textAttachment.image!.cgImage!, scale: scaleFactor, orientation: .up)
                    textAttachment.image = image
                    let attrStringWithImage = NSAttributedString(attachment: textAttachment)
                    text.replaceCharacters(in: NSRange(location: 0, length: text.length), with: attrStringWithImage)
                }
                onCompletion(text)
                return
            }
            }.resume()
    }
}
