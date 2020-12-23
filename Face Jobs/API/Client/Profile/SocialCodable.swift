//
//  SocialCodable.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/30/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import Foundation
struct SocialCodable : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : DataSocialCodable?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent(DataSocialCodable.self, forKey: .data)
    }

}
struct DataSocialCodable : Codable {
    let facebook : String?
    let twitter : String?
    let instagram : String?
    let linkedIn : String?
    let website : String?
    let other : String?

    enum CodingKeys: String, CodingKey {

        case facebook = "Facebook"
        case twitter = "Twitter"
        case instagram = "Instagram"
        case linkedIn = "LinkedIn"
        case website = "Website"
        case other = "Other"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        facebook = try values.decodeIfPresent(String.self, forKey: .facebook)
        twitter = try values.decodeIfPresent(String.self, forKey: .twitter)
        instagram = try values.decodeIfPresent(String.self, forKey: .instagram)
        linkedIn = try values.decodeIfPresent(String.self, forKey: .linkedIn)
        website = try values.decodeIfPresent(String.self, forKey: .website)
        other = try values.decodeIfPresent(String.self, forKey: .other)
    }

}
