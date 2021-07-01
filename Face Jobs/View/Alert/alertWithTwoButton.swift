//
//  alertWithTwoButton.swift
//  Face Jobs
//
//  Created by Apple on 3/3/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import UIKit
protocol alertOkButtonTapped: AnyObject {
    func handleTapped()
}
class alertWithTwoButton: UIViewController {

    @IBOutlet var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    weak var delegate: alertOkButtonTapped?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
    }
    private func setUpView()
    {
        alertView.layer.cornerRadius = 6
        alertView.layer.masksToBounds = true
        img.layer.cornerRadius = img.bounds.width / 2
        img.layer.masksToBounds = true
    }
    @IBAction func ok_tapped(_ sender: Any) {
        self.removeFromParent()
        self.view.removeFromSuperview()
        delegate?.handleTapped()
        
    }
    
    @IBAction func onClickDone(_ sender: Any) {
        self.removeFromParent()
        self.view.removeFromSuperview()
        self.willMove(toParent: nil)
        
    }
    
}

