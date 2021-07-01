//
//  GetAddressCodable.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/29/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import Foundation
struct AddressCodable : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : DataAddressCodable?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent(DataAddressCodable.self, forKey: .data)
    }

}
struct DataAddressCodable : Codable {
    let addressAr : String?
    let addressEn : String?

    enum CodingKeys: String, CodingKey {

        case addressAr = "AddressAr"
        case addressEn = "AddressEn"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        addressAr = try values.decodeIfPresent(String.self, forKey: .addressAr)
        addressEn = try values.decodeIfPresent(String.self, forKey: .addressEn)
    }

}
