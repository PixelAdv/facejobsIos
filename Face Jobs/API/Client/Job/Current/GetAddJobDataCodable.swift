//
//  GetAddJobDataCodable.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 7/6/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import Foundation

struct GetAddJobDataCodable : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : DataGetAddJobDataCodable?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent(DataGetAddJobDataCodable.self, forKey: .data)
    }

}
struct DataGetAddJobDataCodable : Codable {
    let types : [Types]?
    let categories : [Categories]?
    let paymentMethods : [PaymentMethods]?
    let countries : [Countries]?
    let priceTypes : [PriceTypes]?

    enum CodingKeys: String, CodingKey {

        case types = "Types"
        case categories = "Categories"
        case paymentMethods = "PaymentMethods"
        case countries = "Countries"
        case priceTypes = "PriceTypes"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        types = try values.decodeIfPresent([Types].self, forKey: .types)
        categories = try values.decodeIfPresent([Categories].self, forKey: .categories)
        paymentMethods = try values.decodeIfPresent([PaymentMethods].self, forKey: .paymentMethods)
        countries = try values.decodeIfPresent([Countries].self, forKey: .countries)
        priceTypes = try values.decodeIfPresent([PriceTypes].self, forKey: .priceTypes)
    }

}
struct Types : Codable {
    var id : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "Id"
        case name = "Name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
struct Categories : Codable {
    let id : Int?
    let name : String?
    let description : String?
    let paymentMethod : Int?
    let creditType : Int?

    enum CodingKeys: String, CodingKey {

        case id = "Id"
        case name = "Name"
        case description = "Description"
        case paymentMethod = "PaymentMethod"
        case creditType = "CreditType"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        paymentMethod = try values.decodeIfPresent(Int.self, forKey: .paymentMethod)
        creditType = try values.decodeIfPresent(Int.self, forKey: .creditType)
    }

}
struct PaymentMethods : Codable {
    let id : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "Id"
        case name = "Name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
struct Countries : Codable {
    let id : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "Id"
        case name = "Name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
struct PriceTypes : Codable {
    let id : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "Id"
        case name = "Name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
