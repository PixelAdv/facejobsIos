//
//  getAvilableJobs.swift
//  Face Jobs
//
//  Created by Apple on 6/7/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
// AvilableJobsModel

import Foundation
struct AvilableJobsModel : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : [AvilableJobsModelData]?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent([AvilableJobsModelData].self, forKey: .data)
    }

}
struct AvilableJobsModelData : Codable {
    let jobId : Int?
    let title : String?
    let companyName : String?
    let image : String?
    let datePosted : String?
    let description : String?
    let jobType : String?
    let category : String?
    let numberOfJobDays : Int?
    let city : String?
    let paymentType : String?
    let isApplied : Bool?

    enum CodingKeys: String, CodingKey {

        case jobId = "JobId"
        case title = "Title"
        case companyName = "CompanyName"
        case image = "Image"
        case datePosted = "DatePosted"
        case description = "Description"
        case jobType = "JobType"
        case category = "Category"
        case numberOfJobDays = "NumberOfJobDays"
        case city = "City"
        case paymentType = "PaymentType"
        case isApplied = "IsApplied"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        jobId = try values.decodeIfPresent(Int.self, forKey: .jobId)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        companyName = try values.decodeIfPresent(String.self, forKey: .companyName)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        datePosted = try values.decodeIfPresent(String.self, forKey: .datePosted)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        jobType = try values.decodeIfPresent(String.self, forKey: .jobType)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        numberOfJobDays = try values.decodeIfPresent(Int.self, forKey: .numberOfJobDays)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        paymentType = try values.decodeIfPresent(String.self, forKey: .paymentType)
        isApplied = try values.decodeIfPresent(Bool.self, forKey: .isApplied)
    }

}
