//
//  LoginVC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/23/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit
import Alamofire

class LoginVC: UIViewController {
    
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var CreateNewAccount: UIButton!
    @IBOutlet weak var ForgotPasswordBtn: UIButton!
    @IBOutlet weak var ScrollView: UIScrollView!
    
    @IBOutlet weak var loadingBtn: LoadingButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRadius()
    }
    
    @IBAction func LoginPressed(_ sender: Any) {
        if userNameText.text?.isEmpty == true{
            AlertView.instance.showAlert(message: "EmailPhoneRequired".localized, alertType: .failure)
        }else if passwordText.text?.isEmpty == true {
            AlertView.instance.showAlert(message: "PasswordRequired".localized, alertType: .failure)
        }else{
            GetLogin(Provider: userNameText.text ?? "", Password: passwordText.text ?? "", PushToken: "", OS: 0)
        }
    }
    
    @IBAction func RegisterPressed(_ sender: Any) {
        Share.UserTypeId = 1
        ShareViewController(withIdentifier: "RegisterPage")
    }
    
    @IBAction func ForgotPressed(_ sender: Any) {
        ShareViewController(withIdentifier: "ForgotPasswordPage")
    }
    
    @IBAction func JoinClientPressed(_ sender: Any) {
        Share.UserTypeId = 2
        ShareViewController(withIdentifier: "RegisterPage")
    }
}
extension LoginVC{
    func GetLogin(Provider: String, Password: String, PushToken: String, OS: Int){
        loadingBtn.showLoading()
        AF.request(APIRouter.loginRouter(Provider: Provider, Password: Password, PushToken: PushToken, OS: OS))
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<loginCodable, AFError>) in
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                        self.loadingBtn.hideLoading()
                    case .success(let model):
                        self.loadingBtn.hideLoading()
                        if model.errorCode == 0{
                            Share.savedToken = model.data?.token
                            UserDefaults.standard.set( Share.savedToken , forKey: "AccessToken")
                            UserDefaults.standard.synchronize()
                            UserDefaults.standard.set(true,forKey:"isLogin")
                            UserDefaults.standard.synchronize()
                            self.ShareViewController(withIdentifier: "HomePage")
                        }else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                        }
                    }
                })
    }
}
extension LoginVC: UITextFieldDelegate{
    func getRadius() {
     let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didtapview(gesture:)))
        view.addGestureRecognizer(tapGesture)
        userNameText.attributedPlaceholder = NSAttributedString(string: "EmailOrPhone".localized,
                                                            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)])
        passwordText.attributedPlaceholder = NSAttributedString(string: "Password".localized,
                                                            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameText.resignFirstResponder()
        passwordText.resignFirstResponder()
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
        print("keyboard hidden")
        ScrollView.contentInset = UIEdgeInsets.zero
        ScrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
}
