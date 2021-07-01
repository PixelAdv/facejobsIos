//
//  AreaCodable.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 8/30/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import Foundation
struct AreaCodable : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : [DataAreaCodable]?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent([DataAreaCodable].self, forKey: .data)
    }

}

struct DataAreaCodable : Codable {
    let id : Int?
    let cityId : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "Id"
        case cityId = "CityId"
        case name = "Name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        cityId = try values.decodeIfPresent(Int.self, forKey: .cityId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
