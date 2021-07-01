//
//  SocialVC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/28/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit
import Alamofire
class SocialVC: MainViewController {

    @IBOutlet weak var facebookText: UITextField!
    @IBOutlet weak var twitterText: UITextField!
    @IBOutlet weak var instgramText: UITextField!
    @IBOutlet weak var linkedinText: UITextField!
    @IBOutlet weak var websiteText: UITextField!
    @IBOutlet weak var otherText: UITextField!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var backBTN: UIBarButtonItem!
    let userType = UserDefaults.standard.integer(forKey: "USERTYPE")
    let constant = Constants.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        getSocial()
        getRadius()
        setUpView()
    }

    private func setUpView()
    {
        addingGradientLayerToNavigationBar([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor])
        title = "social".localized
        if constant.isArabic() {
            backBTN.image = UIImage(named: "backRight")
        }
    }
    private func getSocial()
    {
        userType == 1 ? GetEmployeeSocial() : GetSocial()
    }
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SocialPressed(_ sender: Any) {
        userType == 1 ? AddEmployeeSocial(facebook: facebookText.text ?? "", twitter: twitterText.text ?? "", instagram: instgramText.text ?? "", linkedIn: linkedinText.text ?? "", website: websiteText.text ?? "", other: otherText.text ?? "") : AddSocial(facebook: facebookText.text ?? "", twitter: twitterText.text ?? "", instagram: instgramText.text ?? "", linkedIn: linkedinText.text ?? "", website: websiteText.text ?? "", other: otherText.text ?? "")
    }
    
}
extension SocialVC{
    func GetSocial(){
        showProgress()
        AF.request(APIRouter.GetSocialRouter(Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<SocialCodable, AFError>) in
                self.dismisProgress()
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        self.facebookText.text = model.data?.facebook ?? ""
                        self.twitterText.text = model.data?.twitter ?? ""
                        self.instgramText.text = model.data?.instagram ?? ""
                        self.linkedinText.text = model.data?.linkedIn ?? ""
                        self.websiteText.text = model.data?.website ?? ""
                        self.otherText.text = model.data?.other ?? ""
                    }
                })
    }
    
    func AddSocial(facebook: String, twitter: String, instagram: String, linkedIn: String, website: String, other: String){
        showProgress()
        AF.request(APIRouter.EditSocialRouter(Facebook: facebook, Twitter: twitter, Instagram: instagram, LinkedIn: linkedIn, Website: website, Other: other, Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<MessageCode, AFError>) in
                self.dismisProgress()
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if model.errorCode == 0 {
                            AlertView.instance.showAlert(message: "Successfully".localized, alertType: .success)
                        }else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
                        
                    }
                })
    }

}
extension SocialVC: UITextFieldDelegate{
    func getRadius() {
     let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didtapview(gesture:)))
        view.addGestureRecognizer(tapGesture)
        
        facebookText.attributedPlaceholder = NSAttributedString(string: "yourLinkHere".localized, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])

        twitterText.attributedPlaceholder = NSAttributedString(string: "yourLinkHere".localized, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])

        instgramText.attributedPlaceholder = NSAttributedString(string: "yourLinkHere".localized, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])

        linkedinText.attributedPlaceholder = NSAttributedString(string: "yourLinkHere".localized, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])

        websiteText.attributedPlaceholder = NSAttributedString(string: "yourLinkHere".localized, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
        
        otherText.attributedPlaceholder = NSAttributedString(string: "yourLinkHere".localized, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        facebookText.resignFirstResponder()
        twitterText.resignFirstResponder()
        instgramText.resignFirstResponder()
        linkedinText.resignFirstResponder()
        websiteText.resignFirstResponder()
        otherText.resignFirstResponder()
        
        return true
    }
    
    @objc func didtapview(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterKeyboardNotifications()
    }
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardDidShow(notification:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func keyboardDidShow(notification: NSNotification) {
        print("keyboard seen")
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        ScrollView.contentInset = contentInsets
        ScrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        ScrollView.contentInset = UIEdgeInsets.zero
        ScrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
}

extension SocialVC {
    func GetEmployeeSocial(){
        showProgress()
        AF.request(APIRouter.GetEmployeeSocialRouter(Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<SocialCodable, AFError>) in
                self.dismisProgress()
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        self.facebookText.text = model.data?.facebook ?? ""
                        self.twitterText.text = model.data?.twitter ?? ""
                        self.instgramText.text = model.data?.instagram ?? ""
                        self.linkedinText.text = model.data?.linkedIn ?? ""
                        self.websiteText.text = model.data?.website ?? ""
                        self.otherText.text = model.data?.other ?? ""
                    }
                })
    }
    
    func AddEmployeeSocial(facebook: String, twitter: String, instagram: String, linkedIn: String, website: String, other: String){
        showProgress()
        AF.request(APIRouter.EditEmployeeSocialRouter(Facebook: facebook, Twitter: twitter, Instagram: instagram, LinkedIn: linkedIn, Website: website, Other: other, Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<MessageCode, AFError>) in
                self.dismisProgress()
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if model.errorCode == 0 {
                            AlertView.instance.showAlert(message: "Successfully".localized, alertType: .success)
                        }else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
                        
                    }
                })
    }
}
