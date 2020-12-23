//
//  File.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 7/1/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import Foundation
struct VisibilityCodable : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : DataVisibilityCodable?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent(DataVisibilityCodable.self, forKey: .data)
    }

}
struct DataVisibilityCodable : Codable {
    let isVisible : Bool?

    enum CodingKeys: String, CodingKey {

        case isVisible = "IsVisible"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isVisible = try values.decodeIfPresent(Bool.self, forKey: .isVisible)
    }

}
