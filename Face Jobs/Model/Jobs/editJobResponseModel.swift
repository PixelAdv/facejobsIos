//
//  editJobResponseModel.swift
//  Face Jobs
//
//  Created by Apple on 5/26/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import Foundation
struct editJobResponseModel : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : String?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent(String.self, forKey: .data)
    }

}
