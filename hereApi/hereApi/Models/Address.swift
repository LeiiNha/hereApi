//
//  Address.swift
//  hereApi
//
//  Created by Erica Geraldes on 16/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

struct Address: Codable {
    let text: String?
    let street: String?
    let postalCode: String?
    let district: String?
    let city: String?
    let county: String?
    let country: String?
    let countryCode: String?
}
