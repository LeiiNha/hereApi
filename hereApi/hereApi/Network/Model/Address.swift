//
//  Address.swift
//  hereApi
//
//  Created by Erica Geraldes on 16/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

struct Address {
    let text: String?
    let street: String?
    let postalCode: String?
    let district: String?
    let city: String?
    let county: String?
    let country: String?
    let countryCode: String?
    
    private enum CodingKeys: String, CodingKey {
        case text
        case street
        case postalCode
        case district
        case city
        case county
        case country
        case countryCode
    }
}

extension Address: Decodable {
    init(decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        text = try values.decodeIfPresent(String.self, forKey: .text)
        street = try values.decodeIfPresent(String.self, forKey: .street)
        postalCode = try values.decodeIfPresent(String.self, forKey: .postalCode)
        district = try values.decodeIfPresent(String.self, forKey: .district)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        county = try values.decodeIfPresent(String.self, forKey: .county)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
    }
}
