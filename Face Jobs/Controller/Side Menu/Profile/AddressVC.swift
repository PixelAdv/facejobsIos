//
//  AddressVC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/28/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit
import Alamofire

class AddressVC: UIViewController {

    @IBOutlet weak var AddressArText: UITextView!
    @IBOutlet weak var AddressEnText: UITextView!

    @IBOutlet weak var ScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        AddressArText.delegate = self
        AddressEnText.delegate = self
        addingGradientLayerToNavigationBar([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor])
        GetAddress()
        getRadius()
    }
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SavePressed(_ sender: Any) {
        AddAddress(TextAr: AddressArText.text ?? "", TextEn: AddressEnText.text ?? "")
    }
}
extension AddressVC{
    func GetAddress(){
        AF.request(APIRouter.GetAddressRouter(Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<AddressCodable, AFError>) in
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if model.data?.addressAr?.isEmpty == true || model.data?.addressAr == nil {
//                            self.setupPlaceholder(Message: self.AddressArText, MessageString: "Your address here...........")
                            self.AddressArText.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                            self.AddressArText.text = "Your address here..........."
                        }else{
                            self.AddressArText.text = model.data?.addressAr ?? ""
                        }
                        if model.data?.addressEn?.isEmpty == true || model.data?.addressEn == nil {
//                            self.setupPlaceholder(Message: self.AddressEnText, MessageString: "Your address here...........")
                            self.AddressEnText.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                            self.AddressEnText.text = "Your address here..........."
                        }else{
                            self.AddressEnText.text = model.data?.addressEn ?? ""
                        }
                        
                        self.AddressArText.textAlignment = .left
                        
                    }
                })
    }
    
    func AddAddress(TextAr: String, TextEn: String){
        AF.request(APIRouter.EditAddressRouter(AddressAr: TextAr, AddressEn: TextEn, Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<MessageCode, AFError>) in
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if model.errorCode == 0 {
                            AlertView.instance.showAlert(message: "Successfully", alertType: .success)
                        }else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
                        
                    }
                })
    }

}
extension AddressVC: UITextFieldDelegate, UITextViewDelegate{
    func getRadius() {
     let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didtapview(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        AddressArText.resignFirstResponder()
        AddressEnText.resignFirstResponder()
        return true
    }
    
    @objc func didtapview(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
     func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == "Your address here..........."{
            textView.textColor = .white
            textView.text = ""
            if textView == AddressArText{
                textView.textAlignment = .right
            }
        }
        return true
    }
     func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text.isEmpty{
            textView.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            textView.text = "Your address here..........."
            if textView == AddressArText{
                textView.textAlignment = .left
            }
        }
        return true
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
