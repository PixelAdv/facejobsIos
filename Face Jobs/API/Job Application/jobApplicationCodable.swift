//
//  jobApplicationCodable.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 8/27/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import Foundation
struct jobApplicationCodable : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : [DatajobApplicationCodable]?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent([DatajobApplicationCodable].self, forKey: .data)
    }

}
struct DatajobApplicationCodable : Codable {
    let jobApplicationId : Int?
    let employeeId : Int?
    let status : String?
    let rate : Double?
    let numberOfFinishedJobs : Int?
    let name : String?
    let Price: Double?
    let Image: String?
    
    enum CodingKeys: String, CodingKey {

        case jobApplicationId = "JobApplicationId"
        case employeeId = "EmployeeId"
        case status = "Status"
        case rate = "Rate"
        case numberOfFinishedJobs = "NumberOfFinishedJobs"
        case name = "Name"
        case Price = "Price"
        case Image = "Image"

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        jobApplicationId = try values.decodeIfPresent(Int.self, forKey: .jobApplicationId)
        employeeId = try values.decodeIfPresent(Int.self, forKey: .employeeId)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        rate = try values.decodeIfPresent(Double.self, forKey: .rate)
        numberOfFinishedJobs = try values.decodeIfPresent(Int.self, forKey: .numberOfFinishedJobs)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        Price = try values.decodeIfPresent(Double.self, forKey: .Price)
        Image = try values.decodeIfPresent(String.self, forKey: .Image)

    }

}
