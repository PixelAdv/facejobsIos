//
//  UiViewController.swift
//  Face Jobs
//
//  Created by Apple on 3/3/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
    
}
