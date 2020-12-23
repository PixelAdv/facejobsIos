//
//  MessageCode.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/29/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import Foundation
struct MessageCode : Codable {
    let errorCode : Int?
    let errorMessage : String?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
    }

}
import Foundation
struct PublicMessageCode : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data: DataPublicMessageCode?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent(DataPublicMessageCode.self, forKey: .data)
    }

}
struct DataPublicMessageCode : Codable {
    let ProfilePercentage : Int?

    enum CodingKeys: String, CodingKey {

        case ProfilePercentage = "ProfilePercentage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ProfilePercentage = try values.decodeIfPresent(Int.self, forKey: .ProfilePercentage) 
    }

}
