//
//  View.swift
//
//  Created by cho on 2020/09/03.
//  Copyright © 2020 chominsu. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    // Example use: myView.addBorder(toSide: .Left, withColor: UIColor.redColor.CGColor, andThickness: 1.0)

    enum ViewSide {
        case left, right, top, bottom
    }

    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {

        let border = CALayer()
        border.backgroundColor = color

        switch side {
        case .left: border.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: thickness, height: self.frame.size.height)
        case .right: border.frame = CGRect(x: self.frame.size.width - thickness, y: self.frame.origin.y, width: thickness, height: self.frame.size.height)
        case .top: border.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: thickness)
        case .bottom: border.frame = CGRect(x: self.frame.origin.x, y: self.frame.size.height - thickness, width: self.frame.size.width, height: thickness)
        }
        self.layer.addSublayer(border)
    }
    
    func addBorder(forColor color: UIColor, forThickness tick: CGFloat) {
        self.layer.borderWidth = tick
        self.layer.borderColor = color.cgColor
    }
    
}

