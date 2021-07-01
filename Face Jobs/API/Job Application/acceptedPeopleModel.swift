//
//  acceptedPeopleModel.swift
//  Face Jobs
//
//  Created by Apple on 3/2/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import Foundation
struct acceptedPeopleModel : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : [acceptedPeopleModel_Data]?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent([acceptedPeopleModel_Data].self, forKey: .data)
    }
    

}

struct acceptedPeopleModel_Data : Codable {
    let jobApplicationId : Int?
    let employeeId : Int?
    let name : String?
    let image : String?
    let status : String?
    let isPaid : Bool?
    let prePrice : Double?
    let prePaymentType : String?
    let postPrice : String?
    let postPaymentType : String?
    let rate : Double?

    enum CodingKeys: String, CodingKey {

        case jobApplicationId = "JobApplicationId"
        case employeeId = "EmployeeId"
        case name = "Name"
        case image = "Image"
        case status = "Status"
        case isPaid = "IsPaid"
        case prePrice = "PrePrice"
        case prePaymentType = "PrePaymentType"
        case postPrice = "PostPrice"
        case postPaymentType = "PostPaymentType"
        case rate = "Rate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        jobApplicationId = try values.decodeIfPresent(Int.self, forKey: .jobApplicationId)
        employeeId = try values.decodeIfPresent(Int.self, forKey: .employeeId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        isPaid = try values.decodeIfPresent(Bool.self, forKey: .isPaid)
        prePrice = try values.decodeIfPresent(Double.self, forKey: .prePrice)
        prePaymentType = try values.decodeIfPresent(String.self, forKey: .prePaymentType)
        postPrice = try values.decodeIfPresent(String.self, forKey: .postPrice)
        postPaymentType = try values.decodeIfPresent(String.self, forKey: .postPaymentType)
        rate = try values.decodeIfPresent(Double.self, forKey: .rate)
    }

}
