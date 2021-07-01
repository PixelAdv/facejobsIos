//
//  EmployeeJobsModel.swift
//  Face Jobs
//
//  Created by Apple on 3/10/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import Foundation
struct EmployeeJobsModel: Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : [EmployeeJobsModelData]?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent([EmployeeJobsModelData].self, forKey: .data)
    }

}

struct EmployeeJobsModelData : Codable {
    let jobId : Int?
    let companyLogo : String?
    let companyName : String?
    let jobTitle : String?
    let jobDate : String?
    let jobDescription : String?
    let price : Double?
    let isEditable : Bool?
    let isViewed : Bool?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case jobId = "JobId"
        case companyLogo = "CompanyLogo"
        case companyName = "CompanyName"
        case jobTitle = "JobTitle"
        case jobDate = "JobDate"
        case jobDescription = "JobDescription"
        case price = "Price"
        case isEditable = "IsEditable"
        case isViewed = "IsViewed"
        case status = "Status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        jobId = try values.decodeIfPresent(Int.self, forKey: .jobId)
        companyLogo = try values.decodeIfPresent(String.self, forKey: .companyLogo)
        companyName = try values.decodeIfPresent(String.self, forKey: .companyName)
        jobTitle = try values.decodeIfPresent(String.self, forKey: .jobTitle)
        jobDate = try values.decodeIfPresent(String.self, forKey: .jobDate)
        jobDescription = try values.decodeIfPresent(String.self, forKey: .jobDescription)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        isEditable = try values.decodeIfPresent(Bool.self, forKey: .isEditable)
        isViewed = try values.decodeIfPresent(Bool.self, forKey: .isViewed)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
