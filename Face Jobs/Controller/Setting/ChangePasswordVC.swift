//
//  ChangePasswordVC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/28/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit
import Alamofire
class ChangePasswordVC: UIViewController {

    @IBOutlet weak var oldPassText: UITextField!
    @IBOutlet weak var newPassText: UITextField!
    @IBOutlet weak var confirmPassText: UITextField!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var backBRN: UIButton!
    @IBOutlet weak var topView: UIView!
    let constant = Constants.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        getRadius()
        setUpView()
    }
    private func setUpView()
    {
        self.addingGradientLayerToView([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor], view: topView)
        if constant.isArabic() {
            backBRN.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func savePressed(_ sender: Any) {
        if oldPassText.text == ""{
            AlertView.instance.showAlert(message: "Oldpassword".localized, alertType: .failure)
        }else if oldPassText.text!.count < 6{
            AlertView.instance.showAlert(message: "oldPAsswordLength".localized, alertType: .failure)
        }else if newPassText.text == ""{
            AlertView.instance.showAlert(message: "newPasswordRequired".localized, alertType: .failure)
        }else if newPassText.text!.count < 6{
            AlertView.instance.showAlert(message: "newPasswordLength".localized, alertType: .failure)
        }else if confirmPassText.text == ""{
            AlertView.instance.showAlert(message: "Confirm_password_required".localized, alertType: .failure)
        }else if confirmPassText.text!.count < 6{
            AlertView.instance.showAlert(message: "confirmpasswordLength".localized, alertType: .failure)
        }else if newPassText.text != confirmPassText.text{
            AlertView.instance.showAlert(message: "equalpassword".localized, alertType: .failure)
        }else{
            ChangePass(oldPass: oldPassText.text ?? "", newPass: newPassText.text ?? "", confirmPass: confirmPassText.text ?? "")
        }
    }

}
extension ChangePasswordVC{
    func ChangePass(oldPass: String, newPass: String, confirmPass: String){
        AF.request(APIRouter.ChangePasswordRouter(OldPassword: oldPass, NewPassword: newPass, ConfirmPassword: confirmPass, Auth: Share.savedToken as! String))
            .responseJSON(completionHandler: { (res) in
                print(res)
            })
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<MessageCode, AFError>) in
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if model.errorCode == 0{
                            AlertView.instance.showAlert(message: "Successfully".localized, alertType: .success)
                            self.oldPassText.text = ""
                            self.newPassText.text = ""
                            self.confirmPassText.text = ""
                        }else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                        }
                    }
                })
    }
}
extension ChangePasswordVC: UITextFieldDelegate{
    func getRadius() {
     let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didtapview(gesture:)))
        view.addGestureRecognizer(tapGesture)
        
        oldPassText.attributedPlaceholder = NSAttributedString(string: "oldPassword".localized, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.03137254902, green: 0.02745098039, blue: 0.02745098039, alpha: 0.55)])

        newPassText.attributedPlaceholder = NSAttributedString(string: "newPassword".localized, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.03137254902, green: 0.02745098039, blue: 0.02745098039, alpha: 0.55)])

        confirmPassText.attributedPlaceholder = NSAttributedString(string: "copnfirmPassword".localized, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.03137254902, green: 0.02745098039, blue: 0.02745098039, alpha: 0.55)])

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        oldPassText.resignFirstResponder()
        newPassText.resignFirstResponder()
        confirmPassText.resignFirstResponder()
        return true
    }
    
    @objc func didtapview(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
       
        self.navigationController?.navigationBar.isHidden = true
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
