//
//  TableView.swift
//
//  Created by cho on 2020/09/03.
//  Copyright © 2020 chominsu. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func setReFresh() -> UIRefreshControl {
        let refresh = UIRefreshControl()
        
        if #available(iOS 10.0, *) {
            refreshControl = refresh
        } else {
            addSubview(refresh)
        }
        return refresh
    }
}
