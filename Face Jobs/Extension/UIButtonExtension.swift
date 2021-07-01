//
//  UIButtonExtension.swift
//  Face Jobs
//
//  Created by Apple on 2/24/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
extension UIButton {
    @IBInspectable var localizationKey: String {
        set {
            setTitle(newValue.localized, for: .normal)
        }
        get {
            return (titleLabel?.text)!
        }
    }
}
