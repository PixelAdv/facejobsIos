//
//  EditJobModel.swift
//  Face Jobs
//
//  Created by Apple on 5/26/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import Foundation
struct EditJobModel : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : EditJobModelData?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent(EditJobModelData.self, forKey: .data)
    }

}
struct DateTimes : Codable {
    let day : String?
    let timeFrom : String?
    let timeTo : String?

    enum CodingKeys: String, CodingKey {

        case day = "Day"
        case timeFrom = "TimeFrom"
        case timeTo = "TimeTo"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        day = try values.decodeIfPresent(String.self, forKey: .day)
        timeFrom = try values.decodeIfPresent(String.self, forKey: .timeFrom)
        timeTo = try values.decodeIfPresent(String.self, forKey: .timeTo)
    }

}

//struct PaymentMethods : Codable {
//    let id : Int?
//    let name : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "Id"
//        case name = "Name"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//    }
//
//}
//struct PriceTypes : Codable {
//    let id : Int?
//    let name : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "Id"
//        case name = "Name"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//    }
//
//}
//struct Types : Codable {
//    let id : Int?
//    let name : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "Id"
//        case name = "Name"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//    }
//
//}
struct Addresses : Codable {
    let countryId : Int?
    let cityId : Int?
    let areaId : Int?
    let postalCode : String?
    let street : String?
    let details : String?
    let latitude : Double?
    let longitude : Double?

    enum CodingKeys: String, CodingKey {

        case countryId = "CountryId"
        case cityId = "CityId"
        case areaId = "AreaId"
        case postalCode = "PostalCode"
        case street = "Street"
        case details = "Details"
        case latitude = "Latitude"
        case longitude = "Longitude"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        countryId = try values.decodeIfPresent(Int.self, forKey: .countryId)
        cityId = try values.decodeIfPresent(Int.self, forKey: .cityId)
        areaId = try values.decodeIfPresent(Int.self, forKey: .areaId)
        postalCode = try values.decodeIfPresent(String.self, forKey: .postalCode)
        street = try values.decodeIfPresent(String.self, forKey: .street)
        details = try values.decodeIfPresent(String.self, forKey: .details)
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
    }

}
//struct Categories : Codable {
//    let id : Int?
//    let name : String?
//    let description : String?
//    let paymentMethod : Int?
//    let creditType : Int?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "Id"
//        case name = "Name"
//        case description = "Description"
//        case paymentMethod = "PaymentMethod"
//        case creditType = "CreditType"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        description = try values.decodeIfPresent(String.self, forKey: .description)
//        paymentMethod = try values.decodeIfPresent(Int.self, forKey: .paymentMethod)
//        creditType = try values.decodeIfPresent(Int.self, forKey: .creditType)
//    }
//
//}
//struct Countries : Codable {
//    let id : Int?
//    let name : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "Id"
//        case name = "Name"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//    }
//
//}
struct CurrentPhotos : Codable {
    let imageUrl : String?
    let imageId : Int?

    enum CodingKeys: String, CodingKey {

        case imageUrl = "ImageUrl"
        case imageId = "ImageId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        imageId = try values.decodeIfPresent(Int.self, forKey: .imageId)
    }

}
struct EditJobModelData : Codable {
    let types : [Types]?
    let categories : [Categories]?
    let paymentMethods : [PaymentMethods]?
    let countries : [Countries]?
    let priceTypes : [PriceTypes]?
    let title : String?
    let jobType : Int?
    let categoryId : Int?
    let description : String?
    let dateTimes : [DateTimes]?
    let isBreakAvailable : Bool?
    let isBreakPaid : Bool?
    let paymentType : Int?
    let price : Double?
    let numberOfEmployees : Int?
    let paymentMethod : Int?
    let workingHoursDescription : String?
    let currentPhotos : [CurrentPhotos]?
    let addresses : [Addresses]?
    let isOnline : Bool?
    let jobId : Int?

    enum CodingKeys: String, CodingKey {

        case types = "Types"
        case categories = "Categories"
        case paymentMethods = "PaymentMethods"
        case countries = "Countries"
        case priceTypes = "PriceTypes"
        case title = "Title"
        case jobType = "JobType"
        case categoryId = "CategoryId"
        case description = "Description"
        case dateTimes = "DateTimes"
        case isBreakAvailable = "IsBreakAvailable"
        case isBreakPaid = "IsBreakPaid"
        case paymentType = "PaymentType"
        case price = "Price"
        case numberOfEmployees = "NumberOfEmployees"
        case paymentMethod = "PaymentMethod"
        case workingHoursDescription = "WorkingHoursDescription"
        case currentPhotos = "CurrentPhotos"
        case addresses = "Addresses"
        case isOnline = "IsOnline"
        case jobId = "JobId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        types = try values.decodeIfPresent([Types].self, forKey: .types)
        categories = try values.decodeIfPresent([Categories].self, forKey: .categories)
        paymentMethods = try values.decodeIfPresent([PaymentMethods].self, forKey: .paymentMethods)
        countries = try values.decodeIfPresent([Countries].self, forKey: .countries)
        priceTypes = try values.decodeIfPresent([PriceTypes].self, forKey: .priceTypes)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        jobType = try values.decodeIfPresent(Int.self, forKey: .jobType)
        categoryId = try values.decodeIfPresent(Int.self, forKey: .categoryId)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        dateTimes = try values.decodeIfPresent([DateTimes].self, forKey: .dateTimes)
        isBreakAvailable = try values.decodeIfPresent(Bool.self, forKey: .isBreakAvailable)
        isBreakPaid = try values.decodeIfPresent(Bool.self, forKey: .isBreakPaid)
        paymentType = try values.decodeIfPresent(Int.self, forKey: .paymentType)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        numberOfEmployees = try values.decodeIfPresent(Int.self, forKey: .numberOfEmployees)
        paymentMethod = try values.decodeIfPresent(Int.self, forKey: .paymentMethod)
        workingHoursDescription = try values.decodeIfPresent(String.self, forKey: .workingHoursDescription)
        currentPhotos = try values.decodeIfPresent([CurrentPhotos].self, forKey: .currentPhotos)
        addresses = try values.decodeIfPresent([Addresses].self, forKey: .addresses)
        isOnline = try values.decodeIfPresent(Bool.self, forKey: .isOnline)
        jobId = try values.decodeIfPresent(Int.self, forKey: .jobId)
    }

}
