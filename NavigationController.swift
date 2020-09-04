//
//  NavigationController.swift
//  KeyFree
//
//  Created by cho on 2020/09/04.
//  Copyright © 2020 chominsu. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {

  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
      popToViewController(vc, animated: animated)
    }
  }

  func popViewControllers(viewsToPop: Int, animated: Bool = true) {
    if viewControllers.count > viewsToPop {
      let vc = viewControllers[viewControllers.count - viewsToPop - 1]
      popToViewController(vc, animated: animated)
    }
  }

}
