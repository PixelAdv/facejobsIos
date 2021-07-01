//
//  CityCodable.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 8/30/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import Foundation
struct CityCodable : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : [DataCityCodable]?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent([DataCityCodable].self, forKey: .data)
    }

}

struct DataCityCodable : Codable {
    let id : Int?
    let countryId : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "Id"
        case countryId = "CountryId"
        case name = "Name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        countryId = try values.decodeIfPresent(Int.self, forKey: .countryId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
