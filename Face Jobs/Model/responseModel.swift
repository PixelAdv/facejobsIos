//
//  responseModel.swift
//  Face Jobs
//
//  Created by Apple on 5/25/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import Foundation
struct responseModel : Codable {
    let response : String?
    enum CodingKeys: String, CodingKey {

        case response = "response"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        response = try values.decodeIfPresent(String.self, forKey: .response)
    }

}
