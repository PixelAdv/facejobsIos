//
//  ExtensionUIIamgeView.swift
//  Face Jobs
//
//  Created by Apple on 3/10/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
extension UIImageView {
    func loadImageFrom(imgUrl: String,placeholder:String = "logo login") {
        let strUrl = "\(APIRouter.baseURL)/\(imgUrl)".replacingOccurrences(of: "\\", with: "/")
        
        print("imagess",strUrl)
        if let url = URL(string: strUrl){
           self.kf.setImage(with: url, placeholder: UIImage(named: ""), options: [.transition(.fade(0.2))])
        }else{
            print("image url: nil \(strUrl)")
        }
       }
}
