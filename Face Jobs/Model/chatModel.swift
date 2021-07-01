//
//  chatModel.swift
//  Face Jobs
//
//  Created by Apple on 3/3/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import Foundation
struct chatModelClient : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : [ChatData]?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent([ChatData].self, forKey: .data)
    }

}
struct ChatData : Codable {
    let name : String?
    let imageUrl : String?
    enum CodingKeys: String, CodingKey {

        case name = "Name"
        case imageUrl = "ImageUrl"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
    }

}
