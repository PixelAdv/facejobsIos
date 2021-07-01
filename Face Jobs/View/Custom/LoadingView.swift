//
//  LoadingView.swift
//  Face Jobs
//
//  Created by Apple on 3/4/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import UIKit

class LoadingView: UIViewController {

    @IBOutlet weak var loader: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
//    func showLoader()
//    {
//        loader.startAnimating()
//        
//    }
    func hideLoader()
    {
        loader.stopAnimating()
        self.view.removeFromSuperview()
        self.removeFromParent()
    }


}
