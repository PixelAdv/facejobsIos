//
//  loginCodable.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/24/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import Foundation
struct loginCodable : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : DataloginCodable?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent(DataloginCodable.self, forKey: .data)
    }

}
struct DataloginCodable : Codable {
    let token : String?
    let type : String?
    let typeId : Int?
    let refreshToken : String?

    enum CodingKeys: String, CodingKey {

        case token = "Token"
        case type = "Type"
        case typeId = "TypeId"
        case refreshToken = "RefreshToken"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        typeId = try values.decodeIfPresent(Int.self, forKey: .typeId)
        refreshToken = try values.decodeIfPresent(String.self, forKey: .refreshToken)
    }

}
