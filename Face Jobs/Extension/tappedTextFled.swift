//
//  tappedTextFled.swift
//  Face Jobs
//
//  Created by Apple on 4/8/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import Foundation
import UIKit
class TappedTextField:UITextField{
    weak var tapDelegate:TappedTextFieldDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))

            button.addTarget(self, action: #selector(TappedTextField.textFieldTapped), for: .touchUpInside)
            self.addSubview(button)
            
            
     
    }
    
    @objc func textFieldTapped(){
        tapDelegate?.textFieldDidTap(self)
    }
}


protocol TappedTextFieldDelegate:NSObject {
    func textFieldDidTap(_ textField:TappedTextField)
}
