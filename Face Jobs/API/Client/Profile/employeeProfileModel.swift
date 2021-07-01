//
//  employeeProfileModel.swift
//  Face Jobs
//
//  Created by Apple on 6/9/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import Foundation
struct employeeProfileModel : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : employeeProfileData?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent(employeeProfileData.self, forKey: .data)
    }

}
struct employeeProfileData : Codable {
    let imageUrl : String?
    let email : String?
    let phone : String?
    let rate : Double?
    let wallet : Double?
    let coins : Double?
    let age : Int?
    let numberOfWarnings : Int?
    let profileCompletenessPercentage : Int?
    let isVerified : Bool?
    let images : [String]?

    enum CodingKeys: String, CodingKey {

        case imageUrl = "ImageUrl"
        case email = "Email"
        case phone = "Phone"
        case rate = "Rate"
        case wallet = "Wallet"
        case coins = "Coins"
        case age = "Age"
        case numberOfWarnings = "NumberOfWarnings"
        case profileCompletenessPercentage = "ProfileCompletenessPercentage"
        case isVerified = "IsVerified"
        case images = "Images"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        rate = try values.decodeIfPresent(Double.self, forKey: .rate)
        wallet = try values.decodeIfPresent(Double.self, forKey: .wallet)
        coins = try values.decodeIfPresent(Double.self, forKey: .coins)
        age = try values.decodeIfPresent(Int.self, forKey: .age)
        numberOfWarnings = try values.decodeIfPresent(Int.self, forKey: .numberOfWarnings)
        profileCompletenessPercentage = try values.decodeIfPresent(Int.self, forKey: .profileCompletenessPercentage)
        isVerified = try values.decodeIfPresent(Bool.self, forKey: .isVerified)
        images = try values.decodeIfPresent([String].self, forKey: .images)
    }

}
