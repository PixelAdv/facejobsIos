//
//  File.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/25/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func addingGradientLayerToNavigationBar(_ colorsArray: Array<Any>) {
        
        let currentNaviBar = navigationController?.navigationBar
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = (currentNaviBar?.bounds)!
        gradientLayer.colors = colorsArray
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        let gradientImage = UIImage.imageWithLayer(layer: gradientLayer)
        
        currentNaviBar?.setBackgroundImage(gradientImage, for: .default)
    }
    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
    func Get(){
        if let navigationBar = self.navigationController?.navigationBar {
            let gradient = CAGradientLayer()
            var bounds = navigationBar.bounds
            bounds.size.height += UIApplication.shared.statusBarFrame.size.height
            gradient.frame = bounds
            gradient.colors = [#colorLiteral(red: 0.794072628, green: 0.6424427032, blue: 0.3254654109, alpha: 1).cgColor, #colorLiteral(red: 0.7507275939, green: 0.5745082498, blue: 0.2338451147, alpha: 1).cgColor, #colorLiteral(red: 0.7507275939, green: 0.5745082498, blue: 0.2338451147, alpha: 1).cgColor, #colorLiteral(red: 0.8690779805, green: 0.7525758147, blue: 0.466111362, alpha: 1).cgColor, #colorLiteral(red: 0.7507275939, green: 0.5745082498, blue: 0.2338451147, alpha: 1).cgColor, #colorLiteral(red: 0.7507275939, green: 0.5745082498, blue: 0.2338451147, alpha: 1).cgColor, #colorLiteral(red: 0.7507275939, green: 0.5745082498, blue: 0.2338451147, alpha: 1).cgColor]
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 0)

            if let image = getImageFrom(gradientLayer: gradient) {
                navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
            }
        }
    }

}
extension UIImage {
    class func imageWithLayer(layer: CALayer) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(layer.bounds.size, layer.isOpaque, 0.0)
        layer.render(in:UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
