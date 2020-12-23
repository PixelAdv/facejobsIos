//
//  ContactusVC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 7/21/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit

class ContactusVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addingGradientLayerToNavigationBar([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor])
    }
    @IBAction func BackPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func ChatPressed(_ sender: Any) {
        ShareViewController(withIdentifier: "chatPage")
    }
    @IBAction func faceBookPressed(_ sender: UIButton) {
        UIApplication.tryURL(urls: [
                        "fb://profile/116374146706", // App
                        "http://www.facebook.com/116374146706" // Website if app fails
        ])
    }
    @IBAction func linkedInPressed(_ sender: Any) {
        UIApplication.tryURL(urls: [
                        "linkedin://profile/yourName-yourLastName-yourID", // App
                        "https://www.linkedin.com/in/yourName-yourLastName-yourID/" // Website if app fails
        ])
    }
    @IBAction func instagramPressed(_ sender: Any) {
        UIApplication.tryURL(urls: [
                        "instagram://user?username=johndoe", // App
                        "http://instagram.com/" // Website if app fails
        ])
    }
    @IBAction func twitterPressed(_ sender: Any) {
        UIApplication.tryURL(urls: [
                        "twitter://user?screen_name=\(10)", // App
                        "https://twitter.com/\(10)/" // Website if app fails
        ])
    }
    @IBAction func whatsappPressed(_ sender: Any) {
        let phoneNumber =  "+989160000000"
        UIApplication.tryURL(urls: [
                        "https://api.whatsapp.com/send?phone=\(phoneNumber)", // App
                        "https://wa.me/\(phoneNumber)" // Website if app fails
        ])
    }
    
}
extension UIApplication {
    class func tryURL(urls: [String]) {
        let application = UIApplication.shared
        for url in urls {
            if application.canOpenURL(URL(string: url)!) {
                if #available(iOS 10.0, *) {
                    application.open(URL(string: url)!, options: [:], completionHandler: nil)
                }
                else {
                    application.openURL(URL(string: url)!)
                }
                return
            }
        }
    }
}
