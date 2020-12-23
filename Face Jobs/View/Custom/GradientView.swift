//
//  File.swift
//  IMIE App
//
//  Created by Eslam Hassan on 11/20/19.
//  Copyright © 2019 Eslam Hassan. All rights reserved.
//

import UIKit
import Foundation
@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var startColor:   UIColor = #colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1) { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1) { didSet { updateColors() }}
//    @IBInspectable var startColorB:   UIColor = .blue { didSet { updateColors() }}
//    @IBInspectable var endColorB:     UIColor = .orange { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}

    override public class var layerClass: AnyClass { CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}
