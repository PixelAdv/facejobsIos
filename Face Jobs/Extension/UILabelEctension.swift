//
//  UILabelEctension.swift
//  Face Jobs
//
//  Created by Apple on 2/24/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import UIKit
extension UILabel {
    @IBInspectable var localizationKey: String {
        set {
            text = newValue.localized
        }
        get {
            return text!
        }
    }
}
