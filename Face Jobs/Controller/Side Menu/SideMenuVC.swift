//
//  SideMenuVC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/28/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import MOLH
import UIKit
import Alamofire

class SideMenuVC: UIViewController {

    //
    @IBOutlet weak var imageSide: UIImageView!
    @IBOutlet weak var nameSide: UILabel!
    @IBOutlet weak var emailSide: UILabel!
    @IBOutlet weak var waltSide: UILabel!
    
    @IBOutlet weak var FullView: UIView!
    @IBOutlet weak var ProfileView: UIView!
    @IBOutlet weak var JobView: UIView!

    @IBOutlet weak var ActionImageProfile: UIImageView!
    @IBOutlet weak var ActionImageJob: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        JobView.isHidden = true
        ProfileView.isHidden = true
        FullView.frame.size.height = 270
        ActionImageProfile.image = UIImage(named: "Action Side menu left")
        ActionImageJob.image = UIImage(named: "Action Side menu left")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        GetProfile()
    }
    
    @IBAction func ProfilePressed(_ sender: Any) {
        if ProfileView.isHidden == true{
            ProfileView.isHidden = false
            JobView.isHidden = true
            FullView.frame.size.height = 520
            ActionImageProfile.image = UIImage(named: "Action Side menu")
            ActionImageJob.image = UIImage(named: "Action Side menu left")
        }else{
            ProfileView.isHidden = true
            ActionImageProfile.image = UIImage(named: "Action Side menu left")
            ActionImageJob.image = UIImage(named: "Action Side menu left")
        }
    }
    @IBAction func JobsPressed(_ sender: Any) {
        if JobView.isHidden == true{
            JobView.isHidden = false
            ProfileView.isHidden = true
            FullView.frame.size.height = 470
            ActionImageProfile.image = UIImage(named: "Action Side menu left")
            ActionImageJob.image = UIImage(named: "Action Side menu")
        }else{
            JobView.isHidden = true
            ActionImageProfile.image = UIImage(named: "Action Side menu left")
            ActionImageJob.image = UIImage(named: "Action Side menu left")
        }
    }
}
extension SideMenuVC{
    @IBAction func BacicInfoPressed(_ sender: Any) {
        ShareViewController(withIdentifier: "BasicInfoPage")
    }
    @IBAction func AddressPressed(_ sender: Any) {
        ShareViewController(withIdentifier: "AddressPage")
    }
    @IBAction func SocialPressed(_ sender: Any) {
        ShareViewController(withIdentifier: "SocialPage")
    }
    @IBAction func SettingPressed(_ sender: Any) {
        ShareViewController(withIdentifier: "SettingPage")
    }
    @IBAction func GalleryPressed(_ sender: Any) {
        ShareViewController(withIdentifier: "GalleryPage")
    }
    @IBAction func DocumentPressed(_ sender: Any) {
        ShareViewController(withIdentifier: "DocumentPage")
    }
}
extension SideMenuVC{
    @IBAction func PendingJobPressed(_ sender: Any) {
        ShareViewController(withIdentifier: "PendingPage")
    }
    @IBAction func CurrentJonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func JobApplicationPressed(_ sender: Any) {
    }
    @IBAction func PreviousJobPressed(_ sender: Any) {
        ShareViewController(withIdentifier: "previousPage")
    }
    @IBAction func EmergencyPressed(_ sender: Any) {
        ShareViewController(withIdentifier: "EmergencyPage")        
    }
}
extension SideMenuVC{
    
    @IBAction func AddJobPressed(_ sender: Any) {
        ShareViewController(withIdentifier: "AddJobPage")
    }
    @IBAction func inivitFriendPressed(_ sender: UIButton) {
        guard let url = URL(string: "https://apps.apple.com/us/app/key-by-amazon/id1291586307") else {
            return
        }
        let items: [Any] = ["FaceJobs", url, #imageLiteral(resourceName: "Logo Backgound")]
        let vc = VisualActivityViewController(activityItems: items, applicationActivities: nil)
        vc.previewNumberOfLines = 10
        
        presentActionSheet(vc, from: sender)
    }
    @IBAction func AboutPressed(_ sender: Any) {
        ShareViewController(withIdentifier: "contactusPage")
    }
    @IBAction func logoutPressed(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "isLogin")
        defaults.removeObject(forKey: "AccessToken")
        defaults.synchronize()
        Share.savedToken = nil
        UserDefaults.standard.set(Share.savedToken, forKey: "AccessToken")
        UserDefaults.standard.synchronize()
        self.ShareViewController(withIdentifier: "loginPage")
    }
}
extension SideMenuVC{
    func GetProfile(){
        self.emailSide.text = Share.Profile_Email
        self.nameSide.text = Share.Profile_Name
        
        Share.instance.SetimageWithCorner(Path: Share.Profile_Image, Image: self.imageSide)

        if Share.Profile_Coin == 0.0{
            if Share.Profile_wallet == 0.0{
                self.waltSide.text = ""
            }else{
                self.waltSide.text = "Wallet: \(Share.Profile_wallet)"
            }
        }else{
            if Share.Profile_wallet == 0.0{
                self.waltSide.text = "Coin: \(Share.Profile_Coin)"

            }else{
                self.waltSide.text = "Coin: \(Share.Profile_Coin), Wallet: \(Share.Profile_wallet)"
            }
        }
    }
}
extension SideMenuVC{
    private func presentActionSheet(_ vc: VisualActivityViewController, from view: UIView) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            vc.popoverPresentationController?.sourceView = view
            vc.popoverPresentationController?.sourceRect = view.bounds
            vc.popoverPresentationController?.permittedArrowDirections = [.right, .left]
        }
        present(vc, animated: true, completion: nil)
    }
}
