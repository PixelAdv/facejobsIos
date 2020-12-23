//
//  AlertView.swift
//  CustomAlert
//
//  Created by SHUBHAM AGARWAL on 31/12/18.
//  Copyright © 2018 SHUBHAM AGARWAL. All rights reserved.
//

import Foundation
import UIKit
protocol callStoryboard {
    func GetStoryData()
}

class AlertView: UIView {
    
    static let instance = AlertView()
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    
    var delegate: callStoryboard?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        img.layer.cornerRadius = 30
        img.layer.borderColor = UIColor.white.cgColor
        img.layer.borderWidth = 2
        
        alertView.layer.cornerRadius = 10
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    enum AlertType {
        case success
        case failure
    }
    
    func showAlert(message: String, alertType: AlertType) {
        self.messageLbl.text = message
        
        switch alertType {
        case .success:
            img.image = UIImage(named: "Success")
            doneBtn.setTitle("Done" , for: .normal)
            doneBtn.layer.cornerRadius = CGFloat(Float(19.0));

        case .failure:
            img.image = UIImage(named: "failure")
            doneBtn.setTitle("Cancel" , for: .normal)
            doneBtn.layer.cornerRadius = CGFloat(Float(19.0));

        }
        
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    @IBAction func onClickDone(_ sender: Any) {
        parentView.removeFromSuperview()
    }
}
