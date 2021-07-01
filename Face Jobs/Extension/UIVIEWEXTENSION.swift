//
//  UIVIEWEXTENSION.swift
//  Face Jobs
//
//  Created by Apple on 3/25/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
@IBInspectable var cornerRadius: CGFloat {
    get {
        return layer.cornerRadius
    } set {
        layer.cornerRadius = newValue
    }
}
}
