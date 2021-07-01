//
//  FilterViewController.swift
//  Face Jobs
//
//  Created by Apple on 6/22/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import UIKit
import Alamofire
class FilterViewController: MainViewController  {
    
    @IBOutlet weak var backBTN: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var sortCatigoryView: TappedView!
    @IBOutlet weak var fromTXT: TappedTextField!
    @IBOutlet weak var toTxt: TappedTextField!
    @IBOutlet weak var countyView: TappedView!
    @IBOutlet weak var viewSwitch: UISwitch!
    @IBOutlet weak var governmentView: TappedView!
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var vailageView: TappedView!
    @IBOutlet weak var sortView: TappedView!
    @IBOutlet weak var catigoryView: TappedView!
    @IBOutlet weak var sortTypeTXT: UITextField!
    @IBOutlet weak var sortCatigoryTXT: UITextField!
    @IBOutlet weak var catigoriesTXT: UITextField!
    @IBOutlet weak var countryTXT: TappedTextField!
    @IBOutlet weak var valigeTXT: TappedTextField!
    @IBOutlet weak var governMentTXT: TappedTextField!
    
    
    
    let constant = Constants.shared
    var filterDataModel: filterDataModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        coinfigureView()
        getFilterData()
        setDelegateToViews()
        getFilterData()
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
    }
    private func setDelegateToViews(){
        sortCatigoryView.delegate = self
        countyView.delegate = self
        governmentView.delegate = self
        vailageView.delegate = self
        sortView.delegate = self
        catigoryView.delegate = self
        fromTXT.tapDelegate = self
        toTxt.tapDelegate = self
    }
    private func coinfigureView()
    {
        addingGradientLayerToView([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor], view: topView)
        let textFields: [UITextField] = [fromTXT, toTxt]
        let views: [UIView] = [sortCatigoryView,sortView, catigoryView,countyView,governmentView,vailageView]
        confiureView(views: views)
        confiureTextField(textFields: textFields)
        statusSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        viewSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        
    }
    private func confiureTextField(textFields: [UITextField]){
        for textField in textFields {
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.mainColor.cgColor
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 8
        }
    }
    private func confiureView(views: [UIView]){
        for view in views {
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.mainColor.cgColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        }
    }
    private func getFilterData()
    {
        let token = "cVjVSs4xY0ud3rD_QnA0WjwV_Wn-2P1f3NCVfQjXbm2uJDdZ8TPamR69mQO0elyU-Oh6WQ2gRqjCDwOyvEmrGMRFZWfdKhJceTUc7mZze2a1uJEtvv5hq2zVzLOfKV2A1cXvMl2rtUDQlawukvlNVgXNUo9YkPiBYei9cXr7s1M0M9PZX-0XACmI1xHOQsIFV87679piwAccWvd71KEsi-6zrkwte2VNM4kryOE6wuvs0goW1jvb_lahEsYgqLkM8NIIUkQS4zQa7oFYo0N8A08A7YtrtGQdaoOtNWfCCSuWMM0DoDM6Mzrxp6TnjJ5v9b4FjikKP2IL0QN0I_DzZsaXsuODlmjfF2C7_VvX9yD5LzCyAf9lfDx43y_YZMTuk3-psBDt0jSur0bvzrO7-1UGw9I5qGLBV6ay6aVnO5shM29Jn88wbxrX066BmBzMd68WB45WPnpEWUGFKSs3KM1b3oH4Szl6PMvE3zwKyfRrwvBfL8yITpTEZwb3nVp1Z2z6ED9etJRFqT_U_geiLUeA8MglCLSQXdfc3823fFM"
        showProgress()
        AF.request(APIRouter.getFilterData(Auth: token, lang: constant.getCurrentLanguage()))
            .responseDecodable(completionHandler: { (response: DataResponse<filterDataModel, AFError>) in
                print("empolyee1",response)
                self.dismisProgress()
                switch response.result {
                case .failure(let err):
                    print(err.localizedDescription)
                case .success(let model):
                    print("Model",model)
                    self.filterDataModel = model
                   
                }
            })
    }
    
}

extension FilterViewController: TappedViewDelegate{
    func viewDidTap(_ view: TappedView) {
        var selectedArrayData: [String] = [String]()
        if view == sortCatigoryView{
            guard let catigories = filterDataModel?.data?.categories else {
                return
            }
            for item in catigories {
                selectedArrayData.append(item.name ?? "")
            }
            callTextPickerAppearanceManager(title: "catigories".localized, items: selectedArrayData, completion: {
                text in
                self.catigoriesTXT.text = text
                
            })
        }
        else if view == catigoryView {
            guard let countires = filterDataModel?.data?.countires else {
                return
            }
            for item in countires {
                selectedArrayData.append(item.name ?? "")
            }
            callTextPickerAppearanceManager(title: "catigories".localized, items: selectedArrayData, completion: {
                text in
                self.sortCatigoryTXT.text = text
                
            })
        }
        else if view == countyView{
            guard let countires = filterDataModel?.data?.countires else {
                return
            }
            for item in countires {
                selectedArrayData.append(item.name ?? "")
            }
            callTextPickerAppearanceManager(title: "countires".localized, items: selectedArrayData, completion: {
                text in
                self.countryTXT.text = text
                
            })
        }
        else if view == vailageView{
            guard let areas = filterDataModel?.data?.areas else {
                return
            }
            for item in areas {
                selectedArrayData.append(item.name ?? "")
            }
            callTextPickerAppearanceManager(title: "areas".localized, items: selectedArrayData, completion: {
                text in
                self.valigeTXT.text = text
                
            })
            
        }
        else if view == governmentView{
            guard let cities = filterDataModel?.data?.cities else {
                return
            }
            for item in cities {
                selectedArrayData.append(item.name ?? "")
            }
            callTextPickerAppearanceManager(title: "catigories".localized, items: selectedArrayData, completion: {
                text in
                self.governMentTXT.text = text
                
            })
            
        }
        else if view == sortView{
            guard let types = filterDataModel?.data?.types else {
                return
            }
            for item in types {
                selectedArrayData.append(item.name ?? "")
            }
            callTextPickerAppearanceManager(title: "types".localized, items: selectedArrayData, completion: {
                text in
                self.sortTypeTXT.text = text
                
            })
            
        }
    }
    
}
extension FilterViewController: TappedTextFieldDelegate{
    func textFieldDidTap(_ textField: TappedTextField) {
        if textField == fromTXT{
            
        }
        else if textField == toTxt {
            
        }
    }
}
