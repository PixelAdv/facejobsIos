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
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        startTimer()
       
//        autoScroll()
    }
    private func setUpView()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            if Share.isLogin {
                
//                let HomeScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FilterViewController")
                let HomeScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeSecreen")
                let navigationController = UINavigationController(rootViewController: HomeScreen)
                navigationController.modalPresentationStyle = .fullScreen
            UIApplication.shared.windows.first?.rootViewController = navigationController
                
        }
        else {
            let loginPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "loginPage")
            loginPage.modalPresentationStyle = .fullScreen
        UIApplication.shared.windows.first?.rootViewController = loginPage
        }
        }
    }
    
    func startTimer() {
        _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc
    func autoScroll() {
        if Connectivity.isConnectedToInternet {
            if Share.isLogin{
                self.ShareViewController(withIdentifier: "HomeSecreen")
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
