//
//  EmergencyVC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 7/21/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit

class EmergencyVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addingGradientLayerToNavigationBar([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor])
    }
    
    @IBAction func BackPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
