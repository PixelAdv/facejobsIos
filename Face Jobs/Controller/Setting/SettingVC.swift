//
//  SettingVC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/28/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit
import Alamofire

class SettingVC: UIViewController {

    @IBOutlet weak var ToggleVisiblitySwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        GetToggleVisiblity()
        addingGradientLayerToNavigationBar([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor])
        ToggleVisiblitySwitch.addTarget(self, action: #selector(SettingVC.switchIsChanged(mySwitch:)), for: UIControl.Event.valueChanged)
    }
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func ChangePasswordPressed(_ sender: Any) {
        ShareViewController(withIdentifier: "ChangePasswordPage")
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
    @objc func switchIsChanged(mySwitch: UISwitch) {
        ToggleVisiblity()
    }
}
extension SettingVC{
    func ToggleVisiblity(){
        AF.request(APIRouter.ToggleVisiblityRouter(Auth: Share.savedToken as! String))
            .responseJSON(completionHandler: { (res) in
                print(res)
            })
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<VisibilityCodable, AFError>) in
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if model.errorCode == 0{
                            if model.data?.isVisible == true{
                                self.ToggleVisiblitySwitch.isOn = true
                                self.ToggleVisiblitySwitch.thumbTintColor = .green
                            }else{
                                self.ToggleVisiblitySwitch.isOn = false
                                self.ToggleVisiblitySwitch.thumbTintColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
                            }
                        }else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                        }
                    }
                })
    }
    func GetToggleVisiblity(){
        AF.request(APIRouter.GetToggleVisiblityRouter(Auth: Share.savedToken as! String))
            .responseJSON(completionHandler: { (res) in
                print(res)
            })
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<VisibilityCodable, AFError>) in
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if model.errorCode == 0{
                             if model.data?.isVisible == true{
                                self.ToggleVisiblitySwitch.isOn = true
                                self.ToggleVisiblitySwitch.thumbTintColor = .green
                            }else{
                                self.ToggleVisiblitySwitch.isOn = false
                                self.ToggleVisiblitySwitch.thumbTintColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
                            }
                        }else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                        }
                    }
                })
    }
}
