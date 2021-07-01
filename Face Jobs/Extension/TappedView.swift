//
//  TappedView.swift
//  Face Jobs
//
//  Created by Apple on 6/22/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import Foundation
import UIKit
protocol TappedViewDelegate:NSObject {
    
    func viewDidTap(_ view:TappedView)
}
class TappedView: UIView {
    
    weak var delegate:TappedViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isUserInteractionEnabled = true
              let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapAction))

              self.addGestureRecognizer(tap)
    }
    
    
    @objc private func tapAction(){
        
        delegate?.viewDidTap(self)
    }
}


