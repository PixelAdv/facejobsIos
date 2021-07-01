//
//  JobDetailsModel.swift
//  Face Jobs
//
//  Created by Apple on 6/10/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import Foundation
struct JobDetailsModel : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : JobDetailsModelData?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent(JobDetailsModelData.self, forKey: .data)
    }

}
struct JobTimes : Codable {
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
struct JobDetailsModelData : Codable {
    let jobId : Int?
    let jobTitle : String?
    let companyImage : String?
    let companyName : String?
    let jobPrice : Double?
    let jobPaymentType : String?
    let numberOfJobDays : Int?
    let isJobOnline : Bool?
    let createDate : String?
    let jobType : String?
    let jobCategory : String?
    let jobDescription : String?
    let jobTimes : [JobTimes]?
    let isJobHasBreak : Bool?
    let isJobBreakPaid : Bool?
    let expectedWorkingHours : Int?
    let workingHoursDescription : String?
    let paymentMethod : String?
    let numberOfRequiredPeople : Int?
    let applicantPrice : Double?
    let applicantPaymentType : String?
    let isApplicantAbleToEditOrApply : Bool?
    let isViewed : Bool?
    let images : [String]?
    let addresses : [Addresses2]?
    let allPriceTypes : [AllPriceTypes]?

    enum CodingKeys: String, CodingKey {

        case jobId = "JobId"
        case jobTitle = "JobTitle"
        case companyImage = "CompanyImage"
        case companyName = "CompanyName"
        case jobPrice = "JobPrice"
        case jobPaymentType = "JobPaymentType"
        case numberOfJobDays = "NumberOfJobDays"
        case isJobOnline = "IsJobOnline"
        case createDate = "CreateDate"
        case jobType = "JobType"
        case jobCategory = "JobCategory"
        case jobDescription = "JobDescription"
        case jobTimes = "JobTimes"
        case isJobHasBreak = "IsJobHasBreak"
        case isJobBreakPaid = "IsJobBreakPaid"
        case expectedWorkingHours = "ExpectedWorkingHours"
        case workingHoursDescription = "WorkingHoursDescription"
        case paymentMethod = "PaymentMethod"
        case numberOfRequiredPeople = "NumberOfRequiredPeople"
        case applicantPrice = "ApplicantPrice"
        case applicantPaymentType = "ApplicantPaymentType"
        case isApplicantAbleToEditOrApply = "IsApplicantAbleToEditOrApply"
        case isViewed = "IsViewed"
        case images = "Images"
        case addresses = "Addresses"
        case allPriceTypes = "AllPriceTypes"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        jobId = try values.decodeIfPresent(Int.self, forKey: .jobId)
        jobTitle = try values.decodeIfPresent(String.self, forKey: .jobTitle)
        companyImage = try values.decodeIfPresent(String.self, forKey: .companyImage)
        companyName = try values.decodeIfPresent(String.self, forKey: .companyName)
        jobPrice = try values.decodeIfPresent(Double.self, forKey: .jobPrice)
        jobPaymentType = try values.decodeIfPresent(String.self, forKey: .jobPaymentType)
        numberOfJobDays = try values.decodeIfPresent(Int.self, forKey: .numberOfJobDays)
        isJobOnline = try values.decodeIfPresent(Bool.self, forKey: .isJobOnline)
        createDate = try values.decodeIfPresent(String.self, forKey: .createDate)
        jobType = try values.decodeIfPresent(String.self, forKey: .jobType)
        jobCategory = try values.decodeIfPresent(String.self, forKey: .jobCategory)
        jobDescription = try values.decodeIfPresent(String.self, forKey: .jobDescription)
        jobTimes = try values.decodeIfPresent([JobTimes].self, forKey: .jobTimes)
        isJobHasBreak = try values.decodeIfPresent(Bool.self, forKey: .isJobHasBreak)
        isJobBreakPaid = try values.decodeIfPresent(Bool.self, forKey: .isJobBreakPaid)
        expectedWorkingHours = try values.decodeIfPresent(Int.self, forKey: .expectedWorkingHours)
        workingHoursDescription = try values.decodeIfPresent(String.self, forKey: .workingHoursDescription)
        paymentMethod = try values.decodeIfPresent(String.self, forKey: .paymentMethod)
        numberOfRequiredPeople = try values.decodeIfPresent(Int.self, forKey: .numberOfRequiredPeople)
        applicantPrice = try values.decodeIfPresent(Double.self, forKey: .applicantPrice)
        applicantPaymentType = try values.decodeIfPresent(String.self, forKey: .applicantPaymentType)
        isApplicantAbleToEditOrApply = try values.decodeIfPresent(Bool.self, forKey: .isApplicantAbleToEditOrApply)
        isViewed = try values.decodeIfPresent(Bool.self, forKey: .isViewed)
        images = try values.decodeIfPresent([String].self, forKey: .images)
        addresses = try values.decodeIfPresent([Addresses2].self, forKey: .addresses)
        allPriceTypes = try values.decodeIfPresent([AllPriceTypes].self, forKey: .allPriceTypes)
    }

}
struct AllPriceTypes : Codable {
    let id : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "Id"
        case name = "Name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
struct Addresses2 : Codable {
    let country : String?
    let city : String?
    let area : String?
    let postalCode : String?
    let streetNumber : String?
    let details : String?
    let latitude : Double?
    let longitude : Double?

    enum CodingKeys: String, CodingKey {

        case country = "Country"
        case city = "City"
        case area = "Area"
        case postalCode = "PostalCode"
        case streetNumber = "StreetNumber"
        case details = "Details"
        case latitude = "Latitude"
        case longitude = "Longitude"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        area = try values.decodeIfPresent(String.self, forKey: .area)
        postalCode = try values.decodeIfPresent(String.self, forKey: .postalCode)
        streetNumber = try values.decodeIfPresent(String.self, forKey: .streetNumber)
        details = try values.decodeIfPresent(String.self, forKey: .details)
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
    }

}
