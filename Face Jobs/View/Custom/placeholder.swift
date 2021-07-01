//
//  placeholder.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 7/1/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import MOLH
import UIKit
import Foundation

//extension UIViewController: UITextViewDelegate{
//    static var placeholderLabel : UILabel!
////    
//    func setupPlaceholder(Message: UITextView, MessageString: String){
//        Message.delegate = self
//        UIViewController.placeholderLabel = UILabel()
//        UIViewController.placeholderLabel.text = MessageString
//        UIViewController.placeholderLabel.sizeToFit()
//        Message.addSubview(UIViewController.placeholderLabel)
//        UIViewController.placeholderLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        UIViewController.placeholderLabel.isHidden = !Message.text.isEmpty
//        
//        if MOLHLanguage.currentAppleLanguage() == "ar"{
//            UIViewController.placeholderLabel.frame.origin = CGPoint(x: 100, y: (Message.font?.pointSize)! / 2)
//            UIViewController.placeholderLabel.textAlignment = .right
//        }else{
//            UIViewController.placeholderLabel.frame.origin = CGPoint(x: 5, y: (Message.font?.pointSize)! / 2)
//            UIViewController.placeholderLabel.textAlignment = .left
//        }
//    }
//    public func textViewDidChange(_ textView: UITextView) {
//        UIViewController.placeholderLabel.isHidden = !textView.text.isEmpty
//    }
//}
