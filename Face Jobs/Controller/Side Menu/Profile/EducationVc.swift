//
//  EducationVc.swift
//  Face Jobs
//
//  Created by Apple on 3/7/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import UIKit
import Alamofire
class EducationVc: MainViewController {
    
    @IBOutlet weak var EducationArText: UITextView!
    @IBOutlet weak var EducationEnText: UITextView!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var backBTN: UIButton!
    @IBOutlet weak var topView: UIView!
    let constant = Constants.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        getEducation()
    }
    private func setUpView()
    {
        if constant.isArabic() {
            backBTN.transform =  CGAffineTransform(scaleX: -1, y: 1)
        }
        EducationArText.delegate = self
        EducationEnText.delegate = self
        self.addingGradientLayerToView([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor], view: topView)
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: Any) {
        guard let educationAr = EducationArText.text, !educationAr.isEmpty else {
            return
        }
        guard let educationEn = EducationEnText.text, !educationEn.isEmpty else {
            return
        }
        addEducation(TextAr: educationAr, TextEn: educationEn)
    }
    
}
extension EducationVc {
    private func getEducation()
    {
        showProgress()
        AF.request(APIRouter.GetEducationRouter(Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: {(response: DataResponse<EducationModel, AFError>) in
                self.dismisProgress()
                switch response.result {
                case .failure(let err):
                    print(err.localizedDescription)
                case .success(let model):
                    guard let expenienceAR = model.data?.educationAr , !expenienceAR.isEmpty else {
                        self.EducationArText.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                        self.EducationArText.text = "typeYourEducation".localized
                        return
                        
                    }
                    self.EducationArText.text = expenienceAR
                    self.EducationArText.textAlignment = .right
                    guard let expenienceEn = model.data?.educationEn , !expenienceEn.isEmpty else {
                        self.EducationEnText.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                        self.EducationEnText.text = "typeYourEducation".localized
                        return
                        
                    }
                    self.EducationEnText.text = expenienceEn
                    self.EducationEnText.textAlignment = .left
                    
                }
                
            })
    }
    private func addEducation(TextAr: String, TextEn: String)
    {
        showProgress()
        AF.request(APIRouter.EditEducationRouter(EducationAR: TextAr, EducationEN: TextEn, Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: {  (response: DataResponse<EducationModel, AFError>) in
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

extension EducationVc : UITextFieldDelegate, UITextViewDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        EducationArText.resignFirstResponder()
        EducationEnText.resignFirstResponder()
        return true
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == "typeYourEducation".localized{
            textView.textColor = .white
            textView.text = ""
            if textView == EducationArText{
                textView.textAlignment = .right
            }

        }
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text.isEmpty{
            textView.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            textView.text = "typeYourEducation".localized
            if textView == EducationArText{
                textView.textAlignment = .left
            }
        }
        return true
    }
}
