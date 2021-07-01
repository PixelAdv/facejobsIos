//
//  filterDataModel.swift
//  Face Jobs
//
//  Created by Apple on 6/22/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import Foundation
struct filterDataModel : Codable {
    let errorCode : Int?
    let errorMessage : String?
    let data : filterModel_Data?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent(filterModel_Data.self, forKey: .data)
    }

}

struct filterModel_Data : Codable {
    let categories : [Categories]?
    let types : [Types]?
    let countires : [Countires]?
    let cities : [Cities]?
    let areas : [Areas]?

    enum CodingKeys: String, CodingKey {

        case categories = "Categories"
        case types = "Types"
        case countires = "Countires"
        case cities = "Cities"
        case areas = "Areas"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categories = try values.decodeIfPresent([Categories].self, forKey: .categories)
        types = try values.decodeIfPresent([Types].self, forKey: .types)
        countires = try values.decodeIfPresent([Countires].self, forKey: .countires)
        cities = try values.decodeIfPresent([Cities].self, forKey: .cities)
        areas = try values.decodeIfPresent([Areas].self, forKey: .areas)
    }

}
struct Countires : Codable {
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
struct Areas : Codable {
    let id : Int?
    let cityId : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "Id"
        case cityId = "CityId"
        case name = "Name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        cityId = try values.decodeIfPresent(Int.self, forKey: .cityId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}

struct Cities : Codable {
    let id : Int?
    let countryId : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "Id"
        case countryId = "CountryId"
        case name = "Name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        countryId = try values.decodeIfPresent(Int.self, forKey: .countryId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
