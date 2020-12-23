//
//  AddJobCodable.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 8/6/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import Foundation
struct DateTimesCodable : Codable {
    let Day : String?
    let TimeFrom : String?
    let TimeTo : String?

    enum CodingKeys: String, CodingKey {

        case Day = "Day"
        case TimeFrom = "TimeFrom"
        case TimeTo = "TimeTo"

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Day = try values.decodeIfPresent(String.self, forKey: .Day)
        TimeFrom = try values.decodeIfPresent(String.self, forKey: .TimeFrom)
        TimeTo = try values.decodeIfPresent(String.self, forKey: .TimeTo)
    }
    init(Day: String, TimeFrom: String, TimeTo: String) {
        self.Day = Day
        self.TimeFrom = TimeFrom
        self.TimeTo = TimeTo
    }

}
struct AddressCodableJob : Codable {
    let CountryId : Int?
    let CityId : Int?
    let AreaId : Int?
    let PostalCode : String?
    let Street : String?
    let Details : String?
    let Latitude : Double?
    let Longitude : Double?
    enum CodingKeys: String, CodingKey {

        case CountryId = "CountryId"
        case CityId = "CityId"
        case AreaId = "AreaId"
        case PostalCode = "PostalCode"
        case Street = "Street"
        case Details = "Details"
        case Latitude = "Latitude"
        case Longitude = "Longitude"

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        CountryId = try values.decodeIfPresent(Int.self, forKey: .CountryId)
        CityId = try values.decodeIfPresent(Int.self, forKey: .CityId)
        AreaId = try values.decodeIfPresent(Int.self, forKey: .AreaId)
        PostalCode = try values.decodeIfPresent(String.self, forKey: .PostalCode)
        Street = try values.decodeIfPresent(String.self, forKey: .Street)
        Details = try values.decodeIfPresent(String.self, forKey: .Details)
        Latitude = try values.decodeIfPresent(Double.self, forKey: .Latitude)
        Longitude = try values.decodeIfPresent(Double.self, forKey: .Latitude)
    }

    init(CountryId: Int, CityId: Int, AreaId: Int, PostalCode: String, Street: String, Details: String, Latitude:  Double, Longitude: Double){
        self.CountryId = CountryId
        self.CityId = CityId
        self.AreaId = AreaId
        self.PostalCode = PostalCode
        self.Street = Street
        self.Details = Details
        self.Latitude = Latitude
        self.Longitude = Longitude
    }
}
