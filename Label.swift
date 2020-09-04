//
//  Label.swift
//
//  Created by cho on 2020/09/03.
//  Copyright © 2020 chominsu. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func addBold() {
        let size = font.pointSize
        font = UIFont.boldSystemFont(ofSize: size)
    }
    
    func addRegular() {
        let size = font.pointSize
        font = UIFont.systemFont(ofSize: size)
    }
    
    func changeLabelColor(highlightColor color: UIColor, text txt: String) {
        if let text = text {
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(.foregroundColor, value: color, range: (text as NSString).range(of:txt))
            attributedText = attributedString
        }
    }

    func changeLabelBold(fontSize size:CGFloat, text txt:String) {
        if let labelText = text {
            let attributedString = NSMutableAttributedString(string: labelText)
            let fontSize = UIFont.systemFont(ofSize: size)
            attributedString.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: fontSize, range: (labelText as NSString).range(of:txt))
            attributedText = attributedString
        }
    }

    
}
