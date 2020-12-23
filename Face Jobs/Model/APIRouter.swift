//
//  APIRouter.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/24/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import Foundation
import Alamofire

typealias complitaionHandeller = (_ success: Bool) -> ()

enum APIRouter: URLRequestConvertible {
    static let baseURL = "http://face-jobs.com"
    
    // Account
    case loginRouter(Provider: String, Password: String, PushToken: String, OS: Int)
    case RegisterRouter(FirstName: String, MiddleName: String, LastName: String, Email: String, Phone: String, Password: String, ConfirmPassword: String, CompanyName: String, UserType: Int, DateOfBirth: String, PushToken: String, OS: Int)
    case ForgotPasswordRouter(Email: String)
    
    case ChangePasswordRouter(OldPassword: String, NewPassword: String, ConfirmPassword: String, Auth: String)
    case GetToggleVisiblityRouter(Auth: String)
    case ToggleVisiblityRouter(Auth: String)
    
    // Profile
    case GetProfile(lang: String, Auth: String)
    
    case EditImageProfile(ImageBase64: String, Auth: String)
    case EditEmailProfile(Email: String, Auth: String)
    case EditPhoneProfile(Phone: String, Auth: String)
    case EditLandlineProfile(Landline: String, Auth: String)
    case EditCompanyInfoProfile(Description: String, Auth: String)
    
    case GetAddressRouter(Auth: String)
    case EditAddressRouter(AddressAr: String, AddressEn: String, Auth: String)
    
    case GetSocialRouter(Auth: String)
    case EditSocialRouter(Facebook: String, Twitter: String, Instagram: String, LinkedIn: String, Website: String, Other: String, Auth: String)

    case GetGalleryRouter(Auth: String)
    case EditGalleryRouter(GalleryType: Int, ImagesBase64: [String], Auth: String)
    case DeletItemGalleryRouter(ImageId: Int, GalleryType: Int, Auth: String)
    
    case GetDocumentRouter(Auth: String)
    case EditDocumentRouter(FileName: String, FileType: Int, FileBase64: String, Auth: String)
    case DeleteDocumentRouter(DocumentId: Int, Auth: String)
    
    // Job Client
    case GetCurrentJobRouter(lang: String, Page: Int, Auth: String)
    case GetpreviousJobRouter(lang: String, Page: Int, Auth: String)
    case GetpendingJobRouter(lang: String, Page: Int, Auth: String)
    case GetEditJopPageData(lang: String, JobId: Int, Auth: String)
    case DeleteJop(lang: String, JobId: Int, Auth: String)
    case ResendConfirmationMail(lang: String, JobId: Int, Auth: String)
    case GetDataToAddJobRouter(lang: String, Auth: String)
    case GetCityRouter(CountryId: Int, lang: String)
    case GetAreaRouter(CityId: Int, lang: String)
    
    case AddJobClientRouter(
        Title: String,
        JobType: Int,
        CategoryId: Int,
        Description: String,
        IsJobMultiDays: Bool,
        DateTimes: [DateTimesCodable],
        IsBreakAvailable: Bool,
        IsBreakPaid: Bool,
        JobTimeType: Int,
        Photos: [String],
        ExpectedWorkingHours: String,
        WorkingHoursDescription: String,
        PaymentMethod: Int,
        PaymentType: Int,
        Price: Double,
        NumberOfEmployees: Int,
        Addresses: [AddressCodableJob],
        IsOnline: Bool,
        Auth: String
    )
    
    case GetJobApplicationRouter(JobId: Int, lang: String, Auth: String)
    case acceptapplicantRouter(ApplicationId: Int, Auth: String)
    case rejectapplicantRouter(ApplicationId: Int, Auth: String)
    
    
    
    
    // Case Employee




    private var method: HTTPMethod {
        switch self {
            
        // Account
        case .loginRouter: return .post
        case .RegisterRouter: return .post
        case .ForgotPasswordRouter: return .post
        
        case .ChangePasswordRouter: return .post
        case .GetToggleVisiblityRouter: return .get
        case .ToggleVisiblityRouter: return .get
            
        // Profile
        case .GetProfile: return .get
            
        case .EditImageProfile: return .put
        case .EditEmailProfile: return .put
        case .EditPhoneProfile: return .put
        case .EditLandlineProfile: return .put
        case .EditCompanyInfoProfile: return .put
            
        case .GetAddressRouter: return .get
        case .EditAddressRouter: return .put
            
        case .GetSocialRouter: return .get
        case .EditSocialRouter: return .put
            
        case .GetGalleryRouter: return .get
        case .EditGalleryRouter: return .post
        case .DeletItemGalleryRouter: return .delete
            
        case .GetDocumentRouter: return .get
        case .EditDocumentRouter: return .post
        case .DeleteDocumentRouter: return .delete
            
        // Job Client
        case .GetCurrentJobRouter: return .get
        case .GetpreviousJobRouter: return .get
        case .GetpendingJobRouter: return .get
        case .GetEditJopPageData: return .get
        case .DeleteJop: return .delete
        case .ResendConfirmationMail: return .get

        // Country
        case .GetDataToAddJobRouter: return .get
        case .GetCityRouter: return .get
        case .GetAreaRouter: return .get
        
        case .AddJobClientRouter: return .post
            
        case .GetJobApplicationRouter: return .get
        case .acceptapplicantRouter: return .get
        case .rejectapplicantRouter: return .get
        }
    }
    
    private var path: String {
        switch self {
            
        // Account
        case .loginRouter: return "/data/api/account/Login"
        case .RegisterRouter: return "/data/api/account/Register"
        case .ForgotPasswordRouter: return "/data/api/account/ForgotPassword"
        
        case .ChangePasswordRouter: return "/data/api/account/ChangePassword"
        case .GetToggleVisiblityRouter: return "/data/api/users/clients/profile/get/visibilitystatus"
        case .ToggleVisiblityRouter: return "/data/api/users/clients/profile/current/visibility"
            
        // Profile
        case .GetProfile: return "/data/api/users/clients/profile/current"

        case .EditImageProfile: return "/data/api/users/clients/profile/edit/image"
        case .EditEmailProfile: return "/data/api/users/clients/profile/edit/email"
        case .EditPhoneProfile: return "/data/api/users/clients/profile/edit/phone"
        case .EditLandlineProfile: return "/data/api/users/clients/profile/edit/landline"
        case .EditCompanyInfoProfile: return "/data/api/users/clients/profile/edit/companyinfo"
            
        case .GetAddressRouter: return "/data/api/users/clients/profile/current/address"
        case .EditAddressRouter: return "/data/api/users/clients/profile/edit/address"
        
        case .GetSocialRouter: return "/data/api/users/clients/profile/current/social"
        case .EditSocialRouter: return "/data/api/users/clients/profile/edit/social"
            
        case .GetGalleryRouter: return "/data/api/users/clients/profile/current/gallery"
        case .EditGalleryRouter: return "/data/api/users/clients/profile/add/gallery"
        case .DeletItemGalleryRouter: return "/data/api/users/clients/profile/delete/gallery"

        case .GetDocumentRouter: return "/data/api/users/clients/profile/current/documents"
        case .EditDocumentRouter: return "/data/api/users/clients/profile/add/documents"
        case .DeleteDocumentRouter: return "/data/api/users/clients/profile/delete/documents"
            
        // Job Client
        case .GetCurrentJobRouter: return "/data/api/users/clients/jobs/get/current"
        case .GetpreviousJobRouter: return "/data/api/users/clients/jobs/get/previous"
        case .GetpendingJobRouter: return "/data/api/users/clients/jobs/get/pending"
        case .GetEditJopPageData: return "/data/api/users/clients/jobs/get/editjobpage"
        case .DeleteJop: return "/data/api/users/clients/jobs/delete/job"
        case .ResendConfirmationMail: return "/data/api/users/clients/jobs/get/resendemail"
            
        // Country
        case .GetDataToAddJobRouter: return "/data/api/users/clients/jobs/get/addjobpage"
        case .GetCityRouter: return "/data/api/cities"
        case .GetAreaRouter: return "/data/api/areas"
            
        case .AddJobClientRouter: return "/data/api/users/clients/jobs/add/job"
            
        case .GetJobApplicationRouter: return "/data/api/users/clients/jobs/applicants/get/applicants"
        case .acceptapplicantRouter: return "/data/api/users/clients/jobs/applicants/acceptapplicant"
        case .rejectapplicantRouter: return "/data/api/users/clients/jobs/applicants/rejectapplicant"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try APIRouter.baseURL.asURL().appendingPathComponent(path)
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        var urlRequests = URLRequest(url: url)
        urlRequests.httpMethod = method.rawValue
        urlRequests.setValue("application/json", forHTTPHeaderField: "Content-Type")
        var params = Parameters()
        
        switch self {
        // Global
        case let .loginRouter(Provider, Password, PushToken, OS):
            params = [
                "Provider": Provider,
                "Password": Password,
                "PushToken": PushToken,
                "OS": OS
                ]
            urlRequests = try JSONEncoding.default.encode(urlRequests, with: params)

        case let .RegisterRouter(FirstName, MiddleName, LastName, Email, Phone, Password, ConfirmPassword, CompanyName, UserType, DateOfBirth, PushToken, OS):
            params = [
                "FirstName": FirstName,
                "MiddleName": MiddleName,
                "LastName": LastName,
                "Email": Email,
                "Phone": Phone,
                "Password": Password,
                "ConfirmPassword": ConfirmPassword,
                "CompanyName": CompanyName,
                "UserType": UserType,
                "DateOfBirth": DateOfBirth,
                "PushToken": PushToken,
                "OS": OS
                ]
            urlRequests = try JSONEncoding.default.encode(urlRequests, with: params)
            print(params)
            
        case let .ForgotPasswordRouter(Email):
            params = [
                "Email": Email
                ]
            urlRequests = try JSONEncoding.default.encode(urlRequests, with: params)
            
        case let .ChangePasswordRouter(OldPassword, NewPassword, ConfirmPassword, Auth):
            params = [
                "OldPassword": OldPassword,
                "NewPassword": NewPassword,
                "ConfirmPassword": ConfirmPassword
                ]
            urlRequests.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequests = try JSONEncoding.default.encode(urlRequests, with: params)
            
        case let .GetToggleVisiblityRouter(Auth):
            urlRequests.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequests = try JSONEncoding.default.encode(urlRequests)
            
        case let .ToggleVisiblityRouter(Auth):
            urlRequests.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequests = try JSONEncoding.default.encode(urlRequests)
            
        case let .GetProfile(lang, Auth):
            urlComponents.queryItems = [URLQueryItem(name: "lang", value: "\(lang)")]
            var urlRequest = URLRequest(url: urlComponents.url!)
            urlRequest.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequest.httpMethod = method.rawValue
            return urlRequest
            
            
        case let .EditImageProfile(ImageBase64, Auth):
            params = [
                "ImageBase64": ImageBase64
                ]
            urlRequests.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequests = try JSONEncoding.default.encode(urlRequests, with: params)
        
        case let .EditEmailProfile(Email, Auth):
            params = [
                "Email": Email
                ]
            urlRequests.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequests = try JSONEncoding.default.encode(urlRequests, with: params)
            
        case let .EditPhoneProfile(Phone, Auth):
            params = [
                "Phone": Phone
                ]
            urlRequests.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequests = try JSONEncoding.default.encode(urlRequests, with: params)
            
        case let .EditLandlineProfile(Landline, Auth):
            params = [
                "Landline": Landline
                ]
            urlRequests.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequests = try JSONEncoding.default.encode(urlRequests, with: params)
            
        case let .EditCompanyInfoProfile(Description, Auth):
            params = [
                "Description": Description
                ]
            urlRequests.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequests = try JSONEncoding.default.encode(urlRequests, with: params)
            
        case let .GetAddressRouter(Auth):
            urlRequests.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequests = try JSONEncoding.default.encode(urlRequests)

        case let .EditAddressRouter(AddressAr, AddressEn, Auth):
            params = [
                "AddressAr": AddressAr,
                "AddressEn": AddressEn
                ]
            urlRequests.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequests = try JSONEncoding.default.encode(urlRequests, with: params)
        
        case let .GetSocialRouter(Auth):
            urlRequests.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequests = try JSONEncoding.default.encode(urlRequests)
            
        case let .EditSocialRouter(Facebook, Twitter, Instagram, LinkedIn, Website, Other, Auth):
            params = [
                "Facebook": Facebook,
                "Twitter": Twitter,
                "Instagram": Instagram,
                "LinkedIn": LinkedIn,
                "Website": Website,
                "Other": Other
                ]
            urlRequests.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequests = try JSONEncoding.default.encode(urlRequests, with: params)
            
        case let .GetGalleryRouter(Auth):
            urlRequests.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequests = try JSONEncoding.default.encode(urlRequests)
            
        case let .EditGalleryRouter(GalleryType, ImagesBase64, Auth):
            params = [
                "GalleryType": GalleryType,
                "ImagesBase64": ImagesBase64
                ]
            urlRequests.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequests = try JSONEncoding.default.encode(urlRequests, with: params)
            
        case let .DeletItemGalleryRouter(ImageId, GalleryType, Auth):
            urlComponents.queryItems = [URLQueryItem(name: "ImageId", value: "\(ImageId)"), URLQueryItem(name: "GalleryType", value: "\(GalleryType)")]
            var urlRequest = URLRequest(url: urlComponents.url!)
            urlRequest.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequest.httpMethod = method.rawValue
            return urlRequest
            
        case let .GetDocumentRouter(Auth):
            urlRequests.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequests = try JSONEncoding.default.encode(urlRequests)
            
        case let .EditDocumentRouter(FileName, FileType, FileBase64, Auth):
            params = [
                "FileName": FileName,
                "FileType": FileType,
                "FileBase64": FileBase64
                ]
            urlRequests.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequests = try JSONEncoding.default.encode(urlRequests, with: params)
            
        case let .DeleteDocumentRouter(DocumentId, Auth):
            urlComponents.queryItems = [URLQueryItem(name: "DocumentId", value: "\(DocumentId)")]
            var urlRequest = URLRequest(url: urlComponents.url!)
            urlRequest.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequest.httpMethod = method.rawValue
            return urlRequest
            
        // Job Client
        case let .GetCurrentJobRouter(lang, Page, Auth):
            urlComponents.queryItems = [URLQueryItem(name: "lang", value: "\(lang)"), URLQueryItem(name: "Page", value: "\(Page)")]
            var urlRequest = URLRequest(url: urlComponents.url!)
            urlRequest.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequest.httpMethod = method.rawValue
            return urlRequest
            
        case let .GetpreviousJobRouter(lang, Page, Auth):
            urlComponents.queryItems = [URLQueryItem(name: "lang", value: "\(lang)"), URLQueryItem(name: "Page", value: "\(Page)")]
            var urlRequest = URLRequest(url: urlComponents.url!)
            urlRequest.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequest.httpMethod = method.rawValue
            return urlRequest
            
        case let .GetpendingJobRouter(lang, Page, Auth):
            urlComponents.queryItems = [URLQueryItem(name: "lang", value: "\(lang)"), URLQueryItem(name: "Page", value: "\(Page)")]
            var urlRequest = URLRequest(url: urlComponents.url!)
            urlRequest.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequest.httpMethod = method.rawValue
            return urlRequest
            
        case let .GetEditJopPageData(lang, JopId, Auth):
            urlComponents.queryItems = [URLQueryItem(name: "lang", value: "\(lang)"), URLQueryItem(name: "JobId", value: "\(JopId)")]
            var urlRequest = URLRequest(url: urlComponents.url!)
            urlRequest.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequest.httpMethod = method.rawValue
            return urlRequest
            
        case let .DeleteJop(lang, JopId, Auth):
            urlComponents.queryItems = [URLQueryItem(name: "lang", value: "\(lang)"), URLQueryItem(name: "JobId", value: "\(JopId)")]
            var urlRequest = URLRequest(url: urlComponents.url!)
            urlRequest.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequest.httpMethod = method.rawValue
            return urlRequest
            
        case let .ResendConfirmationMail(lang, JopId, Auth):
            urlComponents.queryItems = [URLQueryItem(name: "lang", value: "\(lang)"), URLQueryItem(name: "JobId", value: "\(JopId)")]
            var urlRequest = URLRequest(url: urlComponents.url!)
            urlRequest.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequest.httpMethod = method.rawValue
            return urlRequest
            
        case let .GetDataToAddJobRouter(lang, Auth):
            urlComponents.queryItems = [URLQueryItem(name: "lang", value: "\(lang)")]
            var urlRequest = URLRequest(url: urlComponents.url!)
            urlRequest.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequest.httpMethod = method.rawValue
            return urlRequest

        case let .GetCityRouter(CountryId, lang):
            urlComponents.queryItems = [URLQueryItem(name: "CountryId", value: "\(CountryId)"), URLQueryItem(name: "lang", value: "\(lang)")]
            var urlRequest = URLRequest(url: urlComponents.url!)
            urlRequest.httpMethod = method.rawValue
            return urlRequest
            
        case let .GetAreaRouter(CityId, lang):
            urlComponents.queryItems = [URLQueryItem(name: "CityId", value: "\(CityId)"), URLQueryItem(name: "lang", value: "\(lang)")]
            var urlRequest = URLRequest(url: urlComponents.url!)
            urlRequest.httpMethod = method.rawValue
            return urlRequest
            
        case let .AddJobClientRouter(Title, JobType, CategoryId, Description, IsJobMultiDays, DateTimes, IsBreakAvailable, IsBreakPaid, JobTimeType, Photos, ExpectedWorkingHours, WorkingHoursDescription, PaymentMethod, PaymentType, Price, NumberOfEmployees, Addresses, IsOnline, Auth):
            var decodedListDateTimes: [[String: Any]] = []
             DateTimes.forEach { decodedListDateTimes.append(try! $0.asDictionary()) }
            var decodedListAddresses: [[String: Any]] = []
            Addresses.forEach { decodedListAddresses.append(try! $0.asDictionary()) }
            params = [
                "Title": Title,
                "JobType": JobType,
                "CategoryId": CategoryId,
                "Description": Description,
                "IsJobMultiDays": IsJobMultiDays,
                "DateTimes": decodedListDateTimes,
                "IsBreakAvailable": IsBreakAvailable,
                "IsBreakPaid": IsBreakPaid,
                "JobTimeType": JobTimeType,
                "Photos": Photos,
                "ExpectedWorkingHours": ExpectedWorkingHours,
                "WorkingHoursDescription": WorkingHoursDescription,
                "PaymentMethod": PaymentMethod,
                "PaymentType": PaymentType,
                "Price": Price,
                "NumberOfEmployees": NumberOfEmployees,
                "Addresses": decodedListAddresses,
                "IsOnline": IsOnline
            ]
            print(params)
            urlRequests.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequests = try JSONEncoding.default.encode(urlRequests, with: params)
            
        case let .GetJobApplicationRouter(JobId, lang, Auth):
            urlComponents.queryItems = [URLQueryItem(name: "JobId", value: "\(JobId)"), URLQueryItem(name: "lang", value: "\(lang)") ]
            var urlRequest = URLRequest(url: urlComponents.url!)
            urlRequest.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequest.httpMethod = method.rawValue
            return urlRequest

        case let .acceptapplicantRouter(ApplicationId, Auth):
            urlComponents.queryItems = [URLQueryItem(name: "ApplicationId", value: "\(ApplicationId)")]
            var urlRequest = URLRequest(url: urlComponents.url!)
            urlRequest.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequest.httpMethod = method.rawValue
            return urlRequest
            
        case let .rejectapplicantRouter(ApplicationId, Auth):
            urlComponents.queryItems = [URLQueryItem(name: "ApplicationId", value: "\(ApplicationId)")]
            var urlRequest = URLRequest(url: urlComponents.url!)
            urlRequest.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
            urlRequest.httpMethod = method.rawValue
            return urlRequest
            
        }
        return urlRequests
        
    }
}

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary =
      try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
        throw NSError()
    }
    return dictionary
  }
}
