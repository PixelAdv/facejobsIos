//
//  GalleryCodable.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/30/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import Foundation
struct GalleryCodable : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : [DataGalleryCodable]?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent([DataGalleryCodable].self, forKey: .data)
    }

}
struct DataGalleryCodable : Codable {
    let imageUrl : String?
    let galleryType : Int?
    let id : Int?

    enum CodingKeys: String, CodingKey {

        case imageUrl = "ImageUrl"
        case galleryType = "GalleryType"
        case id = "Id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        galleryType = try values.decodeIfPresent(Int.self, forKey: .galleryType)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
    }

}
