//
//  RegisterVC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/23/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit
import Alamofire

class RegisterVC: UIViewController {
    @IBOutlet weak var FirstNameText: UITextField!
    @IBOutlet weak var MiddleNameText: UITextField!
    @IBOutlet weak var LastNameText: UITextField!
    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var CompanyNameText: UITextField!
    @IBOutlet weak var DateBirthdayText: UITextField!
    @IBOutlet weak var PhoneText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    @IBOutlet weak var ConfirmPasswordText: UITextField!
    @IBOutlet weak var RegisterBtn: UIButton!
    @IBOutlet weak var DateView: UIView!
    @IBOutlet weak var CompanyView: UIView!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var loadingBtn: LoadingButton!

    @objc private var dataPicker: UIDatePicker?
    let currentDate = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        CheckRegister(id: Share.UserTypeId)
        getRadius()
        SetupPicker()
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func RegisterPressed(_ sender: Any) {
        if Share.UserTypeId == 1{
            Share.UserTypeId = 2
            CheckRegister(id: Share.UserTypeId)
        }else if Share.UserTypeId == 2{
            Share.UserTypeId = 1
            CheckRegister(id: Share.UserTypeId)
        }else{
            
        }
    }
    func CheckRegister(id: Int){
        if id == 1{
            DateView.isHidden = false
            CompanyView.isHidden = true
            RegisterBtn.setTitle("registerAsClient".localized, for: .normal)
        }else if id == 2{
            DateView.isHidden = true
            CompanyView.isHidden = false
            RegisterBtn.setTitle("registerAsEmployee".localized, for: .normal)
        }
    }
    func Checkedkey(id: Int){
        switch id {
        case 1:
            if DateBirthdayText.text?.isEmpty == true{
                AlertView.instance.showAlert(message: "DateOfBirthFieldIsRequired".localized, alertType: .failure)
            }
        case 2:
            if CompanyNameText.text?.isEmpty == true{
                AlertView.instance.showAlert(message: "CompanyNameFieldIsRequired".localized, alertType: .failure)
            }
        default:
            break
        }
    }
    
    @IBAction func LoginPressed(_ sender: Any) {
        if FirstNameText.text?.isEmpty == true{
            AlertView.instance.showAlert(message: "FirstNameFieldIsRequired".localized, alertType: .failure)
        }else if LastNameText.text?.isEmpty == true{
            AlertView.instance.showAlert(message: "LastNameFieldIsRequired".localized, alertType: .failure)
        }else if EmailText.text?.isEmpty == true{
            AlertView.instance.showAlert(message: "EmailPhoneRequired".localized, alertType: .failure)
        }else if EmailText.text?.isValidateEmail() == false{
            AlertView.instance.showAlert(message: "invalidEmail".localized, alertType: .failure)
        }else if PhoneText.text?.count != 11{
            AlertView.instance.showAlert(message: "invlaidPhone".localized, alertType: .failure)
        }else if PhoneText.text?.isEmpty == true{
            AlertView.instance.showAlert(message: "phoneRequied".localized, alertType: .failure)
        }else if PasswordText.text?.isEmpty == true{
            AlertView.instance.showAlert(message: "passwordRequired".localized, alertType: .failure)
        }else if PasswordText.text!.count < 6{
            AlertView.instance.showAlert(message: "passwordLength".localized, alertType: .failure)
        }else if ConfirmPasswordText.text?.isEmpty == true{
            AlertView.instance.showAlert(message: "Confirm_password_required".localized, alertType: .failure)
        }else if ConfirmPasswordText.text!.count < 6{
            AlertView.instance.showAlert(message: "confirmpasswordLength".localized, alertType: .failure)
        }else if PasswordText.text != ConfirmPasswordText.text{
            AlertView.instance.showAlert(message: "equalpassword".localized, alertType: .failure)
        }else{
            GetLogin(FirstName: FirstNameText.text ?? "", MiddleName: MiddleNameText.text ?? "" , LastName: LastNameText.text ?? "", Email: EmailText.text ?? "", Phone: PhoneText.text ?? "", Password: PasswordText.text ?? "", ConfirmPassword: ConfirmPasswordText.text ?? "", CompanyName: CompanyNameText.text ?? "", UserType: Share.UserTypeId, DateOfBirth: DateBirthdayText.text ?? "", PushToken: "", OS: 1)
        }
    }
}
extension RegisterVC{
    func GetLogin(FirstName: String, MiddleName: String, LastName: String, Email: String, Phone: String, Password: String, ConfirmPassword: String, CompanyName: String, UserType: Int, DateOfBirth: String, PushToken: String, OS: Int){
        loadingBtn.showLoading()
        AF.request(APIRouter.RegisterRouter(FirstName: FirstName, MiddleName: MiddleName, LastName: LastName, Email: Email, Phone: Phone, Password: Password, ConfirmPassword: ConfirmPassword, CompanyName: CompanyName, UserType: UserType, DateOfBirth: DateOfBirth, PushToken: PushToken, OS: OS))
            .responseJSON(completionHandler: { (res) in
                print(res)
            })
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<loginCodable, AFError>) in
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    self.loadingBtn.hideLoading()
                    case .success(let model):
                        self.loadingBtn.hideLoading()
                        if model.errorCode == 0{
                            saveToUserDefulats(model: model)
                            self.ShareViewController(withIdentifier: "HomeSecreen")
                        }else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                        }
                    }
                })
    }
    
    private func saveToUserDefulats(model: loginCodable)
    {
        let userDefaults = UserDefaults.standard
        Share.savedToken = model.data?.token
        userDefaults.set( Share.savedToken , forKey: "AccessToken")
        userDefaults.set(model.data?.typeId , forKey: "USERTYPE")
        userDefaults.set(model.data?.CompanyName ?? "", forKey: "COMPANY_NAME")
        userDefaults.set(model.data?.FirstName ?? "", forKey: "FIRST_NAME")
        userDefaults.set(model.data?.LastName ?? "", forKey: "LAST_NAME")
        userDefaults.synchronize()
        userDefaults.set(true,forKey:"isLogin")
        userDefaults.synchronize()
    }
}
extension RegisterVC: UITextFieldDelegate{
    func SetupPicker(){
        dataPicker = UIDatePicker()
        dataPicker?.datePickerMode = .date
        dataPicker?.addTarget(self, action: #selector(RegisterVC.dateChange(dataPicker:)), for: .valueChanged)
        DateBirthdayText.inputView = dataPicker
    }
    
    @objc func dateChange(dataPicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = NSLocale.init(localeIdentifier: "en") as Locale

        DateBirthdayText.text = dateFormatter.string(from: dataPicker.date)
    }
    
    func getRadius() {
     let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didtapview(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        FirstNameText.resignFirstResponder()
        MiddleNameText.resignFirstResponder()
        LastNameText.resignFirstResponder()
        EmailText.resignFirstResponder()
        CompanyNameText.resignFirstResponder()
        DateBirthdayText.resignFirstResponder()
        PhoneText.resignFirstResponder()
        PasswordText.resignFirstResponder()
        ConfirmPasswordText.resignFirstResponder()
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
