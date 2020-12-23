//
//  LaunchScreenVC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/23/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit
import Alamofire

class LaunchScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startTimer()
    }
    
    func startTimer() {
        _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc
    func autoScroll() {
        if Connectivity.isConnectedToInternet {
            if Share.isLogin{
                self.ShareViewController(withIdentifier: "HomePage")
            }else {
                self.ShareViewController(withIdentifier: "loginPage")
            }
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }

}
class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
