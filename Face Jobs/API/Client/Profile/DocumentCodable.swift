//
//  DocumentCodable.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/30/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import Foundation
struct DocumentCodable : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : [DataDocumentCodable]?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent([DataDocumentCodable].self, forKey: .data)
    }

}
struct DataDocumentCodable : Codable {
    let id : Int?
    let fileName : String?
    let filePath : String?
    let fileType : Int?

    enum CodingKeys: String, CodingKey {

        case id = "Id"
        case fileName = "FileName"
        case filePath = "FilePath"
        case fileType = "FileType"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        fileName = try values.decodeIfPresent(String.self, forKey: .fileName)
        filePath = try values.decodeIfPresent(String.self, forKey: .filePath)
        fileType = try values.decodeIfPresent(Int.self, forKey: .fileType)
    }

}
