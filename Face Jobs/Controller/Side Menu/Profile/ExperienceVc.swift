//
//  ExperienceVc.swift
//  Face Jobs
//
//  Created by Apple on 3/7/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import UIKit
import Alamofire
class ExperienceVc: MainViewController {
    
    @IBOutlet weak var ExperienceArText: UITextView!
    @IBOutlet weak var ExperienceEnText: UITextView!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var backBTN: UIButton!
    @IBOutlet weak var topView: UIView!
    let constant = Constants.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        getExperience()
    }
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func SavePressed(_ sender: Any) {
        guard let experienceAR = ExperienceArText.text, !experienceAR.isEmpty  else {
            return
        }
        guard let experienceEn = ExperienceEnText.text, !experienceEn.isEmpty  else {
            return
        }
        self.addExperience(TextAr: experienceAR, TextEn: experienceEn)
    }
    
    
}

extension ExperienceVc {
    private func setUpView()
    {
        if constant.isArabic() {
            backBTN.transform =  CGAffineTransform(scaleX: -1, y: 1)
        }
        ExperienceArText.delegate = self
        ExperienceEnText.delegate = self
        self.addingGradientLayerToView([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor], view: topView)
    }
    private func getExperience()
    {
        showProgress()
        AF.request(APIRouter.GetExperienceRouter(Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: {(response: DataResponse<experienceModel, AFError>) in
                self.dismisProgress()
                switch response.result {
                case .failure(let err):
                    print(err.localizedDescription)
                case .success(let model):
                    guard let expenienceAR = model.data?.experienceAr , !expenienceAR.isEmpty else {
                        self.ExperienceArText.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                        self.ExperienceArText.text = "typeYourExperience".localized
                        return
                        
                    }
                    self.ExperienceArText.text = expenienceAR
                    self.ExperienceArText.textAlignment = .left
                    guard let expenienceEn = model.data?.experienceEn , !expenienceEn.isEmpty else {
                    self.ExperienceEnText.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                    self.ExperienceEnText.text = "typeYourExperience".localized
                    return
                    
                }
                self.ExperienceEnText.text = expenienceEn
                self.ExperienceEnText.textAlignment = .left

            }

            })
        }
    private func addExperience(TextAr: String, TextEn: String)
    {
        showProgress()
        AF.request(APIRouter.EditExperienceRouter(ExperienceAR: TextAr, ExperienceEN: TextEn,Auth: Share.savedToken as! String))
                .responseDecodable(completionHandler: {  (response: DataResponse<experienceModel, AFError>) in
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
extension ExperienceVc : UITextFieldDelegate, UITextViewDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ExperienceArText.resignFirstResponder()
        ExperienceEnText.resignFirstResponder()
        return true
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == "typeYourExperience".localized{
            textView.textColor = .white
            textView.text = ""
            if textView == ExperienceArText{
                textView.textAlignment = .right
            }
        }
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text.isEmpty{
            textView.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            textView.text = "typeYourExperience".localized
            if textView == ExperienceArText{
                textView.textAlignment = .right
            }
        }
        return true
    }
}
