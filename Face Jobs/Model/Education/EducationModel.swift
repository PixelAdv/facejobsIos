//
//  EducationModel.swift
//  Face Jobs
//
//  Created by Apple on 3/7/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import Foundation
struct EducationModel : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : EducationModelData?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent(EducationModelData.self, forKey: .data)
    }

}

struct EducationModelData : Codable {
    let educationAr : String?
    let educationEn : String?

    enum CodingKeys: String, CodingKey {

        case educationAr = "EducationAr"
        case educationEn = "EducationEn"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        educationAr = try values.decodeIfPresent(String.self, forKey: .educationAr)
        educationEn = try values.decodeIfPresent(String.self, forKey: .educationEn)
    }

}
