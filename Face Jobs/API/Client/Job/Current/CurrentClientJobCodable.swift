//
//  CurrentClientJobCodable.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 7/6/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import Foundation
struct CurrentClientJobCodable : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : [DataCurrentClientJobCodable]?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent([DataCurrentClientJobCodable].self, forKey: .data)
    }

}
struct DataCurrentClientJobCodable : Codable {
    let imageUrl : String?
    let jobTitle : String?
    let city : String?
    let jobType : String?
    let isOnline : Bool?
    let numberOfAcceptedPeople : Int?
    let numberOfApplications : Int?
    let JobId: Int?
    
    enum CodingKeys: String, CodingKey {

        case imageUrl = "ImageUrl"
        case jobTitle = "JobTitle"
        case city = "City"
        case jobType = "JobType"
        case isOnline = "IsOnline"
        case numberOfAcceptedPeople = "NumberOfAcceptedPeople"
        case numberOfApplications = "NumberOfApplications"
        case JobId = "JobId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        jobTitle = try values.decodeIfPresent(String.self, forKey: .jobTitle)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        jobType = try values.decodeIfPresent(String.self, forKey: .jobType)
        isOnline = try values.decodeIfPresent(Bool.self, forKey: .isOnline)
        numberOfAcceptedPeople = try values.decodeIfPresent(Int.self, forKey: .numberOfAcceptedPeople)
        numberOfApplications = try values.decodeIfPresent(Int.self, forKey: .numberOfApplications)
        JobId = try values.decodeIfPresent(Int.self, forKey: .JobId)

    }
    

}
