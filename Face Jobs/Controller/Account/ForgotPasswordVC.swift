//
//  ForgotPasswordVC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/23/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit
import Alamofire

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var Emailtext: UITextField!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var loadingBtn: LoadingButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        getRadius()
    }
    
    @IBAction func ForgotPasswordPressed(_ sender: Any) {
        if Emailtext.text?.isEmpty == true{
            AlertView.instance.showAlert(message: "email_requird".localized, alertType: .failure)
        }else if Emailtext.text?.isValidateEmail() == false{
            AlertView.instance.showAlert(message: "invalidEmail".localized, alertType: .failure)
        }else{
            GetData(Provider: Emailtext.text ?? "")
        }
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
extension ForgotPasswordVC{
    func GetData(Provider: String){
        loadingBtn.showLoading()
        AF.request(APIRouter.ForgotPasswordRouter(Email: Provider))
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<loginCodable, AFError>) in
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    self.loadingBtn.hideLoading()
                    case .success(let model):
                        self.loadingBtn.hideLoading()
                        if model.errorCode == 0{
                            self.ShareViewController(withIdentifier: "loginPage")
                        }else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                        }
                    }
                })
    }
}
extension ForgotPasswordVC: UITextFieldDelegate{
    func getRadius() {
     let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didtapview(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Emailtext.resignFirstResponder()
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
