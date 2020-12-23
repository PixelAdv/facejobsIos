//
//  File.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/29/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import Foundation

struct ProfileCodable : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : DataProfileCodable?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent(DataProfileCodable.self, forKey: .data)
    }

}
struct DataProfileCodable : Codable {
    let imageUrl : String?
    let email : String?
    let phone : String?
    let landLine : String?
    let companyName : String?
    let rate : Double?
    let wallet : Double?
    let coins : Double?
    let numberOfWarnings : Int?
    let specializationDetails : String?
    let profileCompletenessPercentage : Int?
    let isVerified : Bool?
    let images : [String]?

    enum CodingKeys: String, CodingKey {

        case imageUrl = "ImageUrl"
        case email = "Email"
        case phone = "Phone"
        case landLine = "LandLine"
        case companyName = "CompanyName"
        case rate = "Rate"
        case wallet = "Wallet"
        case coins = "Coins"
        case numberOfWarnings = "NumberOfWarnings"
        case specializationDetails = "SpecializationDetails"
        case profileCompletenessPercentage = "ProfileCompletenessPercentage"
        case isVerified = "IsVerified"
        case images = "Images"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        landLine = try values.decodeIfPresent(String.self, forKey: .landLine)
        companyName = try values.decodeIfPresent(String.self, forKey: .companyName)
        rate = try values.decodeIfPresent(Double.self, forKey: .rate)
        wallet = try values.decodeIfPresent(Double.self, forKey: .wallet)
        coins = try values.decodeIfPresent(Double.self, forKey: .coins)
        numberOfWarnings = try values.decodeIfPresent(Int.self, forKey: .numberOfWarnings)
        specializationDetails = try values.decodeIfPresent(String.self, forKey: .specializationDetails)
        profileCompletenessPercentage = try values.decodeIfPresent(Int.self, forKey: .profileCompletenessPercentage)
        isVerified = try values.decodeIfPresent(Bool.self, forKey: .isVerified)
        images = try values.decodeIfPresent([String].self, forKey: .images)
    }

}
