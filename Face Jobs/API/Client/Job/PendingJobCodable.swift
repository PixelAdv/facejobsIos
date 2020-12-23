//
//  PendingJobCodable.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 7/13/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import Foundation
struct PendingJobCodable : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : [DataPendingJobCodable]?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent([DataPendingJobCodable].self, forKey: .data)
    }

}
struct DataPendingJobCodable : Codable {
    let imageUrl : String?
    let jobTitle : String?
    let city : String?
    let jobType : String?
    let isOnline : Bool?
    let JobId: Int?
    
    enum CodingKeys: String, CodingKey {

        case imageUrl = "ImageUrl"
        case jobTitle = "JobTitle"
        case city = "City"
        case jobType = "JobType"
        case isOnline = "IsOnline"
        case JobId = "JobId"

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        jobTitle = try values.decodeIfPresent(String.self, forKey: .jobTitle)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        jobType = try values.decodeIfPresent(String.self, forKey: .jobType)
        isOnline = try values.decodeIfPresent(Bool.self, forKey: .isOnline)
        JobId = try values.decodeIfPresent(Int.self, forKey: .JobId)

    }
}
struct GetEditJopPageDataCodable:Codable{
    let ErrorCode:Int
    let ErrorMessage:String
    let Data:JopData?
    struct JopData:Codable {
        let JobId:Int
        let IsOnline:Bool
        let Title:String
        let JobType:Int
        let CategoryId:Int
        let Description:String
        let IsBreakAvailable:Bool
        let IsBreakPaid:Bool
        let PaymentType:Int
        let Price:Double
        let NumberOfEmployees:Int
        let PaymentMethod:Int
        let WorkingHoursDescription:String
        let Types:[JopType]
        struct JopType:Codable {
            let Id:Int
            let Name:String
        }
        let Categories:[JopCategory]
        struct JopCategory:Codable {
            let Id:Int
            let Name:String
            let Description:String
            let PaymentMethod:Int
            let CreditType:Int
        }
        let PaymentMethods:[JopPaymentMethods]
        struct JopPaymentMethods:Codable {
            let Id:Int
            let Name:String
        }
        let Countries:[JopCountries]
        struct JopCountries:Codable {
            let Id:Int
            let Name:String
        }
        let PriceTypes:[JopPriceTypes]
        struct JopPriceTypes:Codable {
            let Id:Int
            let Name:String
        }
        let DateTimes:[JopDateTimes]
        struct JopDateTimes:Codable {
            let Day:String
            let TimeFrom:String
            let TimeTo:String
        }
        let CurrentPhotos:[JopCurrentPhotos]
        struct JopCurrentPhotos:Codable {
            let ImageUrl:String
            let ImageId:Int
        }
        let Addresses:[JopAddresses]
        struct JopAddresses:Codable {
            let CountryId:Int
            let CityId:Int
            let AreaId:Int
            let PostalCode:String
            let Street:String
            let Details:String
            let Latitude:Double
            let Longitude:Double
        }
    }
}
struct DeleteJopCodable:Codable {
    let ErrorCode:Int
    let ErrorMessage:String
}
