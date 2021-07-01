//
//  AddJobAPIS.swift
//  Face Jobs
//
//  Created by Apple on 4/14/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import Foundation
import Alamofire
extension jobViewController {
    func GetDataToAddJob(){
        let constant = Constants.shared
        Share.CountriesListString.removeAll()
        showProgress()
        AF.request(APIRouter.GetDataToAddJobRouter(lang: constant.getCurrentLanguage(), Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<GetAddJobDataCodable, AFError>) in
                self.dismisProgress()
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if model.errorCode == 0 {
                            Share.TypeListString.removeAll()
                            Share.CategoriesListString.removeAll()
                            Share.TypeList = model.data?.types
                            Share.CategoriesList = model.data?.categories
                            Share.PaymentMethodsList = model.data?.paymentMethods
                            Share.CountriesList = model.data?.countries
                            Share.PriceTypesList = model.data?.priceTypes
                            
                            typeTxt.text =  model.data?.types?.first?.name ?? ""
                            Share.Job_TypeId = model.data?.types?.first?.id ?? 0
                            catgoryTXT.text = model.data?.categories?.first?.name ?? ""
                            Share.Job_CategoryId = model.data?.categories?.first?.id ?? 0
                            Share.Job_PaymentMethodJob = model.data?.categories?.first?.paymentMethod ?? 0
                            if let types = model.data?.types {
                                typesModel = types
                                typeTxt.text = types.first?.name ?? ""
                                typeID = types.first?.id ?? 0
                            }
                            if let catigories = model.data?.categories {
                                catigoryModel = catigories
                                catgoryTXT.text = catigories.first?.name ?? ""
                                catigoryID = catigories.first?.id ?? 0
                            }
                            if let paymentsMotheds = model.data?.paymentMethods{
                                payments = paymentsMotheds
                                paymentMethod.text = paymentsMotheds.first?.name ?? ""
                                paymentID = paymentsMotheds.first?.id ?? 0
                            }
                            if let priceTypes = model.data?.priceTypes {
                                prices = priceTypes
                                priceID = priceTypes.first?.id ?? 0
                                priceTXT.text = priceTypes.first?.name ?? ""
                            }
                            if let countries_Model = model.data?.countries{
                                countriesModel = countries_Model
                                country.text = countries_Model.first?.name ?? ""
                                coutryID = countries_Model.first?.id ?? 0
                                GetCity(id: coutryID)
                            }
                        }else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
                        
                    }
                })
    }
    func GetCity(id: Int){
        showProgress()
        let constant = Constants.shared
        AF.request(APIRouter.GetCityRouter(CountryId: id, lang: constant.getCurrentLanguage()))
            .responseJSON(completionHandler: { (res) in
                print(res)
            })
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<CityCodable, AFError>) in
                self.dismisProgress()
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if let modelData = model.data {
                            self.citiesModel = modelData
                            self.CityID = model.data?.first?.id ?? 0
                            self.GetArea(id: self.CityID)
                            self.cityTXXT.text = model.data?.first?.name ?? ""
                            GetArea(id:CityID)
                            print("Cities",model.data)
                        }
                        else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
                }
        })
    }
    func GetArea(id: Int){
        showProgress()
        let constant = Constants.shared

        AF.request(APIRouter.GetAreaRouter(CityId: id, lang: constant.getCurrentLanguage()))
            .responseJSON(completionHandler: { (res) in
                print(res)
            })
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<AreaCodable, AFError>) in
                self.dismisProgress()
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if let area_model = model.data {
                            self.areaModel = area_model
                            self.areaID = area_model.first?.id ?? 0
                            self.valiageTXT.text = area_model.first?.name ?? ""
                        }
                        else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
                }
        })
    }
    func AddJob(Title: String, JobType: Int, CategoryId: Int, Description: String, IsJobMultiDays: Bool, DateTimes: [DateTimesCodable], IsBreakAvailable: Bool, IsBreakPaid: Bool, JobTimeType: Int, Photos: [String], ExpectedWorkingHours: String, WorkingHoursDescription: String, PaymentMethod: Int, PaymentType: Int, Price: Double, NumberOfEmployees: Int, Addresses: [AddressCodableJob], IsOnline: Bool){
        self.showProgress()
        AF.request(APIRouter.AddJobClientRouter(Title: Title, JobType: JobType, CategoryId: CategoryId, Description: Description, IsJobMultiDays: IsJobMultiDays, DateTimes: DateTimes, IsBreakAvailable: IsBreakAvailable, IsBreakPaid: IsBreakPaid, JobTimeType: JobTimeType, Photos: Photos, ExpectedWorkingHours: ExpectedWorkingHours, WorkingHoursDescription: WorkingHoursDescription, PaymentMethod: PaymentMethod, PaymentType: PaymentType, Price: Price, NumberOfEmployees: NumberOfEmployees, Addresses: Addresses, IsOnline: IsOnline, Auth: Share.savedToken as! String))
            .responseJSON(completionHandler: { (res) in
                print(res)
            })
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<MessageCode, AFError>) in
                self.dismisProgress()
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if model.errorCode == 0 {
                            self.ShareViewController(withIdentifier: "HomeSecreen")
                        }else{
                            addresses.removeAll()
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
                }
        })
    }
    func getEditJobData(jobID: Int)
    {
        let constant = Constants.shared
        showProgress()
        AF.request(APIRouter.GetEditJopPageData(lang: constant.getCurrentLanguage(), JobId: jobID, Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<EditJobModel, AFError>) in
                self.dismisProgress()
                switch response.result {
                case .failure(let err):
                    print(err.localizedDescription)
                case .success(let model):
                    if model.errorCode == 0 {
                        guard let modelData = model.data else {
                        return
                        }
                        self.setUpEditableData(jobData: modelData)
                        self.setJobDataMultiSelect(MultiSelectData: modelData)
                       jobData = model
                    }else{
                        ErrorCode.instance.Code(Code: model.errorCode ?? 0 )
                    }
                }
            })
            }
    func eidtjob(JobId: Int, Title: String, JobType: Int, CategoryId: Int, Description: String, IsJobMultiDays: Bool, DateTimes: [[String: String]], IsBreakAvailable: Bool, IsBreakPaid: Bool, JobTimeType: Int, Photos: [String], ExpectedWorkingHours: String, WorkingHoursDescription: String, PaymentMethod: Int, PaymentType: Int, Price: Double, NumberOfEmployees: Int, Addresses: [AddressCodableJob], IsOnline: Bool)
    {
        
        print("DateTimes",DateTimes)
        showProgress()
        AF.request(APIRouter.editJob(JobId: JobId, Title: Title, JobType: JobType, CategoryId: CategoryId, Description: Description, IsJobMultiDays: IsJobMultiDays, DateTimes: DateTimes, IsBreakAvailable: IsBreakAvailable, IsBreakPaid: IsBreakPaid, JobTimeType: JobTimeType, Photos: Photos, ExpectedWorkingHours: ExpectedWorkingHours, WorkingHoursDescription: WorkingHoursDescription, PaymentMethod: PaymentMethod, PaymentType: PaymentType, Price: Price, NumberOfEmployees: NumberOfEmployees, Addresses: Addresses, IsOnline: IsOnline, Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<editJobResponseModel, AFError>) in
                print("edit_response",response)
                self.dismisProgress()
                switch response.result {
                case .failure(let err):
                    print(err.localizedDescription)
                case .success(let model):
                    if model.errorCode == 0 {
                        AlertView.instance.showAlert(message: "editJob".localized, alertType: .failure)
                    }else{
                        ErrorCode.instance.Code(Code: model.errorCode ?? 0 )
                    }
                }
            })
    }
    
    }
