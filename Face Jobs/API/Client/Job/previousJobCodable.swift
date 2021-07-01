//
//  PreviousCodable.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 7/21/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import Foundation
struct previousJobCodable : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : [DatapreviousJobCodable]?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent([DatapreviousJobCodable].self, forKey: .data)
    }

}
struct DatapreviousJobCodable : Codable {
    let imageUrl : String?
    let jobTitle : String?
    let city : String?
    let jobType : String?
    let isOnline : Bool?
    let status : String?
    let JobId:Int?
    enum CodingKeys: String, CodingKey {

        case imageUrl = "ImageUrl"
        case jobTitle = "JobTitle"
        case city = "City"
        case jobType = "JobType"
        case isOnline = "IsOnline"
        case status = "Status"
        case JobId = "JobId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        jobTitle = try values.decodeIfPresent(String.self, forKey: .jobTitle)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        jobType = try values.decodeIfPresent(String.self, forKey: .jobType)
        isOnline = try values.decodeIfPresent(Bool.self, forKey: .isOnline)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        JobId = try values.decodeIfPresent(Int.self, forKey: .JobId)
    }

}
