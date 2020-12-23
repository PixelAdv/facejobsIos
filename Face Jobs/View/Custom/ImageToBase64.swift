//
//  image.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/28/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit
import Foundation

extension UIImage {
    func ImageToBase64() -> String?{
        let ImgCompData = self.jpegData(compressionQuality:0.1)
        let Img2SendData = ImgCompData?.base64EncodedString(options: .lineLength64Characters)
        return Img2SendData
    }
}

extension String {

    func base64ToImage() -> UIImage? {
        let dataDecode:NSData = NSData(base64Encoded: self, options:.ignoreUnknownCharacters)!
        return UIImage(data: dataDecode as Data)
    }
}
