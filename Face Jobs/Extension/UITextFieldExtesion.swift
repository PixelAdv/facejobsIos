//
//  UITextFieldExtesion.swift
//  Face Jobs
//
//  Created by Apple on 2/24/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import Foundation
import UIKit
import MOLH
extension UITextField {
    @IBInspectable
    var isLocalized: Bool {
        get {
            return false
        } set {
            if newValue == true {
                if MOLHLanguage.isArabic() {
                    textAlignment = .right
                    makeTextWritingDirectionRightToLeft(self)
                    contentHorizontalAlignment = .right
                } else {
                    textAlignment = .left
                    makeTextWritingDirectionLeftToRight(self)
                    contentHorizontalAlignment = .left
                }
            }
        }
    }

    @IBInspectable var localizationKey: String {
        set {
            placeholder = newValue.localized
        }
        get {
            return placeholder!
        }
    }

    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

