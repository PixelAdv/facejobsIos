//
//  ExperienceModel.swift
//  Face Jobs
//
//  Created by Apple on 3/7/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import Foundation
struct experienceModel : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : experienceModelData?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent(experienceModelData.self, forKey: .data)
    }

}
struct experienceModelData : Codable {
    let experienceAr : String?
    let experienceEn : String?

    enum CodingKeys: String, CodingKey {

        case experienceAr = "ExperienceAr"
        case experienceEn = "ExperienceEn"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        experienceAr = try values.decodeIfPresent(String.self, forKey: .experienceAr)
        experienceEn = try values.decodeIfPresent(String.self, forKey: .experienceEn)
    }

}
