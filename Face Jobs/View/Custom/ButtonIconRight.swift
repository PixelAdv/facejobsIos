//
//  File.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 7/7/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit
import Foundation

class ButtonIconRight: UIButton {
    override func imageRect(forContentRect contentRect:CGRect) -> CGRect {
        var imageFrame = super.imageRect(forContentRect: contentRect)
        imageFrame.origin.x = super.titleRect(forContentRect: contentRect).maxX - imageFrame.width
        return imageFrame
    }

    override func titleRect(forContentRect contentRect:CGRect) -> CGRect {
        var titleFrame = super.titleRect(forContentRect: contentRect)
        if (self.currentImage != nil) {
            titleFrame.origin.x = super.imageRect(forContentRect: contentRect).minX
        }
        return titleFrame
    }
}
